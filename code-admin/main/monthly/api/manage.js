const { isUserAdmin, isRolesAdmin } = require('@/utils/permissions')
const { formatTime, loginTime } = require('@/utils/validate')
const { bcryptEncrypt, rsaDecrypt } = require('@/utils/crypto')

const manageService = require('@/main/monthly/service/manageService')


/** list */
let list = async (req, res) => {
    let { user } = req.loginUser
    let { dept } = user
    let rows = []
    req.query.deptId = dept.deptId
    let total = await manageService.startPage(req.query, user)
    if (total > 0) rows = await manageService.selectManageList(req.query, user)
    await manageService.selectManageList(req.query, user)
    res.send({
        code: 200,
        msg: "查询成功",
        rows: rows,
        total: total
    })
}


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
    let bufferContent = await manageService.selectExport(data)
    res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    res.setHeader("Content-Disposition", "attachment; filename='xx.zip")
    res.write(bufferContent);
    res.end()
}



module.exports = {
    getExport,
    list
}
