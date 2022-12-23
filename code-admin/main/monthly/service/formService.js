
const dbconfig = require("@/config/dbconfig")


const { isUserAdmin, isRolesAdmin } = require('@/utils/permissions')
const { formatTime } = require('@/utils/validate')
const userConstants = require('@/enums/userConstants')
const formMapper = require('../db/formMapper')
const { selectConfigByKey } = require('@/main/system/service/sysConfigServiceImpl')
const config = require('@/config')
const Excel = require('exceljs')
const path = require('path')
const configUpload = require('@/utils/upload')
const fs = require('fs')

/**
 * 根据条件分页查询申报列表
 * 
 * @param form 申报信息信息
 * @return 申报信息集合信息
 */
let selectFormList = async (form = {}) => {
    let db = formMapper.selectFormList(form)
    let list = await dbconfig.sqlConnect(db.sqlString, db.value, 'yyyy-MM-dd HH:mm:ss')
    let day = await selectConfigByKey('monthly.valid.time')
    let isDay = Number(day) < new Date().getDate()
    list.forEach(item => {
        item.yearMonth = formatTime(item.yearMonth, 'yyyy-MM')
        item.isDay = isDay
    })
    return list
}


let startPage = async (form = {}) => {
    let body = JSON.parse(JSON.stringify(form))
    delete body.pageNum
    delete body.pageSize
    let db = formMapper.selectFormList(body)
    let sqlString = db.sqlString.replace(/^select(.*?)from/gi, 'SELECT count(0) AS countNum FROM ')
    let [info] = await dbconfig.sqlConnect(sqlString, db.value)
    return Number(info.countNum)
}

/** 
 * 申报详情查询 
 * form  {}
 * */
let selectPostById = async (form = {}) => {
    let db = formMapper.selectFormList(form)
    let [info] = await dbconfig.sqlConnect(db.sqlString, db.value, 'yyyy-MM-dd HH:mm:ss')
    let tableData = await selecFormColumnList(form)
    let data = {
        leader: info.leader,
        yearMonth: info.yearMonth,
        monthlyId: info.monthlyId,
        workerName: info.workerName,
        tableData
    }
    return data
}

let selecFormColumnList = async (form) => {
    let tableData = await dbconfig.sqlConnect(formMapper.selecFormColumnList, form.monthlyId, 'yyyy-MM-dd HH:mm:ss')
    let day = await selectConfigByKey('monthly.valid.time')
    let isDay = Number(day) < new Date().getDate()
    tableData.forEach(item => {
        item.isDay = isDay
    })
    return tableData
}





/** 添加申报数据 */
let insertMonthlyTable = async (form = {}) => {
    let { tableData = [] } = form
    let db = formMapper.insertMonthlyTable(form)
    let { insertId } = await dbconfig.sqlConnect(db.sqlString, db.value)
    await insertMonthlyTableColumn(insertId, tableData)
}

let insertMonthlyTableColumn = async (insertId, tableData = []) => {
    let db = formMapper.insertMonthlyTableColumn(insertId, tableData)
    let value = []
    db.value.map(item => value.push(...item))

    await dbconfig.sqlConnect(db.sqlString, value)
}


/** 判断申报用户数据，每月只能申报一次 */
let checkUserData = async (form = {}) => {
    let [info] = await dbconfig.sqlConnect(formMapper.checkUserData, [form.userId, form.yearMonth])
    if (info && info.monthlyId != form.monthlyId) throw { code: 500, msg: '当月数据已提交' }
}


/**
 * 校验用户是否有申报数据权限
 * 
 * @param monthlyId 申报id
 * @param loginUser  用户登录信息
 * 
 */
let checkFormDataScope = async (monthlyId = '', loginUser = {}) => {
    let db = formMapper.selectFormList({ monthlyId }, loginUser)
    let list = await dbconfig.sqlConnect(db.sqlString, db.value)
    if (list.length === 0) throw { code: 500, msg: "没有权限访问用户数据!" }
}


/** 更新申报主表 */
let updateMonthlyTable = async (form = {}) => {
    let day = await selectConfigByKey('monthly.valid.time')
    let isDay = Number(day) < new Date().getDate()

    let db = formMapper.updateMonthlyTable(form)
    let { affectedRows } = await dbconfig.sqlConnect(db.sqlString, db.value)
    if (affectedRows > 0 && form.tableData) {
        let insertArray = []

        for (let i in form.tableData) {
            let row = form.tableData[i]
            if (isDay && !row.columnId && !row.beforeId) row.status = 2 // 新增
            if (isDay && !row.columnId && row.beforeId) await updateMonthlyTableColumnStatus([1, row.beforeId]), row.status = 2 // 更新旧表数据

            // 在规定时间修改，则更新数据
            if (row.columnId && row.status != 1) await updateMonthlyTableColumn(row)

            // 在规定时间内状态为1 则删除当前数据
            if (row.columnId && !isDay && row.status == 1) await dbconfig.sqlConnect(formMapper.deleteMonthlyTableColumnId, row.columnId)

            if (!row.columnId) {
                insertArray.push({
                    beforeId: row.beforeId || null,
                    target: row.target,
                    workload: row.workload,
                    beginTime: row.beginTime,
                    endTime: row.endTime,
                    remark: row.remark || '',
                    taskId: row.taskId,
                    status: row.status,
                })
            }
        }
        if (insertArray.length > 0) await insertMonthlyTableColumn(form.monthlyId, insertArray)

    }
    return affectedRows
}


