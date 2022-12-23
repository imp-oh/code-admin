import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listArticle(query) {
  return request({
    url: '/article/editor/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getArticle(articleId) {
  return request({
    url: '/article/editor/' + articleId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addArticle(data) {
  return request({
    url: '/article/editor',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateArticle(data) {
  return request({
    url: '/article/editor',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delArticle(articleId) {
  return request({
    url: '/article/editor/' + articleId,
    method: 'delete'
  })
}
