/*
 * @Author: Chen
 * @Email: codeeetop@qq.com
 * @Date: 2022-03-15 11:30:47
 * @LastEditTime: 2022-04-13 22:21:52
 * @Description: 登录模块
 */

const { tokenEncrypt, tokenDecrypt } = require('@/utils/crypto')
const redis = require("@/utils/redis")
const { uuid } = require('@/utils/util')
const { constants } = require('@/config')
const { bcryptEncrypt, bcryptDecrypt, rsaDecrypt } = require('@/utils/crypto')

const configService = require('@/main/system/service/sysConfigServiceImpl')
const loginService = require('@/main/system/service/sysLoginServiceImpl')
const permissionService = require('@/main/system/service/sysPermissionService')
const menuService = require('@/main/system/service/sysMenuServiceImpl')
const userService = require('@/main/system/service/sysUserServiceImpl')

const userConstants = require('@/enums/userConstants')


let errorTile = (user_name, title, userId) => { return { msg: `${userId ? '修改' : '新增'}用户'${user_name}'失败，${title}已存在`, code: 500 } }




/**
 * 登录方法
 * 
 * @param req.body 登录信息
 * @return 结果
 * 
 * @PostMapping("/login")
 */
let login = async (req, res) => {
  // 表单验证
  await req.rules({
    username: [{ required: true, message: '请输入账号' }],
    password: [{ required: true, message: '请输入密码' }]
  }, req.body)

  let user = await loginService.login(req, res) // 验证
  let loginToken = constants.LOGIN_TOKEN_KEY + user.token
  res.send({
    token: tokenEncrypt(loginToken),
    code: 200,
    msg: '登录成功'
  })
}



/**
 *  用户退出
 * 
 * @GetMapping("logout")
 */
const logout = (req, res) => {
  let { gitce = '' } = req.headers
  let token = tokenDecrypt(gitce).data
  if (token) redis.client.del(token)
  res.send({
    code: 200,
    msg: "操作成功"
  })
}



/**
 * 生成验证码
 * 
 * @GetMapping("/captchaImage")
 */
const captchaImage = async (req, res) => {
  let captchaOnOff = await configService.selectCaptchaOnOff();
  let codeConfig = {}
  if (captchaOnOff) codeConfig = configService.captcha()
  res.send({
    captchaOnOff: captchaOnOff,
    code: 200,
    img: captchaOnOff ? codeConfig.img : "",
    msg: "操作成功",
    uuid: uuid()
  })
}




/**
 * 获取用户信息
 * 
 * @return 用户信息
 * @GetMapping("getInfo")
 */
const getInfo = (req, res) => {
  let { permissions = [], user = {} } = req.loginUser
  delete user.password
  res.send({
    code: 200,
    msg: "操作成功",
    permissions,
    roles: permissionService.getRolePermission(user),
    user: user
  })
}





/**
 * 获取路由信息
 * 
 * @return 路由信息
 * @GetMapping("getRouters")
 */
const getRouters = async (req, res) => {
  let { user } = req.loginUser
  let data = await menuService.selectMenuTreeByUserId(user.userId)
  res.send({
    msg: "操作成功",
    code: 200,
    data: data
  })
}



/**
 * 获取邮箱验证码
 */
const verify = async (req, res) => {
  let { email } = req.body
  // 表单验证
  await req.rules({
    email: [{ required: true, message: '请输入电子邮箱', trigger: 'blur' }, {
      type: 'email',
      message: '邮箱格式错误',
      trigger: 'blur',
    }]
  }, req.body)

  let userInfo = await userService.checkEmailStatus(req.body)
  if (!userInfo) throw { code: 500, msg: "邮箱错误，请输入账号邮箱" }


  // 获取邮箱过期时间
  let ttl = await redis.client.ttl(userInfo.email)
  if (ttl > 180) throw { code: 500, msg: "邮箱请求过快，请120秒后重试" }

  let code = Math.floor(Math.random() * (999999 - 100000)) + 100000;
  redis.set(userInfo.email, code)
  // 60秒 * 分钟
  redis.client.expire(userInfo.email, 60 * 5)

  await configService.mailer(code, userInfo.email)

  return res.send({
    code: 200,
    msg: '发送成功'
  })
}



/**
 * 修改密码
 */
let retrieve = async (req, res) => {

  const { password, email, code } = req.body
  // 表单验证
  await req.rules({
    email: [{ required: true, message: '请输入电子邮箱', trigger: 'blur' }, {
      type: 'email',
      message: '邮箱格式错误',
      trigger: 'blur',
    }]
  }, req.body)

  let key = await redis.get(email)
  if (!key) throw { code: 500, msg: "验证码失效，请重新获取" }
  if (key !== code) throw { code: 500, msg: "验证码错误，请重新输入" }
  let userInfo = await userService.checkEmailStatus(req.body)
  if (!userInfo) throw { code: 500, msg: "邮箱账户不存在" }

  const newPasswordDecrypt = rsaDecrypt(password)
  let bcryptPassword = bcryptEncrypt(newPasswordDecrypt)
  await userService.resetUserPwd(userInfo.userName, bcryptPassword)

  res.send({
    code: 200,
    msg: "222"
  })

}



/**
 * 账号注册
 */

let register = async (req, res) => {
  let { email, userName, password } = req.body
  if (userConstants.NOT_UNIQUE === await userService.checkUserNameUnique(userName)) throw errorTile(userName, '登录账号')
  if (email && userConstants.NOT_UNIQUE === await userService.checkEmailUnique(req.body)) throw errorTile(userName, '邮箱账号')

  const newPasswordDecrypt = rsaDecrypt(password)
  req.body.password = bcryptEncrypt(newPasswordDecrypt)
  req.body.createTime = new Date()
  req.body.nickName = ''
  await userService.insertUser(req.body)


  res.send({
    code: 200,
    msg: "操作成功",
  })
}








module.exports = {
  login, captchaImage, getInfo, logout, getRouters, retrieve, verify, register
}