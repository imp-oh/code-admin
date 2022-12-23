const dbconfig = require('@/config/dbconfig')
const editorMapper = require('@/main/article/db/editorMapper')
const configUpload = require('@/utils/upload')
const fs_promises = require('fs/promises')
const path = require('path')
const config = require('@/config')
const { formatTime } = require('@/utils/validate')
const { bigInOrderNo } = require('@/utils/validate')
const { isUserAdmin, isRolesAdmin } = require('@/utils/permissions')

/**
 *  查询文章
 * @param {*} basePag 
 */
let selectEditorList = async (basePag = {}, loginUser = {}) => {
    let db = editorMapper.selectEditorList(basePag, loginUser)
    let rows = await dbconfig.sqlConnect(db.sqlString, db.value)
    for (let i = 0; i < rows.length; i++) {
        let row = rows[i]
        // 设置description
        // row.description = row.title + (row.tags || '')
        if (row.tags && row.tags.length > 0) row.tags = row.tags.split(',')
        else row.tags = []
    }

    return rows
}

let startPage = async (basePag = {}, loginUser = {}) => {
    let body = JSON.parse(JSON.stringify(basePag))
    delete body.pageNum
    delete body.pageSize
    let db = editorMapper.selectEditorList(body, loginUser)
    let sqlString = db.sqlString.replace(/^select(.*?)from/gi, 'SELECT count(0) AS countNum FROM ')
    let [info] = await dbconfig.sqlConnect(sqlString, db.value)
    return Number(info.countNum)
}

// 文章信息
let insertBasePage = async (row = {}) => {
    row.articleId = bigInOrderNo()
    let { markContent = '' } = row
    row.description = String(markContent).replace(/[\s]/g, "").slice(0, 100)

    let db = editorMapper.insertBasePage(row)
    await dbconfig.sqlConnect(db.sqlString, db.value)

    return row.articleId
}

// 图片上传
let insertUpload = async (req) => {
    let { user, permissions } = req.loginUser
    let { fields, files } = await configUpload.upload(req, cb => {
        return cb.mimetype && cb.mimetype.includes("image") && cb.name === 'file'
    }, '/article/page')

    let file = files.file
    let [, mimetype] = file.mimetype.split('/')
    let fileType = ['jpeg', 'jpg', 'png', 'gif', 'ico', 'image']
    if (!fileType.includes(mimetype)) {
        await fs_promises.unlink(file.filepath)
        throw { code: 500, msg: '文件类型错误' }
    }

    let newFileName = file.filepath + '.' + mimetype
    await fs_promises.rename(file.filepath, newFileName)

    let platform = process.platform === 'linux' ? '/' : '\\'


    let [, avatarPaht] = newFileName.split(`${platform}public`)
    let coverImg = avatarPaht.replace(/\\/ig, '/')
    if (fields.type == 1) {
        let info = await selectPageId(fields.articleId, user.userId)
        if (info && info.coverImg) {
            let olAvatar = path.join(config.base, '/public', info.coverImg)
            if (configUpload.access(olAvatar)) await fs_promises.unlink(olAvatar) // 删除文件
        }
        await updateEditor({
            articleId: fields.articleId,
            coverImg: coverImg,
            userId: user.userId,
            updateTime: formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss'),
        })
        return {
            imagePath: coverImg,
        }
    }


    let form = {
        articleId: fields.articleId,
        imageId: files.file.newFilename,
        imageSize: files.file.size,
        imageMimeType: files.file.mimetype,
        imagePath: coverImg,
        createTime: formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss'),
    }
    // if (!files.articleId) form.articleId = await insertBasePage(row)
    let db = editorMapper.insertUpload(form)
    await dbconfig.sqlConnect(db.sqlString, db.value)

    return {
        imagePath: form.imagePath,
    }
}


// 文章内容
let insertArticleData = async (rows = {}) => {
    if (rows.tags) rows.tags = rows.tags.join(',')
    let { affectedRows } = await dbconfig.sqlConnect(editorMapper.insertArticleData, [rows.articleId, rows.markContent])
    return affectedRows
}


