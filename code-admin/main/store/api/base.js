let baseService = require('../service/baseService')


let appliedFile = async (req, res) => {
  await baseService.insertAppletstore(req)
  res.send({
    code: 200,
    msg: "操作成功"
  })
}


module.exports = {
  appliedFile
}