// 修改完成度
let updateMonthlyTableFinish = async (form = {}) => {
    let db = formMapper.updateMonthlyTable({
        monthlyId: form.monthlyId,
        status: 5,
        updateBy: form.updateBy,
        updateTime: form.updateTime
    })
    let { affectedRows } = await dbconfig.sqlConnect(db.sqlString, db.value)
    if (affectedRows > 0) {
        for (let i in form.tableData) {
            let row = form.tableData[i]
            if (row.columnId) await dbconfig.sqlConnect(formMapper.updateMonthlyTableColumnFinish, [row.actualBeginTime, row.actualEndTime, row.columnId])
        }
    }
}


// 更新状态
let updateMonthlyTableStatus = async (form = {}) => {
    if (form.status == 0) throw { code: 500, msg: "不能修改通过的数据！" }
    let day = await selectConfigByKey('monthly.valid.time')
    let isDay = Number(day) < new Date().getDate()
    console.log(form,isDay)

    // if (i form.status == 3) form.status = 4
    if (isDay && form.status == 5) form.status = 3
    if (!isDay && form.status == 3) form.status = 1
    if (!isDay && form.status == 5) form.status = 4

    let db = formMapper.updateMonthlyTableStatus(form)
    let { affectedRows } = await dbconfig.sqlConnect(db.sqlString, db.value)
    return {
        affectedRows,
        status: form.status
    }
}




// 更新状态
let updateMonthlyTableColumnStatus = async (rows = []) => {
    let { affectedRows } = await dbconfig.sqlConnect(formMapper.updateMonthlyTableColumnStatus, rows)
    return affectedRows
}

/** 更新申报副表 */
let updateMonthlyTableColumn = async (rows = {}) => {
    let db = formMapper.updateMonthlyTableColumn(rows)
    let { affectedRows } = await dbconfig.sqlConnect(db.sqlString, db.value)
    return affectedRows
}

/** 申报id 删除 */
let deletePostByIds = async (monthlyIds = [], userId = '') => {
    for (let i in monthlyIds) {
        let monthlyId = monthlyIds[i]
        let { affectedRows } = await dbconfig.sqlConnect(formMapper.deleteMonthlyTable, [monthlyId, userId])
        if (affectedRows > 0) await dbconfig.sqlConnect(formMapper.deleteMonthlyTableColumn, monthlyId)
    }
}


/** 查询全部数据 */
let selectAll = async (form = {}) => {
    let rows = await selectFormList(form)
    for (let i = 0; i < rows.length; i++) {
        let row = rows[i]
        row.yearMonth = formatTime(row.yearMonth, 'yyyy-MM')
        row.tableData = await selecFormColumnList({ monthlyId: row.monthlyId })
        if (row.tableData) {
            for (let i = 0; i < row.tableData.length; i++) {
                let item = row.tableData[i]
                item.beginTime = formatTime(item.beginTime, 'yyyy-MM-dd')
                item.endTime = formatTime(item.endTime, 'yyyy-MM-dd')
                item.actualBeginTime = formatTime(item.actualBeginTime, 'yyyy-MM-dd')
                item.actualEndTime = formatTime(item.actualEndTime, 'yyyy-MM-dd')
            }
        }
    }
    return rows
}


/** 导出xlsx */
let selectExport = async (form = {}) => {
    let all = await selectAll(form)
    if (all.length === 0) return ''
    return await exportXlsx(all)
}


