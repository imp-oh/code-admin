

import request from '@/utils/request'

// 查询申报
export function list (params) {
  return request({
    url: '/monthly/backlog/list',
    method: 'get',
    params
  })
}

// 查询申报详细
export function getPost (postId) {
  return request({
    url: '/monthly/backlog/' + postId,
    method: 'get'
  })
}

// 添加申报
export function addPost (data) {
  return request({
    url: '/monthly/backlog/add',
    method: 'post',
    data
  })
}

// 修改岗位
export function updatePost (data) {
  return request({
    url: '/monthly/backlog',
    method: 'put',
    data: data
  })
}

// 删除岗位
export function delPost (postId) {
  return request({
    url: '/monthly/backlog/' + postId,
    method: 'delete'
  })
}

export function changeBacklogStatus (monthlyId, status) {
  return request({
    url: '/monthly/backlog/changeStatus',
    method: 'put',
    data: {
      monthlyId, status
    }
  })
}
