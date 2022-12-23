
let categoryService = require('@/main/article/service/categoryService')

/**
 * 查询【请填写功能名称】列表
 * @PreAuthorize("@ss.hasPermi('article:category:list')")
 * @GetMapping("/list")
 */

let list = async (req, res) => {
    let total = await categoryService.startPage(req.query)
    let rows = []
    if (total > 0) rows = await categoryService.selectBaseCategoryList(req.query)
    res.send({
        code: 200,
        msg: "查询成功",
        rows: rows,
        total: total
    })
}


/**
 * 新增【请填写功能名称】
 * @PreAuthorize("@ss.hasPermi('article:category:add')")
 */

let add = async (req, res) => {
    await categoryService.insertBaseCategory(req)
    res.send({
        code: 200,
        msg: "操作成功"
    })
}


/**
 * 修改【请填写功能名称】
 *  @PreAuthorize("@ss.hasPermi('article:category:edit')")
 */
let edit = async (req, res) => {
    await categoryService.updateBaseCategory(req)
    res.send({
        code: 200,
        msg: "操作成功"
    })
}


/**
 * 获取【请填写功能名称】详细信息
 * @PreAuthorize("@ss.hasPermi('article:category:query')")
 * @GetMapping(value = "/{categoryId}")
 */

let getInfo = async (req, res) => {
    let { categoryId } = req.params
    let data = await categoryService.selectBaseCategoryByCategoryId(categoryId)
    res.send({
        code: 200,
        msg: "操作成功",
        data: data
    })
}


/**
 * 删除【请填写功能名称】
 */
let remove = async (req, res) => {
    let { categoryIds } = req.params
    let rows = []
    if (categoryIds.length !== 0) rows = categoryIds.split(',')
    await categoryService.deleteBaseCategoryByCategoryIds(rows)
    res.send({
        code: 200,
        msg: "操作成功"
    })
}

module.exports = {
    remove,
    edit,
    getInfo,
    add,
    list
}