let selectBaseImage = async (articleId, userId) => {
    return await dbconfig.sqlConnect(editorMapper.selectBaseImage, [articleId, userId])
}

// 查询用户是否有权限修改
let checkUserDataScope = async (editor = {}, loginUser = {}) => {
    let db = editorMapper.selectEditorList(editor, loginUser)

    let rows = await dbconfig.sqlConnect(db.sqlString, db.value)
    if (rows.length <= 0) throw { code: 500, msg: "你想偷谁的数据】" }
}

// 更新文章信息
let updateEditor = async (row = {}) => {
    if (row.tags) row.tags = row.tags.join(',')
    let { markContent = '' } = row
    row.description = markContent.replace(/[\s]/g, "").slice(0, 100)
    let db = editorMapper.updateEditor(row)
    let { affectedRows } = await dbconfig.sqlConnect(db.sqlString, db.value)
    if (affectedRows === 0) throw { code: 500, msg: "当前id不存在" }
    return affectedRows
}


// 修改文章内容
let updateBaseData = async (markContent, articleId) => {
    let { affectedRows } = await dbconfig.sqlConnect(editorMapper.updateBaseData, [markContent, articleId])
    return affectedRows
}

let deleteImage = async (rows = []) => {
    let ids = rows.map(item => item.imageId)

    for (let i in rows) {
        let row = rows[i]
        let olAvatar = path.join(config.base, '/public', row.imagePath)
        if (configUpload.access(olAvatar)) await fs_promises.unlink(olAvatar) // 删除文件
    }

    let db = editorMapper.deleteImage(ids)
    await dbconfig.sqlConnect(db.sqlString, db.value)
}



let selectPageId = async (articleId, userId) => {
    let sqlString = editorMapper.selectPageId()
    let [info] = await dbconfig.sqlConnect(sqlString, [articleId, userId])
    if (!info) throw { code: 500, msg: "你想造反嘛" }
    if (info && info.markContent === null) info.markContent = ''

    // 设置description
    // info.description = info.title + (info.tags || '')

    // 设置 tags
    if (info.tags && info.tags.length > 0) info.tags = info.tags.split(',')
    else info.tags = [];


    return info
}


// 删除封面图
let deleteImageRow = async (info = {}) => {
    if (info && info.coverImg) {
        let olAvatar = path.join(config.base, '/public', info.coverImg)
        if (configUpload.access(olAvatar)) await fs_promises.unlink(olAvatar) // 删除文件
    }
    info.coverImg = ''
    await updateEditor(info)
}


/** 删除文章 */
let deleteEditorId = async (info = {}, loginUser = {}) => {
    let images = await dbconfig.sqlConnect(editorMapper.selectImages, info.articleId)
    let imgMap = images.map(item => item.imagePath)
    let row = await selectPageId(info.articleId, info.userId)

    if (row.coverImg) imgMap.push(row.coverImg)

    for (let i = 0; i < imgMap.length; i++) {
        let coverImg = imgMap[i]
        let olAvatar = path.join(config.base, '/public', coverImg)
        if (configUpload.access(olAvatar)) await fs_promises.unlink(olAvatar) // 删除文件
    }
    let { affectedRows } = await dbconfig.sqlConnect(editorMapper.deleteEditorId, info.articleId)
    if (affectedRows > 0) {
        await dbconfig.sqlConnect(editorMapper.deleteEditorDataId, info.articleId)
        await dbconfig.sqlConnect(editorMapper.deleteEditorImageId, info.articleId)
    }

}

module.exports = {
    checkUserDataScope,
    deleteEditorId,
    selectPageId,
    deleteImage,
    deleteImageRow,
    updateBaseData,
    updateEditor,
    selectBaseImage,
    insertArticleData,
    insertBasePage,
    insertUpload,
    startPage,
    selectEditorList
}