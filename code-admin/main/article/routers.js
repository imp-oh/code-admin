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


let articleCategory = require('@/main/article/api/category')
let articlePage = require('@/main/article/api/editor')
let post = require('@/main/article/api/post')
const routerAll = [
  {
    path: '/article',
    children: [
      {
        path: '/category',
        method: 'post',
        component: articleCategory.add,
        preAuthorize: {
          hasPermi: 'article:category:add'
        }
      },
      {
        path: '/category',
        method: 'put',
        component: articleCategory.edit,
        preAuthorize: {
          hasPermi: 'article:category:edit'
        }
      },
      {
        path: '/category/list',
        method: 'get',
        component: articleCategory.list
      },
      {
        path: '/category/:categoryId',
        method: 'get',
        component: articleCategory.getInfo,
        preAuthorize: {
          hasPermi: 'article:category:query'
        }
      },
      {
        path: '/category/:categoryIds',
        method: 'delete',
        component: articleCategory.remove,
        preAuthorize: {
          hasPermi: 'article:category:remove'
        }
      },


      // 页面
      {
        path: '/editor/:articleId',
        method: 'delete',
        component: articlePage.remove
      },
      {
        path: '/editor/list',
        method: 'get',
        component: articlePage.list
      },

      {
        path: '/editor/add',
        method: 'post',
        component: articlePage.add,
      },

      {
        path: '/editor/edit',
        method: 'put',
        component: articlePage.edit
      },
      {
        path: '/editor/draft',
        method: 'put',
        component: articlePage.edit
      },
      {
        path: '/editor/upload',
        method: 'post',
        component: articlePage.upload
      },
      {
        path: '/editor/getInfo',
        method: 'get',
        component: articlePage.getInfo
      },
      {
        path: '/editor/deleteImage',
        method: 'post',
        component: articlePage.deleteImage
      },



      /** post 详情页 */
      {
        path: '/post',
        children: [
          {
            path: "/:id",
            method: 'get',
            component: post.getInfo,
            preAuthorize: {
              isAuth: false
            }
          },
          {
            path: "/list",
            method: 'get',
            component: post.list,
            preAuthorize: {
              isAuth: false
            }
          }
        ]
      }
      /** post 详情页 - end */

    ]
  }
]

module.exports = routerAll
