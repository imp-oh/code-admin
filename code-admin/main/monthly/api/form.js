const { isUserAdmin, isRolesAdmin } = require('@/utils/permissions')
const { formatTime, loginTime } = require('@/utils/validate')
const { bcryptEncrypt, rsaDecrypt } = require('@/utils/crypto')

const formService = require('@/main/monthly/service/formService')



/** list */
let list = async (req, res) => {
    let { user } = req.loginUser
    let rows = []
    req.query.userId = user.userId
    let total = await formService.startPage(req.query)
    if (total > 0) rows = await formService.selectFormList(req.query)
    res.send({
        code: 200,
        msg: "查询成功",
        rows: rows,
        total: total
    })
}


/** 添加申报 */
let add = async (req, res) => {
    let { user } = req.loginUser
    // req.body.workerName = user.nickName
    req.body.createBy = user.userName
    req.body.createTime = formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')
    req.body.userId = user.userId
    await formService.checkUserData(req.body)
    await formService.insertMonthlyTable(req.body)

    res.send({
        code: 200,
        msg: "操作成功",
    })
}

/** 修改申报数据 */
let edit = async (req, res) => {
    let { user } = req.loginUser
    let { monthlyId, status } = req.body
    req.body.updateBy = user.userName
    req.body.updateTime = formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')
    req.body.userId = user.userId
    await formService.checkUserData(req.body)
    await formService.updateMonthlyTable(req.body)

    res.send({
        code: 200,
        msg: "操作成功",
    })
}


let getInfo = async (req, res) => {
    let { user } = req.loginUser
    let { monthlyId } = req.params
    let data = await formService.selectPostById({ monthlyId, userId: user.userId })
    res.send({
        data: data,
        code: 200,
        msg: "操作成功",
    })
}


/** 状态修改 */
let changeStatus = async (req, res) => {
    let { user } = req.loginUser
    let { monthlyId } = req.body
    req.body.updateBy = user.userName
    req.body.updateTime = formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')
    req.body.userId = user.userId
    await formService.checkFormDataScope(monthlyId, user) // 校验用户是否有权限修改
    await formService.checkUserData(req.body)
    let { status } = await formService.updateMonthlyTableStatus(req.body)
    res.send({
        data: { status },
        code: 200,
        msg: "操作成功",
    })
}


/**
 * 删除申报
 */
let remove = async (req, res) => {
    let { user } = req.loginUser
    let { monthlyIds } = req.params
    let ids = monthlyIds.split(',')
    await formService.deletePostByIds(ids, user.userId)
    res.send({
        code: 200,
        msg: "操作成功"
    })
}


let finish = async (req, res) => {
    let { user } = req.loginUser
    let { monthlyId, status } = req.body
    req.body.updateBy = user.userName
    req.body.updateTime = formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')
    req.body.userId = user.userId
    await formService.checkUserData(req.body)
    await formService.updateMonthlyTableFinish(req.body)

    res.send({
        code: 200,
        msg: "操作成功",
    })
}

let getView = async (req, res) => {
    let { user } = req.loginUser
    let { monthlyId } = req.params
    let data = await formService.selectPostById({ monthlyId, userId: user.userId })
    res.send({
        data: data,
        code: 200,
        msg: "操作成功",
    })
}

/** 导出xlsx */
let getExport = async (req, res) => {
    let { user } = req.loginUser
    let data = {
        ...req.body,
        params: {
            beginTime: req.body['params[beginTime]'] || '',
            endTime: req.body['params[endTime]'] || ''
        },
        userId: user.userId
    }

    let bufferContent = await formService.selectExport(data)
    res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    res.setHeader("Content-Disposition", "attachment; filename='xx.xlsx")
    res.write(bufferContent);
    res.end()
}


/** 解析xlsx 文件 */
let importData = async (req, res) => {
    let { user } = req.loginUser
    let rows = {
        createBy: user.userName,
        createTime: formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss'),
        userId: user.userId
    }
    await formService.getXlsx(req, rows)

    res.send({
        code: 200,
        msg: "操作成功",
    })
}


/** 查询相关用户任务 */
let taskList = async (req, res) => {
    let rows = []
    rows = await formService.selectTaskList(req.query)
    res.send({
        rows,
        code: 200,
        msg: "查询成功",
    })
}

module.exports = {
    taskList,
    importData,
    getExport,
    getView,
    finish,
    remove,
    changeStatus,
    getInfo,
    list,
    add,
    edit
}