// 导出一个xlsx
let exportXlsx = async (all) => {
    const workbook = new Excel.Workbook()
    await workbook.xlsx.readFile(path.join(config.base, 'file', 'diy.xlsx'))
    const detailSheet = workbook.getWorksheet(1)

    for (let i = 0; i < all.length; i++) {
        let yearMonth = all[i].yearMonth
        if (i === 0) detailSheet.name = `Sheet${yearMonth}`
        if (i > 0) {
            const sheet2 = workbook.addWorksheet(`Sheet${yearMonth}`)
            detailSheet.eachRow((row, rowNumber) => {
                var newRow = sheet2.getRow(rowNumber);
                row.eachCell({ includeEmpty: true }, (cell, colNumber) => {
                    const dobCol = detailSheet.getColumn(colNumber)
                    const newCol = sheet2.getColumn(colNumber)
                    newCol.width = dobCol.width
                    newRow.height = row.height
                    var newCell = newRow.getCell(colNumber)
                    for (var prop in cell) {
                        newCell[prop] = cell[prop];
                    }
                })
            })
            sheet2.getRow(sheet2._rows.length - 2).getCell(1).value = null // 清除占位符
        }
    }
    detailSheet.getRow(detailSheet._rows.length - 2).getCell(1).value = null // 清除占位符




    for (let i = 0; i < all.length; i++) {
        let row = all[i]
        const sheet = workbook.getWorksheet(i + 1)
        sheet.getRow(2).getCell(2).value = row.nickName // 设置姓名
        sheet.getRow(2).getCell(4).value = row.yearMonth // 年月
        sheet.getRow(2).getCell(6).value = row.leader // 主管

        let formula = []
        let result = 0
        for (let i = 0; i < row.tableData.length; i++) {
            let item = row.tableData[i]
            let index = 4 + i
            let workload = Number(item.workload) > 0 ? Number(item.workload) / 100 : 0
            let workDone = Number(item.workDone) > 0 ? Number(item.workDone) / 100 : 0
            sheet.insertRow(index, [
                i + 1,
                item.target,
                workload,
                item.beginTime,
                item.endTime,
                item.remark,
                item.actualBeginTime,
                item.actualEndTime,
                workDone,
                item.jobRating,
            ], 'o+')
            formula.push(`(I${index}*C${index})`)

            result += (item.workload * item.workDone) / 10000
        }

        sheet.getRow(sheet._rows.length - 1).getCell(9).value = { formula: formula.join('+'), result }
    }


    // 使用样式和共享字符串构造流式 XLSX 工作簿编写器
    const bufferContent = await workbook.xlsx.writeBuffer()
    return bufferContent
}


let getXlsx = async (req, rows = {}) => {
    let { fields, files } = await configUpload.upload(req, db => {
        return db.originalFilename.includes('.xlsx') && db.name === 'file'
    }, '/monthly')

    if (!files.file.filepath) return

    const workbook = new Excel.Workbook()
    await workbook.xlsx.readFile(files.file.filepath)


    let form = []

    workbook.eachSheet(function (worksheet, sheetId) {
        let sheet = worksheet
        let nickName = sheet.getRow(2).getCell(2).value // 姓名
        let yearMonth = sheet.getRow(2).getCell(4).value  // 年月
        let leader = sheet.getRow(2).getCell(6).value// 主管
        let all = []
        sheet.eachRow((row, rowNumber) => {
            if (rowNumber > 3 && rowNumber < (sheet._rows.length - 1)) {
                let key = ['', 'target', 'workload', 'beginTime', 'endTime', 'remark', 'actualBeginTime', 'actualEndTime', 'workDone', 'jobRating']
                let value = {}
                row.eachCell({ includeEmpty: true }, (cell, colNumber) => {
                    let index = colNumber - 1
                    if (key[index]) value[key[index]] = cell.value
                    if (key[index] === 'workload' || key[index] === 'workDone') value[key[index]] = parseInt(cell.value * 100)

                    let timeKey = ['beginTime', 'endTime', 'actualBeginTime', 'actualEndTime']
                    if (key[index] && timeKey.includes(key[index])) {
                        if (cell.value) value[key[index]] = formatTime(cell.value, 'yyyy-MM-dd HH:mm:ss')
                        else value[key[index]] = null
                    }

                })
                value.beforeId = null
                if (value.target && value.workload > 0) all.push(value)
            }
        })

        form.push({
            nickName,
            yearMonth: formatTime(yearMonth, 'yyyy-MM-dd HH:mm:ss'),
            leader,
            tableData: all
        })
    });


    // 删除文件
    fs.unlinkSync(files.file.filepath)


    for (let i = 0; i < form.length; i++) {
        let row = form[i]

        await insertMonthlyTable({
            ...row,
            ...rows
        })
    }
}



let selectTaskList = async (form = {}) => {
    let db = formMapper.selectTaskAll(form)
    let rows = await dbconfig.sqlConnect(db.sqlString, db.value, 'yyyy-MM-dd')
    return rows
}


module.exports = {
    selectTaskList,
    getXlsx,
    exportXlsx,
    selectExport,
    updateMonthlyTableFinish,
    updateMonthlyTableStatus,
    deletePostByIds,
    selectPostById,
    updateMonthlyTableColumn,
    updateMonthlyTable,
    checkFormDataScope,
    insertMonthlyTable,
    checkUserData,
    startPage,
    selectFormList
}