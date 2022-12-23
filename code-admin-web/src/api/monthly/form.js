

import request from '@/utils/request'

// 查询申报
export function list (params) {
  return request({
    url: '/monthly/form/list',
    method: 'get',
    params
  })
}

// 查询申报
export function getTaskList (params) {
  return request({
    url: '/monthly/form/taskList',
    method: 'get',
    params
  })
}

// 查询申报详细
export function getPost (postId) {
  return request({
    url: '/monthly/form/' + postId,
    method: 'get'
  })
}
// 查询申报详细
export function getViewPost (postId) {
  return request({
    url: '/monthly/form/view/' + postId,
    method: 'get'
  })
}

// 添加申报
export function addPost (data) {
  return request({
    url: '/monthly/form/add',
    method: 'post',
    data
  })
}

// 修改申报
export function updatePost (data) {
  return request({
    url: '/monthly/form',
    method: 'put',
    data: data
  })
}

// 更新申报
export function updateFinishPost (data) {
  return request({
    url: '/monthly/form/finish',
    method: 'put',
    data: data
  })
}



// 删除岗位
export function delPost (postId) {
  return request({
    url: '/monthly/form/' + postId,
    method: 'delete'
  })
}

export function changeFormStatus (monthlyId, status) {
  return request({
    url: '/monthly/form/changeStatus',
    method: 'put',
    data: {
      monthlyId, status
    }
  })
}



// 添加-获取默认信息
export function initInfo () {
  return request({
    url: '/monthly/form/initInfo',
    method: 'get'
  })
}