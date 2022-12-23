
const dbconfig = require("@/config/dbconfig")

const { isUserAdmin, isRolesAdmin } = require('@/utils/permissions')
const { formatTime } = require('@/utils/validate')
const userConstants = require('@/enums/userConstants')
const manageMapper = require('../db/manageMapper')
const formService = require('@/main/monthly/service/formService')
const AdmZip = require("adm-zip");


/**
 * 根据条件分页查询申报管理
 * 
 * @param form 申报管理信息信息
 * @return 申报管理信息集合信息
 */
let selectManageList = async (form = {}, loginUser = {}) => {
    let db = manageMapper.selectManageList(form, loginUser)
    let list = await dbconfig.sqlConnect(db.sqlString, db.value, 'yyyy-MM-dd HH:mm:ss')
    return list
}


let startPage = async (form = {}, loginUser = {}) => {
    let body = JSON.parse(JSON.stringify(form))
    delete body.pageNum
    delete body.pageSize
    let db = manageMapper.selectManageList(body, loginUser)
    let sqlString = db.sqlString.replace(/^select(.*?)from/gi, 'SELECT count(0) AS countNum FROM ')
    let [info] = await dbconfig.sqlConnect(sqlString, db.value)
    return Number(info.countNum)
}


let selectExport = async (manage = {}) => {
    let rows = await selectManageList(manage)
    var zip = new AdmZip();
    for (let i = 0; i < rows.length; i++) {
        let row = rows[i]
        let data = {
            ...manage,
            userId: row.userId
        }
        let all = await formService.selectExport(data)
        zip.addFile(`申报-${row.nickName}-${i + 1}.xlsx`, all, 'entry comment goes here"')
    }

    return zip.toBuffer();

}


module.exports = {
    selectExport,
    startPage,
    selectManageList
}