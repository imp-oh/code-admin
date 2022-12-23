const fs = require('fs')
const fs_promises = require('fs/promises')
const path = require('path')


const dbconfig = require('@/config/dbconfig')
let appletMapper = require('../db/appletMapper')

const config = require('@/config')
const { formatTime } = require('@/utils/validate')



/**
 * 查询小程序列表
 */
let selectAppletList = async (query) => {
  let db = appletMapper.selectAppletList(query)
  return await dbconfig.sqlConnect(db.sqlString, db.value, 'yyyy-MM-dd HH:mm:ss')
}




/** 商场列表查询 */
let selectAppletPage = async (query) => {
  let db = appletMapper.selectAppletPage(query)
  return await dbconfig.sqlConnect(db.sqlString, db.value, 'yyyy-MM-dd HH:mm:ss')
}



let updateAppletstore = async (body) => {
  let db = appletMapper.updateAppletstore(body)
  let { affectedRows } = await dbconfig.sqlConnect(db.sqlString, db.value)
  return affectedRows
}



let deleteAppletstore = async (id, userId) => {
  let [appRow] = await dbconfig.sqlConnect(`SELECT
    a.id,a.appid,a.description,a.downloads,a.name,a.readme_content,a.icon,a.user_name,a.destination, v.destination AS app_destination,
    v.version,
    v.storeid,
    v.id AS vid,v.filename,v.size
    FROM
    code_engine_appletstore AS a
    LEFT JOIN code_engine_appletstore_version AS v ON a.id = v.storeid WHERE a.id = '${id}' AND a.user_id ='${userId}'`)
  if (appRow) {
    let icoPath = appRow.destination ? path.join(config.base, 'public', appRow.icon) : ""
    let filePath = path.join(config.base, 'public', appRow.filename)
    if (icoPath) await fs_promises.access(icoPath)
    await fs_promises.access(filePath)
    if (icoPath) fs.unlinkSync(icoPath)
    fs.unlinkSync(filePath)
  }
  await dbconfig.sqlConnect(`DELETE FROM code_engine_appletstore WHERE user_id = '${userId}' AND id ='${id}'`)
  await dbconfig.sqlConnect(`DELETE FROM code_engine_appletstore WHERE id ='${id}'`)
}

module.exports = {
  deleteAppletstore,
  selectAppletPage,
  updateAppletstore,
  selectAppletList
}