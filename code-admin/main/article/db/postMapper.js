const { handlePage, sqlFunKey } = require('@/utils/mysql')
const { handleDataScope } = require('@/enums/dataScopeAspect')
const { isUserAdmin, isRolesAdmin } = require('@/utils/permissions')

let selectPostColumnVo = "SELECT a.article_id,a.title,a.tags,cast(a.description as char) as description,a.`status`,a.views_count,a.cover_img,a.create_time,u.nick_name,u.avatar,u.user_id "

let selectPostList = (rows = {}) => {
    let sqlString = selectPostColumnVo + " FROM base_article a LEFT JOIN sys_user u ON a.user_id = u.user_id  WHERE a.`status`= 0 "
    let sqlarr = [
        {
            key: "articleId",
            sql: "AND a.article_id = ? "
        },
        {
            key: "title",
            sql: "AND a.title like concat('%', ?, '%') "
        },
        {
            key: "tags",
            sql: "AND a.tags like concat('%', ?, '%') "
        },
        {
            key: "search",
            sql: "AND concat(IFNULL(a.title,''),IFNULL(a.tags,''),IFNULL(a.description,'')) like ? "
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    if (sqlRow.value.length > 0) sqlString += sqlRow.sqlString
    sqlString += 'order by a.create_time DESC '

    // 分页数据
    let page = handlePage(rows)
    if (page.length !== 0) sqlRow.value.push(...page), (sqlString += ' LIMIT ? OFFSET ? ')


    return {
        sqlString,
        value: sqlRow.value
    }
}

const selectPostId = selectPostColumnVo + " ,cast(d.mark_content as char) as mark_content FROM base_article a LEFT JOIN sys_user u ON a.user_id = u.user_id LEFT JOIN base_article_data d ON a.article_id = d.article_id  WHERE a.`status`= 0 AND a.article_id = ?"


const updateViewsCount = "UPDATE base_article SET views_count = (views_count + 1) WHERE article_id = ?"

module.exports = {
    updateViewsCount,
    selectPostId,
    selectPostList
}