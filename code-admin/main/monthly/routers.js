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

/**
 * 警告  警告   警告  警告  警告
 *  路由注册有顺序问题！！！！！！！！！！！！！！！！！！！！！！！！
 * 先注册死路由 ，后在注册动态路由，不然会先进动态路由
 */


let formRouter = require('./api/form')
let manageRouter = require('./api/manage')
let backlogRouter = require('./api/backlog')
let taskRouter = require('./api/task')

const routerAll = [
  {
    path: '/monthly',
    children: [
      {
        path: '/form',
        method: 'put',
        component: formRouter.edit,
        preAuthorize: {
          hasPermi: 'monthly:form:edit'
        }
      },
      {
        path: '/form/list',
        method: 'get',
        component: formRouter.list,
        preAuthorize: {
          hasPermi: 'monthly:form:list'
        }
      },
      {
        path: '/form/add',
        method: 'post',
        component: formRouter.add,
        preAuthorize: {
          hasPermi: 'monthly:form:add'
        }
      },
      {
        path: '/form/changeStatus',
        method: 'put',
        component: formRouter.changeStatus,
        preAuthorize: {
          hasPermi: 'monthly:form:edit'
        }
      },
      {
        path: '/form/finish',
        method: 'put',
        component: formRouter.finish,
        preAuthorize: {
          hasPermi: 'monthly:form:edit'
        }
      },
      {
        path:'/form/taskList',
        method: 'get',
        component: formRouter.taskList,
        preAuthorize: {
          hasPermi: 'monthly:form:list'
        }
      },
      {
        path: '/form/:monthlyId',
        method: 'get',
        component: formRouter.getInfo,
        preAuthorize: {
          hasPermi: 'monthly:form:query'
        }
      },
      {
        path: '/form/:monthlyIds',
        method: 'delete',
        component: formRouter.remove,
        preAuthorize: {
          hasPermi: 'monthly:form:remove'
        }
      },

      {
        path: '/form/view/:monthlyId',
        method: 'get',
        component: formRouter.getView,
        preAuthorize: {
          hasPermi: 'monthly:form:query'
        }
      },
      {
        path: '/form/export',
        method: 'post',
        component: formRouter.getExport,
        preAuthorize: {
          hasPermi: 'monthly:form:export'
        }
      },
      {
        path: '/form/importData',
        method: 'post',
        component: formRouter.importData,
        preAuthorize: {
          hasPermi: 'monthly:form:import'
        }
      },



      // 申报管理
      {
        path: '/manage/list',
        method: 'get',
        component: manageRouter.list,
        preAuthorize: {
          hasPermi: 'monthly:manage:list'
        }
      },
      {
        path: '/manage/export',
        method: 'post',
        component: manageRouter.getExport,
        preAuthorize: {
          hasPermi: 'monthly:manage:export'
        }
      },




      /** 待办 */
      {
        path: '/backlog',
        method: 'put',
        component: backlogRouter.edit,
        preAuthorize: {
          hasPermi: 'monthly:backlog:edit'
        }
      },
      {
        path: '/backlog/list',
        method: 'get',
        component: backlogRouter.list,
        preAuthorize: {
          hasPermi: 'monthly:backlog:list'
        }
      },
      {
        path: '/backlog/:monthlyId',
        method: 'get',
        component: backlogRouter.getInfo,
        preAuthorize: {
          hasPermi: 'monthly:backlog:query'
        }
      },


      /** 任务清单  */
      {
        path: '/task',
        method: 'post',
        component: taskRouter.add,
        preAuthorize: {
          hasPermi: 'monthly:task:add'
        }
      },
      {
        path: '/task',
        method: 'put',
        component: taskRouter.edit,
        preAuthorize: {
          hasPermi: 'monthly:task:edit'
        }
      },
      {
        path: '/task/list',
        method: 'get',
        component: taskRouter.list,
        preAuthorize: {
          hasPermi: 'monthly:task:list'
        }
      },
      {
        path: '/task/getTaskAll',
        method: 'get',
        component: taskRouter.getTaskAll
      },

      {
        path: '/task/:taskId',
        method: 'get',
        component: taskRouter.getInfo,
        preAuthorize: {
          hasPermi: 'monthly:task:query'
        }
      },
      {
        path: '/task/:taskIds',
        method: 'delete',
        component: taskRouter.remove,
        preAuthorize: {
          hasPermi: 'monthly:task:remove'
        }
      },

    ]
  }
]

module.exports = routerAll
