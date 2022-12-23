const { handlePage, sqlFunKey } = require('@/utils/mysql')

let selectAppletList = (rows = {}) => {
  let sqlString = `SELECT
  a.id,a.appid,a.description,a.downloads,a.name,a.readme_content,a.icon,a.user_name,a.authority,
  v.version,
  v.storeid,
  v.id AS vid,v.filename,v.size
FROM
  code_engine_appletstore AS a
LEFT JOIN code_engine_appletstore_version AS v ON a.id = v.storeid WHERE a.versionid = v.id `

  let sqlarr = [
    {
      key: "userId",
      sql: " AND a.user_id = ? "
    }
  ]

  let sqlRow = sqlFunKey(rows, sqlarr)
  if (sqlRow.sqlString) sqlString += sqlRow.sqlString


  // 分页数据
  let page = handlePage(rows)
  if (page.length !== 0) sqlRow.value.push(...page), (sqlString += ' LIMIT ? OFFSET ? ')

  return {
    sqlString,
    value: sqlRow.value
  }
}



let selectAppletPage = (rows = {}) => {
  let sqlString = ` SELECT
  a.id,a.appid,a.description,a.downloads,a.name,a.readme_content,a.icon,a.user_name, 
  v.version, v.storeid, v.id AS vid,v.filename,v.size FROM code_engine_appletstore AS a
LEFT JOIN code_engine_appletstore_version AS v ON a.id = v.storeid WHERE a.versionid = v.id  AND a.state = 1 `

  let sqlarr = [
    {
      key: "authority",
      sql: " AND a.authority = 1 " // 判断是否登录下载
    },
    {
      key: "search",
      sql: " AND a.name like concat('%', ?, '%') "
    }
  ]

  let sqlRow = sqlFunKey(rows, sqlarr)
  if (sqlRow.value.length > 0) sqlString += sqlRow.sqlString

  // 分页数据
  let page = handlePage(rows)
  if (page.length !== 0) sqlRow.value.push(...page), (sqlString += ' LIMIT ? OFFSET ? ')

  return {
    sqlString,
    value: sqlRow.value
  }

}



let updateAppletstore = (rows = {}) => {
  let sqlarr = [
    {
      key: "name",
      sql: " name = ?,"
    },
    {
      key: "description",
      sql: " description = ?,"
    },
    {
      key: "readmeContent",
      sql: " readme_content = ?,"
    },
    {
      key: "authority",
      sql: " authority = ? "
    },
    {
      key: "id",
      sql: " WHERE id= ? "
    },
    {
      key: "userId",
      sql: " AND user_id= ? "
    }

  ]


  let sqlRow = sqlFunKey(rows, sqlarr)
  let sqlString = 'update code_engine_appletstore set ' + sqlRow.sqlString

  return {
    sqlString,
    value: sqlRow.value
  }
}


module.exports = {
  selectAppletPage,
  updateAppletstore,
  selectAppletList
}