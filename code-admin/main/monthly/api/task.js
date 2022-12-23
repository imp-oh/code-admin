const { isUserAdmin, isRolesAdmin } = require('@/utils/permissions')
const { formatTime, loginTime } = require('@/utils/validate')
const { bcryptEncrypt, rsaDecrypt } = require('@/utils/crypto')

const taskService = require('@/main/monthly/service/taskService')



/** list */
let list = async (req, res) => {
    let { user } = req.loginUser
    let rows = []
    req.query.userId = user.userId
    let total = await taskService.startPage(req.query, user)
    if (total > 0) rows = await taskService.selectTaskList(req.query, user)
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
    req.body.createBy = user.userName
    req.body.createTime = formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')

    await taskService.checkTaskName(req.body)
    await taskService.insertTask(req.body)

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
    await taskService.checkTaskName(req.body)
    await taskService.updateTask(req.body)

    res.send({
        code: 200,
        msg: "操作成功",
    })
}


/** 查询详情 */
let getInfo = async (req, res) => {
    let { taskId } = req.params
    let data = await taskService.selectPostById(taskId)
    res.send({
        data: data,
        code: 200,
        msg: "操作成功",
    })
}


/** 状态修改 */
let changeStatus = async (req, res) => {
    let { user } = req.loginUser
    let { monthlyId, status } = req.body
    req.body.updateBy = user.userName
    req.body.updateTime = formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')
    req.body.userId = user.userId
    await taskService.checkFormDataScope(monthlyId, user) // 校验用户是否有权限修改
    await taskService.checkUserData(req.body)
    await taskService.updateMonthlyTable(req.body)
    res.send({
        code: 200,
        msg: "操作成功",
    })
}


/**
 * 删除任务清单
 */
let remove = async (req, res) => {
    let { user } = req.loginUser
    let { taskIds } = req.params
    let ids = taskIds.split(',')
    await taskService.deletePostByIds(ids)
    res.send({
        code: 200,
        msg: "操作成功"
    })
}



/** 查询当月数据 */
let getTaskAll = async (req, res) => {
    let { user } = req.loginUser
    //  获取当月 1号至最后一号
    var date = new Date();
    // var beginTime = new Date(date.getFullYear(), date.getMonth(), 1);
    var endTime = new Date(date.getFullYear(), date.getMonth() + 1, 0);
    let list = await taskService.selectTaskAll({ beginTime:date, endTime }, user)

    res.send({
        code: 200,
        msg: "查询成功",
        data: list
    })

}



module.exports = {
    getTaskAll,
    remove,
    changeStatus,
    getInfo,
    list,
    add,
    edit
}
