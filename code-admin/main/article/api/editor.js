let editorService = require('@/main/article/service/editorService')
const { formatTime } = require('@/utils/validate')
const { isUserAdmin } = require('@/utils/permissions')
const { getMarkImageName } = require('@/utils/util')



/**
 * 查询用户文章数据
 */
let list = async (req, res) => {
    let { user } = req.loginUser
    let total = await editorService.startPage(req.query, user)
    let rows = []
    if (total > 0) rows = await editorService.selectEditorList(req.query, user)
    res.send({
        code: 200,
        msg: "查询成功",
        rows: rows,
        total: total
    })
}


/** 添加文章 */
let add = async (req, res) => {
    let { user, permissions } = req.loginUser

    req.body.userId = user.userId
    req.body.createBy = user.userName
    req.body.createTime = formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')
    req.body.status = (isUserAdmin(user.userId) || permissions.includes('article:page:review')) ? '0' : '2' // 如果有审核权限，可直接发布
    req.body.articleId = await editorService.insertBasePage(req.body)

    await editorService.insertArticleData(req.body)

    res.send({
        code: 200,
        msg: "操作成功",
        data: {
            articleId: req.body.articleId
        }
    })
}


/** 修改文章 */
let edit = async (req, res) => {
    let { user, permissions } = req.loginUser
    let { markContent, articleId } = req.body

    req.body.updateBy = user.userName
    req.body.updateTime = formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')
    // req.body.status = 0 // (isUserAdmin(user.userId) || permissions.includes('article:page:review')) ? '0' : req._parsedUrl.pathname === '/editor/draft' ? '1' : '2' // 如果有审核权限，可直接发布

    await editorService.checkUserDataScope({ articleId }, user) // 查询是否有数据权限
    await editorService.updateEditor(req.body, user)
    if (markContent) {
        let imageList = await editorService.selectBaseImage(articleId, user.userId)
        let deleteImageId = []
        if (imageList.length > 0) {
            let imageArray = getMarkImageName(markContent)
            for (let i in imageList) {
                let item = imageList[i]
                if (!imageArray.includes(item.imageId)) deleteImageId.push({
                    imageId: item.imageId,
                    imagePath: item.imagePath
                })
            }
        }
        if (deleteImageId.length > 0) {
            await editorService.deleteImage(deleteImageId)
        }
        await editorService.updateBaseData(markContent, articleId)
    }

    res.send({
        code: 200,
        msg: "成功"
    })


}

/** 图片上传 */
let upload = async (req, res) => {
    // 1. 如果没有 文章id 择生成新的文章id
    let data = await editorService.insertUpload(req)
    res.send({
        code: 200,
        msg: "上传成功",
        data
    })

}


/** 查询单条数据 */
let getInfo = async (req, res) => {
    let { user } = req.loginUser
    let { articleId } = req.query
    let info = await editorService.selectPageId(articleId, user.userId)
    res.send({
        msg: "查询成功",
        code: 200,
        data: info
    })
}


/** 删除图片 */
let deleteImage = async (req, res) => {
    let { user } = req.loginUser
    let { articleId } = req.body
    let info = await editorService.selectPageId(articleId, user.userId)
    if (!info.coverImg) throw { code: 500, msg: "删除失败" }
    info.userId = user.userId
    info.updateBy = user.userName
    info.updateTime = formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')
    await editorService.deleteImageRow(info)
    res.send({
        msg: "删除成功",
        code: 200
    })
}


/** 删除文章 */
let remove = async (req, res) => {
    let { user } = req.loginUser
    let { articleId } = req.params
    await editorService.deleteEditorId({
        articleId,
        userId: user.userId
    }, user)
    res.send({
        msg: "删除成功",
        code: 200
    })
}

module.exports = {
    remove,
    getInfo,
    upload,
    add,
    edit,
    list,
    deleteImage
}