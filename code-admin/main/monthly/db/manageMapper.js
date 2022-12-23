
const { sqlFunKey, handlePage } = require('@/utils/mysql')

let selectManageList = (rows = {}) => {
    let sqlString = `SELECT  DISTINCT u.user_id, u.user_name,u.nick_name, d.dept_id, d.parent_id, d.dept_name FROM sys_user u 
    LEFT JOIN sys_dept d ON u.dept_id = d.dept_id
    LEFT JOIN monthly_table t ON t.user_id = u.user_id
    WHERE d.dept_id IS NOT NULL AND u.del_flag = 0 `
    let sqlarr = [
        {
            key: 'nickName',
            sql: " AND u.nick_name like concat('%',?, '%') ",
        },
        {
            key: 'params.beginTime',
            sql: " AND date_format(t.year_month,'%y%m%d') >= date_format(?,'%y%m%d') ",
        },
        {
            key: 'params.endTime',
            sql: " AND date_format(t.year_month,'%y%m%d') <= date_format(?,'%y%m%d') ",
        },
        {
            key: 'deptId',
            sql: " AND d.parent_id = ? ",
        },
        {
            key: 'status',
            sql: " AND t.status != '' AND t.status = ? ",
        },
    ]


    let sqlRow = sqlFunKey(rows, sqlarr)
    if (sqlRow.value.length > 0) sqlString += sqlRow.sqlString
    sqlString += 'order by t.year_month'

    // 分页数据
    let page = handlePage(rows)
    if (page.length !== 0) sqlRow.value.push(...page), (sqlString += ' LIMIT ? OFFSET ? ')
    return {
        sqlString,
        value: sqlRow.value
    }
}




module.exports = {
    selectManageList
}