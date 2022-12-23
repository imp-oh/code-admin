let appletService = require('../service/appletService')

/** 用户发布小程序列表 */
let list = async (req, res) => {
  let { user } = req.loginUser
  req.query.userId = user.userId
  let rows = await appletService.selectAppletList(req.query)

  res.send({
    rows: rows || [],
    code: 200,
    msg: "操作成功"
  })

}



/** 商场展示页面 */
let page = async (req, res) => {
  let rows = await appletService.selectAppletPage(req.query)
  res.send({
    rows: rows || [],
    code: 200,
    msg: "修改成功"
  })
}



/**
 * 小程序信息修改
 */
let edit = async (req, res) => {
  await appletService.updateAppletstore(req.body)
  res.send({
    code: 200,
    msg: "修改成功"
  })
}



let remove = async (req, res) => {
  let { user } = req.loginUser
  let { id } = req.params
  await appletService.deleteAppletstore(id, user.userId)

  res.send({
    code: 200,
    msg: "操作成功"
  })
}

module.exports = {
  remove,
  page,
  list,
  edit
}