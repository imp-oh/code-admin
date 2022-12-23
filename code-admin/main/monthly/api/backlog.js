const { isUserAdmin, isRolesAdmin } = require('@/utils/permissions')
const { formatTime, loginTime } = require('@/utils/validate')
const { bcryptEncrypt, rsaDecrypt } = require('@/utils/crypto')

const backlogService = require('@/main/monthly/service/backlogService')
const formService = require('@/main/monthly/service/formService')

/** list */
let list = async (req, res) => {
    let rows = []
    req.query.status = 5
    let total = await formService.startPage(req.query)
    if (total > 0) rows = await formService.selectFormList(req.query)
    res.send({
        code: 200,
        msg: "查询成功",
        rows: rows,
        total: total
    })
}


/** 修改申报数据 */
let edit = async (req, res) => {
    let { user } = req.loginUser
    let { status, monthlyId, tableData } = req.body


    let data = {
        status,
        monthlyId,
        updateBy: user.userName,
        userId: user.userId,
        updateTime: formatTime(new Date(), 'yyyy-MM-dd HH:mm:ss')
    }
    if (status == 0) {
        let tableDataArray = []
        tableData.forEach(item => {
            tableDataArray.push({
                columnId: item.columnId,
                workDone: item.workDone,
                jobRating: item.jobRating,
                monthlyId: item.monthlyId
            })
        })
        data['tableData'] = tableDataArray
    }
    await formService.checkUserData(data)
    await formService.updateMonthlyTable(data)

    res.send({
        code: 200,
        msg: "操作成功",
    })
}


let getInfo = async (req, res) => {
    let { monthlyId } = req.params
    let data = await backlogService.selectPostById({ monthlyId, status: 5 })
    res.send({
        data: data,
        code: 200,
        msg: "操作成功",
    })
}




module.exports = {
    getInfo,
    list,
    edit
}
