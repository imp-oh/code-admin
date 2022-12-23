

import request from '@/utils/request'

// 查询申报
export function list (params) {
  return request({
    url: '/monthly/manage/list',
    method: 'get',
    params
  })
}

// 查询申报详细
export function getPost (postId) {
  return request({
    url: '/monthly/manage/' + postId,
    method: 'get'
  })
}

// 添加申报
export function addPost (data) {
  return request({
    url: '/monthly/manage/add',
    method: 'post',
    data
  })
}

// 修改岗位
export function updatePost (data) {
  return request({
    url: '/monthly/manage',
    method: 'put',
    data: data
  })
}

// 删除岗位
export function delPost (postId) {
  return request({
    url: '/monthly/manage/' + postId,
    method: 'delete'
  })
}

export function changeFormStatus (monthlyId, status) {
  return request({
    url: '/monthly/manage/changeStatus',
    method: 'put',
    data: {
      monthlyId, status
    }
  })
}
