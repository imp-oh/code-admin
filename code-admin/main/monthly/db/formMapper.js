
const { sqlFunKey, handlePage } = require('@/utils/mysql')

let selectFormList = (rows = {}) => {
    let sqlString = "SELECT t.*,d.leader,u.nick_name FROM monthly_table t LEFT JOIN sys_user u LEFT JOIN sys_dept d ON d.dept_id = u.dept_id ON u.user_id = t.user_id where u.del_flag = '0' "
    let sqlarr = [
        {
            key: "monthlyId",
            sql: " AND t.monthly_id = ? "
        },
        {
            key: 'nickName',
            sql: " AND u.nick_name like concat('%',?, '%') ",
        },
        {
            key: 'params.beginTime',
            sql: " AND date_format(t.year_month,'%y%m%d') >= date_format(?,'%y%m%d') ",
            isNull: true
        },
        {
            key: 'params.endTime',
            sql: " AND date_format(t.year_month,'%y%m%d') <= date_format(?,'%y%m%d') ",
            isNull: true
        },
        {
            key: 'status',
            sql: " AND t.status != '' AND t.status = ? ",
        },
        {
            key: "userId",
            sql: " AND t.user_id = ?"
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    if (sqlRow.value.length > 0) sqlString += sqlRow.sqlString
    sqlString += 'order by t.year_month DESC '

    // 分页数据
    let page = handlePage(rows)
    if (page.length !== 0) sqlRow.value.push(...page), (sqlString += ' LIMIT ? OFFSET ? ')

    return {
        sqlString,
        value: sqlRow.value
    }
}



let selecFormColumnList = "SELECT c.*,t.task_name FROM monthly_table_column c LEFT JOIN monthly_task t  ON c.task_id = t.task_id  WHERE c.monthly_id = ? AND (c.status = 2 OR c.status= 0)"


let checkUserData = "SELECT * FROM monthly_table  WHERE user_id = ? AND date_format(`year_month`,'%y%m') = date_format(?,'%y%m')"



let insertMonthlyTable = (rows = {}) => {
    let sqlarr = [
        {
            key: "userId",
            sql: " user_id, "
        },
        {
            key: "yearMonth",
            sql: " `year_month`, "
        },
        {
            key: "monthlyLeaderId",
            sql: " monthly_leader_id, "
        },
        {
            key: "workerName",
            sql: " worker_name, "
        },
        {
            key: "status",
            sql: " status, "
        },
        {
            key: "historyStatus",
            sql: " history_status, "
        },
        {
            key: "createBy",
            sql: " create_by, "
        },
        {
            key: "createTime",
            sql: " create_time "
        }
    ]
    let sqlRow = sqlFunKey(rows, sqlarr)

    let sqlString = `insert into monthly_table(${sqlRow.sqlString}) values(${sqlRow.value.map(() => '?').join(',')})`

    return {
        sqlString,
        value: sqlRow.value
    }
}



let insertMonthlyTableColumn = (insertId, rows = []) => {
    let sqlarr = [
        {
            key: "target",
            sql: " target, "
        },
        {
            key: "workload",
            sql: " workload, "
        },
        {
            key: "beginTime",
            sql: " begin_time, "
        },
        {
            key: "endTime",
            sql: " end_time, "
        },
        {
            key: "remark",
            sql: " remark, ",
            isNull: true
        },
        {
            key: "taskId",
            sql: " task_id, "
        },
        {
            key: "status",
            sql: " `status`, "
        },
        {
            key: "beforeId",
            sql: " before_id, ",
            isNull: true
        },
        {
            key: "monthlyId",
            sql: " monthly_id "
        }
    ]

    let columm = ''
    let values = []
    let keyValue = []
    rows.forEach(item => {
        item.monthlyId = insertId
        let sqlRow = sqlFunKey(item, sqlarr)

        columm = sqlRow.sqlString
        values.push(`(${sqlRow.value.map(() => '?').join(',')})`)
        keyValue.push(sqlRow.value)
    })


    let sqlString = `INSERT INTO monthly_table_column(${columm}) values${values.join(',')}`

    return {
        sqlString,
        value: keyValue
    }
}

/** 修改申报主表 */
let updateMonthlyTable = (rows = {}) => {
    let sqlarr = [
        {
            key: "yearMonth",
            sql: " `year_month` = ?, "
        },
        {
            key: "monthlyLeaderId",
            sql: " monthly_leader_id = ?, "
        },
        {
            key: "workerName",
            sql: " worker_name = ?, "
        },
        {
            key: "status",
            sql: " status = ?, "
        },
        {
            key: "historyStatus",
            sql: " history_status = ?, "
        },
        {
            key: "updateBy",
            sql: " update_by = ?, "
        },
        {
            key: "updateTime",
            sql: " update_time = ? "
        },
        {
            key: "monthlyId",
            sql: " WHERE monthly_id = ? "
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    let sqlString = 'update monthly_table set ' + sqlRow.sqlString
    return {
        sqlString,
        value: sqlRow.value
    }

}


let updateMonthlyTableStatus = (rows = {}) => {
    let sqlarr = [
        {
            key: "status",
            sql: " status = ?, "
        },
        {
            key: "updateBy",
            sql: " update_by = ?, "
        },
        {
            key: "updateTime",
            sql: " update_time = ? "
        },
        {
            key: "monthlyId",
            sql: " WHERE monthly_id = ? "
        }
    ]
    let sqlRow = sqlFunKey(rows, sqlarr)
    let sqlString = 'update monthly_table set ' + sqlRow.sqlString
    return {
        sqlString,
        value: sqlRow.value
    }

}

/** 修改申报副表 */
let updateMonthlyTableColumn = (rows = {}) => {
    let sqlarr = [
        {
            key: "target",
            sql: " target = ?, "
        },
        {
            key: "workload",
            sql: " workload = ?, "
        },
        {
            key: "beginTime",
            sql: " begin_time = ?, "
        },
        {
            key: "endTime",
            sql: " end_time = ?, "
        },
        {
            key: "remark",
            sql: " remark = ?, "
        },
        {
            key: "actualBeginTime",
            sql: " actual_begin_time = ?, "
        },
        {
            key: "actualEndTime",
            sql: " actual_end_time = ?, "
        },
        {
            key: "workDone",
            sql: " work_done = ?, "
        },
        {
            key: "jobRating",
            sql: " job_rating = ?, "
        },
        {
            key: "status",
            sql: " `status` = ?, "
        },
        {
            key: "monthlyId",
            sql: " monthly_id = ? "
        },
        {
            key: "columnId",
            sql: " WHERE column_id = ? "
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    let sqlString = 'update monthly_table_column set ' + sqlRow.sqlString
    return {
        sqlString,
        value: sqlRow.value
    }

}





let deleteMonthlyTable = "DELETE from monthly_table WHERE monthly_id = ? AND user_id = ? AND status ='1' "

let deleteMonthlyTableColumn = "DELETE FROM monthly_table_column WHERE monthly_id = ?"

let deleteMonthlyTableColumnId = "DELETE FROM monthly_table_column WHERE column_id = ? AND status != '1'"


let updateMonthlyTableColumnStatus = 'update monthly_table_column set `status` = ? WHERE column_id = ? '


let updateMonthlyTableColumnFinish = 'update monthly_table_column set  actual_begin_time = ?,  actual_end_time = ?  WHERE column_id = ? '


let selectTaskAll = (rows = {}) => {
    let sqlString = `SELECT t.task_name,c.target,c.begin_time,c.end_time,u.nick_name FROM monthly_table m 
    LEFT JOIN monthly_table_column c ON m.monthly_id = c.monthly_id 
    LEFT JOIN monthly_task t ON c.task_id = t.task_id
    LEFT JOIN sys_user u ON u.user_id = m.user_id
    WHERE c.task_id IS NOT NULL AND (c.status = 2 OR c.status= 0) `
    let sqlarr = [
        {
            key: "yearMonth",
            sql: " AND date_format(m.year_month,'%Y-%m') = ? "
        },
        {
            key: "taskId",
            sql: " AND t.task_id = ? ",
            isNull: true // 不等于空
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    sqlString += sqlRow.sqlString
    return {
        sqlString,
        value: sqlRow.value
    }
}

module.exports = {
    selectTaskAll,
    updateMonthlyTableColumnFinish,
    updateMonthlyTableStatus,
    updateMonthlyTableColumnStatus,
    deleteMonthlyTableColumnId,
    deleteMonthlyTableColumn,
    deleteMonthlyTable,
    updateMonthlyTableColumn,
    updateMonthlyTable,
    insertMonthlyTableColumn,
    insertMonthlyTable,
    checkUserData,
    selecFormColumnList,
    selectFormList
}