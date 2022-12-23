
const { sqlFunKey, handlePage } = require('@/utils/mysql')

let selectBacklogList = (rows = {}) => {
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
            sql: " AND date_format(t.create_time,'%y%m%d') >= date_format(?,'%y%m%d') ",
        },
        {
            key: 'params.endTime',
            sql: " AND date_format(t.create_time,'%y%m%d') <= date_format(?,'%y%m%d') ",
        },
        {
            key: 'status',
            sql: " AND t.status = ? ",
        },
        {
            key: 'userId',
            sql: " AND t.user_id = ?"
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    if (sqlRow.value.length > 0) sqlString += sqlRow.sqlString
    sqlString += 'order by t.update_time '

    // 分页数据
    let page = handlePage(rows)
    if (page.length !== 0) sqlRow.value.push(...page), (sqlString += ' LIMIT ? OFFSET ? ')

    return {
        sqlString,
        value: sqlRow.value
    }
}



let selecFormColumnList = "SELECT c.*,t.task_name FROM monthly_table_column c LEFT JOIN monthly_task t  ON c.task_id = t.task_id  WHERE c.monthly_id = ? AND (c.status = 2 OR c.status= 0)"
let selecFormColumnListHistory = "SELECT c.*,t.task_name FROM monthly_table_column c LEFT JOIN monthly_task t  ON c.task_id = t.task_id  WHERE c.monthly_id = ? AND c.status = 1"



module.exports = {
    selecFormColumnListHistory,
    selecFormColumnList,
    selectBacklogList
}