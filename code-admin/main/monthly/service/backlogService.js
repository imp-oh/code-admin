
const dbconfig = require("@/config/dbconfig")

const { formatTime } = require('@/utils/validate')
const backlogMapper = require('../db/backlogMapper')
const formService = require('@/main/monthly/service/formService')

/** 
 * 申报详情查询 
 * form  {}
 * */
let selectPostById = async (form = {}) => {
    let info = await formService.selectPostById(form)
    info.tableData.forEach(item => {
        item.actualBeginTime = formatTime(item.actualBeginTime, 'yyyy-MM-dd')
        item.actualEndTime = formatTime(item.actualEndTime, 'yyyy-MM-dd')
        item.beginTime = formatTime(item.beginTime, 'yyyy-MM-dd')
        item.endTime = formatTime(item.endTime, 'yyyy-MM-dd')
    })
    let tableDataHistory = await dbconfig.sqlConnect(backlogMapper.selecFormColumnListHistory, form.monthlyId, 'yyyy-MM-dd HH:mm:ss')
    info.yearMonth = formatTime(info.yearMonth, 'yyyy-MM')
    info.tableDataHistory = tableDataHistory
    return info
}





module.exports = {
    selectPostById
}