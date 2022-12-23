
const { sqlFunKey, handlePage } = require('@/utils/mysql')
const { handleDataScope } = require('@/enums/dataScopeAspect')

let selectTaskVo = "SELECT t.task_id,t.task_name,t.dept_id,d.dept_name,t.status,t.begin_time,t.end_time FROM monthly_task t LEFT JOIN sys_dept d ON t.dept_id = d.dept_id WHERE d.del_flag = '0' "

let selectTaskList = (rows = {}, loginUser = {}) => {
    let sqlString = selectTaskVo
    let sqlarr = [
        {
            key: 'taskName',
            sql: " AND t.task_name like concat('%',?, '%') ",
        },
        {
            key: 'deptName',
            sql: " AND d.dept_name like concat('%',?, '%') ",
        },
        {
            key: 'beginTime',
            sql: " AND date_format(t.create_time,'%y%m%d') >= date_format(?,'%y%m%d') ",
        },
        {
            key: 'endTime',
            sql: " AND date_format(t.create_time,'%y%m%d') <= date_format(?,'%y%m%d') ",
        },
        {
            key: 'status',
            sql: " AND t.status = ? ",
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    let dataScope = handleDataScope({ deptAlias: "d", loginUser })  // 数据权控制
    if (sqlRow.value.length > 0) sqlString += sqlRow.sqlString
    sqlString += dataScope
    sqlString += 'order by t.update_time '

    // 分页数据
    let page = handlePage(rows)
    if (page.length !== 0) sqlRow.value.push(...page), (sqlString += ' LIMIT ? OFFSET ? ')

    return {
        sqlString,
        value: sqlRow.value
    }
}

let selectPostById = selectTaskVo + " AND t.task_id = ?"


let checkTaskName = "SELECT dept_id,task_id FROM monthly_task WHERE task_name = ? limit 1"



let insertTask = (rows = {}) => {
    let sqlarr = [
        {
            key: "taskName",
            sql: " task_name, "
        },
        {
            key: "deptId",
            sql: " dept_id, ",
            isNull: true
        },
        {
            key: "status",
            sql: " status, ",
            isNull: true
        },
        {
            key: "beginTime",
            sql: " begin_time, ",
            isNull: true
        },
        {
            key: "endTime",
            sql: " end_time, ",
            isNull: true
        },
        {
            key: "createBy",
            sql: " create_by, ",
            isNull: true
        },
        {
            key: "createTime",
            sql: " create_time ",
            isNull: true
        }
    ]
    let sqlRow = sqlFunKey(rows, sqlarr)

    let sqlString = `insert into monthly_task(${sqlRow.sqlString}) values(${sqlRow.value.map(() => '?').join(',')})`

    return {
        sqlString,
        value: sqlRow.value
    }
}


let updateTask = (rows = {}) => {
    let sqlarr = [
        {
            key: "taskName",
            sql: " task_name = ?, "
        },
        {
            key: "deptId",
            sql: " dept_id = ?, "
        },
        {
            key: "status",
            sql: " status = ?, "
        },
        {
            key: "beginTime",
            sql: " begin_time = ?, ",
            isNull: true
        },
        {
            key: "endTime",
            sql: " end_time = ?, ",
            isNull: true
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
            key: "taskId",
            sql: " WHERE task_id = ? "
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    let sqlString = 'update monthly_task set ' + sqlRow.sqlString

    return {
        sqlString,
        value: sqlRow.value
    }

}


let deleteTaskIds = (rows = []) => {
    let sqlString = `delete from monthly_task where task_id in (${rows.map(() => '?').join(',')})`
    return {
        sqlString,
        value: rows
    }
}

let selectTaskAll = (rows = {}, loginUser = {}) => {
    let sqlarr = [
        {
            key: 'beginTime',
            sql: " date_format(t.begin_time,'%y%m%d') >= date_format(?,'%y%m%d') ",
        },
        {
            key: 'endTime',
            sql: " AND date_format(t.end_time,'%y%m%d') <= date_format(?,'%y%m%d') ",
        }
    ]

    let sqlString = selectTaskVo + " AND t.status ='0' AND (t.begin_time IS NULL AND t.end_time IS NULL) OR "
    let sqlRow = sqlFunKey(rows, sqlarr)
    let dataScope = handleDataScope({ deptAlias: "d", loginUser })  // 数据权控制
    if (sqlRow.value.length > 0) sqlString += sqlRow.sqlString
    sqlString += dataScope
    sqlString += 'order by t.begin_time '
    return {
        sqlString,
        value: sqlRow.value
    }
}

module.exports = {
    selectTaskAll,
    selectPostById,
    deleteTaskIds,
    updateTask,
    checkTaskName,
    insertTask,
    selectTaskList
}