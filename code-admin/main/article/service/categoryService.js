const dbconfig = require('@/config/dbconfig')
let categoryMapper = require('@/main/article/db/categoryMapper')
const configUpload = require('@/utils/upload')
const fs_promises = require('fs/promises')
const path = require('path')
const config = require('@/config')
const { formatTime } = require('@/utils/validate')

/**
 * 查询【请填写功能名称】列表
 * 
 * @param baseCategory 【请填写功能名称】
 * @return 【请填写功能名称】
 */
let selectBaseCategoryList = async (baseCategory = {}) => {
    let db = categoryMapper.selectBaseCategoryList(baseCategory)
    return await dbconfig.sqlConnect(db.sqlString, db.value, 'yyyy-MM-dd HH:mm:ss')
}


let startPage = async (baseCategory = {}) => {
    let body = JSON.parse(JSON.stringify(baseCategory))
    delete body.pageNum
    delete body.pageSize
    let db = categoryMapper.selectBaseCategoryList(body)

    let sqlString = db.sqlString.replace(/^select(.*?)from/gi, 'SELECT count(0) AS countNum FROM ')
    let [info] = await dbconfig.sqlConnect(sqlString, db.value)
    return Number(info.countNum)
}

/**
 * 新增【请填写功能名称】
 * 
 * @param baseCategory 【请填写功能名称】
 * @return 结果
 */
let insertBaseCategory = async (req) => {
    let { categoryName } = req.body
    let { user } = req.loginUser
    let form = categoryName ? req.body : {}
    if (!categoryName) {
        let { fields, files } = await configUpload.upload(req, db => {
            return db.mimetype && db.mimetype.includes("image") && db.name === 'file'
        }, '/article/category')

        let file = files.file
        let [, mimetype] = file.mimetype.split('/')
        let fileType = ['jpeg', 'jpg', 'png', 'gif', 'ico', 'image']
        if (!fileType.includes(mimetype)) {
            await fs_promises.unlink(file.filepath)
            throw { code: 500, msg: '文件类型错误' }
        }
        let newFileName = file.filepath + '.' + mimetype
        await fs_promises.rename(file.filepath, newFileName)

        let [, avatarPaht] = newFileName.split('\\public')
        form = fields
        form.categoryImage = avatarPaht
    }

    form.createBy = user.userName
    form.createTime = formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')
    let db = categoryMapper.insertBaseCategory(form);
    return await dbconfig.sqlConnect(db.sqlString, db.value)
}


/**
 * 查询【请填写功能名称】
 * 
 * @param categoryId 【请填写功能名称】主键
 * @return 【请填写功能名称】
 */
let selectBaseCategoryByCategoryId = async (categoryId = '') => {
    let [info] = await dbconfig.sqlConnect(categoryMapper.selectBaseCategoryByCategoryId, categoryId, 'yyyy-MM-dd HH:mm:ss')
    return info
}




let updateBaseCategory = async (req) => {
    let { categoryName } = req.body
    let { user } = req.loginUser
    let form = categoryName ? req.body : {}

    if (!categoryName) {
        let { fields, files } = await configUpload.upload(req, db => {
            return db.mimetype && db.mimetype.includes("image") && db.name === 'file'
        }, '/article/category')

        let file = files.file
        let [, mimetype] = file.mimetype.split('/')
        let fileType = ['jpeg', 'jpg', 'png', 'gif', 'ico', 'image']
        if (!fileType.includes(mimetype)) {
            await fs_promises.unlink(file.filepath)
            throw { code: 500, msg: '文件类型错误' }
        }
        let newFileName = file.filepath + '.' + mimetype
        await fs_promises.rename(file.filepath, newFileName)

        let [, avatarPaht] = newFileName.split('\\public')
        form = fields
        form.categoryImage = avatarPaht.replace(/\\/ig, '/')
    }

    form.updateBy = user.userName
    form.updateTime = formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')
    if (form.deleteImage) {
        let olAvatar = path.join(config.base, '/public', form.deleteImage)
        if (configUpload.access(olAvatar)) await fs_promises.unlink(olAvatar) // 删除文件
    }
    let db = categoryMapper.updateBaseCategory(form)
    return await dbconfig.sqlConnect(db.sqlString, db.value)
}



/**
 * 批量删除【请填写功能名称】
 * 
 * @param categoryIds 需要删除的【请填写功能名称】主键
 * @return 结果
 */
let deleteBaseCategoryByCategoryIds = async (categoryIds = []) => {
    for (let i in categoryIds) {
        let delId = categoryIds[i]
        let info = await selectBaseCategoryByCategoryId(delId)
        if (info.categoryImage) {
            let olAvatar = path.join(config.base, '/public', info.categoryImage)
            if (configUpload.access(olAvatar)) await fs_promises.unlink(olAvatar) // 删除文件
        }
        let db = categoryMapper.deleteBaseCategoryByCategoryIds([delId])
        await dbconfig.sqlConnect(db.sqlString, db.value)
    }


}

module.exports = {
    deleteBaseCategoryByCategoryIds,
    updateBaseCategory,
    selectBaseCategoryByCategoryId,
    startPage,
    insertBaseCategory,
    selectBaseCategoryList
}