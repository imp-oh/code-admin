import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listCategory(query) {
  return request({
    url: '/article/category/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getCategory(categoryId) {
  return request({
    url: '/article/category/' + categoryId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addCategory(data) {
  return request({
    url: '/article/category',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateCategory(data) {
  return request({
    url: '/article/category',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delCategory(categoryId) {
  return request({
    url: '/article/category/' + categoryId,
    method: 'delete'
  })
}
