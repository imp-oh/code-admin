import request from '@/utils/request'

// 查询申报列表
export function listTask(query) {
  return request({
    url: '/monthly/task/list',
    method: 'get',
    params: query
  })
}

export function taskAll(query) {
  return request({
    url: '/monthly/task/getTaskAll',
    method: 'get',
    params: query
  })
}

// 查询申报详细
export function getTask(taskId) {
  return request({
    url: '/monthly/task/' + taskId,
    method: 'get'
  })
}

// 新增申报
export function addTask(data) {
  return request({
    url: '/monthly/task',
    method: 'post',
    data: data
  })
}

// 修改申报
export function updateTask(data) {
  return request({
    url: '/monthly/task',
    method: 'put',
    data: data
  })
}

// 删除申报
export function delTask(taskId) {
  return request({
    url: '/monthly/task/' + taskId,
    method: 'delete'
  })
}
