/**
 * path: 路由地址     => String
 * method: 请求类型   => String
 * component:回调方法 => Function
 * preAuthorize:{
 *    pathPermi: true || false  , 自动匹配接口权限   【默认值 flase】
 *    isAuth: true || false , 是否开启头部校验  【默认值 true】
 *    hasPermi:'system:user:list'  ,  string
 *    hasAnyPermi:['system:user:list'], Array string
 *    lacksPermi:'system:user:list'  ,  string 不符合权限 取反
 * }
 */

/**
 * 路由最多为2级
 * 
  一级由配置如下： 
  {
    path: '/base',
    children: []
  }
  
  二级路由：
  {
    path: '/userList',
    method: "get",
    component: base.userList
  },
 * 
 */


let appletConfig = require('./api/applet')
let baseConfig = require('./api/base')


const routerAll = [
  {
    path: '/store',
    children: [
      {
        path: '/applet/list',
        method: 'get',
        component: appletConfig.list
      },
      {
        path: '/applet/page',
        method: 'get',
        component: appletConfig.page,
        preAuthorize: {
          isAuth: false
        }
      },
      {
        path: '/applet',
        method: 'put',
        component: appletConfig.edit
      },
      {
        path: '/applet/:id',
        method: 'delete',
        component: appletConfig.remove
      },






      /** base */
      {
        path: '/base/appliedFile',
        method: 'post',
        component: baseConfig.appliedFile
      },

    ]
  },





]

module.exports = routerAll
