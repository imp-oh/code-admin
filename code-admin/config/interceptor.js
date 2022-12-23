/*
 * @Author: Chen
 * @Email: cnblogco@qq.com
 * @Date: 2020-10-12 12:37:33
 * @LastEditTime: 2022-03-20 14:06:49
 * @Description: 拦截器
 */

const { express, app } = require('../config/index')
const { codeengine } = require('../utils/crypto')

const session = require('express-session')
const { rules } = require('@/utils/fromValidate')

// https://github.com/davidbanham/express-async-errors
const requestIp = require('request-ip');
require('express-async-errors'); // 错误拦截
const cors = require('cors')


/**
 * 跨域
 */
const whitelist = ['http://127.0.0.1:3000']

let corsOptions;
const corsOptionsDelegate = function (req, callback) {
  if (whitelist.indexOf(req.header('Origin')) !== -1) {
    corsOptions = {
      origin: true,
      credentials: true,
      methods: ['PUT', 'POST', 'GET', 'DELETE'],
      allowedHeaders: 'Origin,No-Cache,X-Requested-With,If-Modified-Since,Pragma,Last-Modified,Cache-Control,Expires,Content-Type,Access-Control-Allow-Credentials,DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Cache-Webcdn,x-bilibili-key-real-ip,x-backen,ppfv'

    } //在CORS响应中反映(启用)请求的起源
  } else {
    corsOptions = { origin: false } // 拦截请求
  }
  callback(null, corsOptions) //  error  options
}

app.use(cors(corsOptionsDelegate))

/** 挂在ip */
app.use(requestIp.mw())


app.set('x-powered-by', false)  // 禁止显示框架

// app.disable('etag');

/** 接口配置 */
app.use(express.urlencoded({ extended: false }));





/** session */
app.use(session({
  secret: "code_engine",		//设置签名秘钥  内容可以任意填写 
  // cookie: { maxAge: 5 * 1000 * 60, httpOnly: true }, // 五分钟后失效
  cookie: { maxAge: 180 * 24 * 60 * 60 * 1000, httpOnly: true },
  resave: true,			//强制保存，如果session没有被修改也要重新保存
  saveUninitialized: false		//如果原先没有session那么久设置，否则不设置
}))


app.all("*", (req, res, next) => {

  res.header("Cache-Control", "no-siteApp,no-cache,must-revalidate,no-transform"); // 禁止ie缓存
  res.header("Pragma", "no-cache"); // 禁止ie缓存

  // 方法挂载
  req.codeengine = codeengine
  req.rules = rules

  // routes 拦截
  next()
})
