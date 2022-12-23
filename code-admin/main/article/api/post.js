const postService = require('../service/postService')

/**
 *  首页文章
 */
let list = async (req, res) => {
    let rows = []

    let total = await postService.startPage(req.query)
    if (total > 0) rows = await postService.selectPostList(req.query)

    res.send({
        code: 200,
        msg: "查询成功",
        rows,
        total
    })
}

/**
 *  查询文章详情
 */
let getInfo = async (req, res) => {
    const { id } = req.params
    let data = await postService.selectArticleId(id)
    res.send({
        code: 200,
        data
    })
}

module.exports = {
    getInfo, list
}