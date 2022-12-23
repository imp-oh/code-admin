const dbconfig = require('@/config/dbconfig')
const postMapper = require('../db/postMapper')
const { getDateDiff } = require('@/utils/validate')

/**
 * 
 * @param {*} post  文章对象
 */
const selectPostList = async (post = {}) => {
    if (post.search) post.search = `%${post.search}%`
    let db = postMapper.selectPostList(post)
    let rows = await dbconfig.sqlConnect(db.sqlString, db.value, 'yyyy-MM-dd HH:mm:ss')
    for (let i = 0; i < rows.length; i++) {
        let row = rows[i]
        row.editTime = getDateDiff(row.createTime)
        let tags = []
        if (row.tags && row.tags.length !== 0) tags = row.tags.split(',')
        row.tags = tags
    }
    return rows
}

const startPage = async (post = {}) => {
    if (post.search) post.search = `%${post.search}%`
    let body = JSON.parse(JSON.stringify(post))
    delete body.pageNum
    delete body.pageSize
    let db = postMapper.selectPostList(body)
    let sqlString = db.sqlString.replace(/^select(.*?)from/gi, 'SELECT count(0) AS countNum FROM ')
    let [info] = await dbconfig.sqlConnect(sqlString, db.value)
    return Number(info.countNum)
}

/**
 * 查询文章详情
 * @param {*} articleId  文章id
 */
const selectArticleId = async (articleId) => {
    let { affectedRows } = await dbconfig.sqlConnect(postMapper.updateViewsCount, articleId)
    let info = {}
    if (affectedRows > 0) [info = {}] = await dbconfig.sqlConnect(postMapper.selectPostId, articleId, 'yyyy-MM-dd HH:mm:ss')
    return info
}



module.exports = {
    selectArticleId,
    selectPostList,
    startPage
}