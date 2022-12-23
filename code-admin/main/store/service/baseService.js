const fs = require('fs')
const path = require('path')


const dbconfig = require("@/config/dbconfig")
let baseMapper = require('../db/baseMapper')
const { formatTime } = require('@/utils/validate')
const { bigInOrderNo } = require('@/utils/validate')
const { getFromData } = require("@/utils/index")




let insertAppletstore = async (req) => {
  const id = bigInOrderNo()
  const vid = bigInOrderNo()
  req.filePath = 'public/applet/' // 设置上传路径
  let fileList = {}

  let { user } = req.loginUser

  try {
    fileList = await getFromData(req);
    let formData = fileList.fields

    if (formData && formData.appid) {
      let [appRow] = await dbconfig.sqlConnect(`SELECT
    a.*, v.destination AS app_destination,
    v.version,
    v.storeid,
    v.id AS vid,v.filename
  FROM
    code_engine_appletstore AS a
  LEFT JOIN code_engine_appletstore_version AS v ON a.id = v.storeid
  WHERE
    a.appid = '${formData.appid}' AND a.versionid = v.id `)


      // 1.该数据存在appid 是否重复
      if (appRow && appRow.userid !== user.userId) {
        // 当前userid不相等则 
        throw {
          code: 500,
          msg: "appid已经注册"
        }
      }

      const [dir, icon] = fileList.icon ? fileList.icon.filepath.split('\\').join('/').split('/public') : ['', '']
      let destination = dir ? path.join(dir, 'public').replace(/\\/ig, '\\\\') : ""

      const [dirPath, filePath] = fileList.file.filepath.split('\\').join('/').split('/public')
      let fileDestination = dirPath ? path.join(dirPath, 'public').replace(/\\/ig, '\\\\') : ""
      // 新增 
      if (!appRow) {
        await dbconfig.sqlConnect(`INSERT INTO code_engine_appletstore(id,appid,user_id,versionid,user_name,name,description,readme_content,icon,destination) 
    VALUES('${id}','${fileList.fields.appid}','${user.userId}','${vid}','${user.userName}','${fileList.fields.name}','${fileList.fields.description}','${fileList.fields.readmeContent}','${icon}','${destination}')`)

        await dbconfig.sqlConnect(`INSERT INTO code_engine_appletstore_version(id,storeid,version,destination,filename,size) VALUES(
      '${vid}','${appRow ? appRow.id : id}','${fileList.fields.version}','${fileDestination}','${filePath}','${fileList.fields.size}'
    )`)


      } else if (appRow && appRow.userId === user.userId && appRow.version < formData.version) {
        // 如果userid 相等则 修改
        await dbconfig.sqlConnect(`UPDATE code_engine_appletstore SET name='${fileList.fields.name}',description ='${fileList.fields.description}',readmeContent='${fileList.fields.readmeContent}',icon='${icon}',destination='${destination}' WHERE user_id='${user.userId}' AND appid='${fileList.fields.appid}'`)
        await dbconfig.sqlConnect(`UPDATE code_engine_appletstore_version SET version='${fileList.fields.version}',destination='${fileDestination}',filename='${filePath}',size='${fileList.fields.size}' WHERE id ='${appRow.vid}'`)
        if (appRow.icon) fs.unlinkSync(path.join(appRow.destination, appRow.icon))
        fs.unlinkSync(path.join(appRow.appDestination, appRow.filename))
      } else {
        if (fileList.icon) fs.unlinkSync(fileList.icon.filepath)
        fs.unlinkSync(fileList.file.filepath)
        throw {
          code: 500,
          msg: "小程序版本不能小于或等于"
        }
      }

    }

  } catch (error) {
    if (fileList.icon) fs.unlinkSync(fileList.icon.filepath)
    fs.unlinkSync(fileList.file.filepath)
    throw {
      code: 500,
      msg: error.sqlMessage
    }
  }
}






module.exports = {
  insertAppletstore
}