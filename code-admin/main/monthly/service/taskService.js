
const dbconfig = require("@/config/dbconfig")


const { isUserAdmin, isRolesAdmin } = require('@/utils/permissions')
const { formatTime } = require('@/utils/validate')
const userConstants = require('@/enums/userConstants')
const taskMapper = require('../db/taskMapper')



/**
 * 根据条件分页查询申报列表
 * 
 * @param form 申报信息信息
 * @param loginUser 用户登录信息
 * @return 申报信息集合信息
 */
let selectTaskList = async (form = {}, loginUser = {}) => {
    let db = taskMapper.selectTaskList(form, loginUser)
    let list = await dbconfig.sqlConnect(db.sqlString, db.value, 'yyyy-MM-dd HH:mm:ss')
    return list
}


let startPage = async (form = {}) => {
    let body = JSON.parse(JSON.stringify(form))
    delete body.pageNum
    delete body.pageSize
    let db = taskMapper.selectTaskList(body)
    let sqlString = db.sqlString.replace(/^select(.*?)from/gi, 'SELECT count(0) AS countNum FROM ')
    let [info] = await dbconfig.sqlConnect(sqlString, db.value)
    return Number(info.countNum)
}




/** 判断 任务清单名称*/
let checkTaskName = async (task = {}) => {
    let [info] = await dbconfig.sqlConnect(taskMapper.checkTaskName, task.taskName)

    if (info && info.deptId == task.deptId && info.taskId != task.taskId) throw { code: 500, msg: '部门内任务名称不能重复' }
}



/** 
 * 申报详情查询 
 * taskId
 * */
let selectPostById = async (taskId = '') => {
    let [info] = await dbconfig.sqlConnect(taskMapper.selectPostById, taskId, 'yyyy-MM-dd HH:mm:ss')
    return info
}




/** 添加任务清单数据 */
let insertTask = async (task = {}) => {
    let db = taskMapper.insertTask(task)
    let { affectedRows } = await dbconfig.sqlConnect(db.sqlString, db.value)
    return affectedRows

}


/** 更新申报主表 */
let updateTask = async (form = {}) => {
    let db = taskMapper.updateTask(form)
    let { affectedRows } = await dbconfig.sqlConnect(db.sqlString, db.value)
    return affectedRows
}


/** 任务清单 id 删除 */
let deletePostByIds = async (taskIds = []) => {
    let db = taskMapper.deleteTaskIds(taskIds)
    let { affectedRows } = await dbconfig.sqlConnect(db.sqlString, db.value)
    return affectedRows
}

/** 查询相同部门数据 */
let selectTaskAll = async (task = {}, loginUser) => {
    let db = taskMapper.selectTaskAll(task, loginUser)
    return await dbconfig.sqlConnect(db.sqlString, db.value,'yyyy-MM-dd HH:mm:ss')
}


module.exports = {
    selectTaskAll,
    deletePostByIds,
    updateTask,
    selectPostById,
    insertTask,
    checkTaskName,
    startPage,
    selectTaskList
}