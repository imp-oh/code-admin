const { handlePage, sqlFunKey } = require('@/utils/mysql')

let selectBaseCategoryVo = "select category_id, category_name, category_sort, status, create_by, create_time, update_by, update_time, remark, category_image from base_category "


let selectBaseCategoryList = (rows = {}) => {
    let sqlarr = [
        {
            key: 'categoryName',
            sql: " and category_name like concat('%', ?, '%') "
        },
        {
            key: 'categorySort',
            sql: " and category_sort = ? ",
            isNull: true
        },
        {
            key: 'status',
            sql: " and status = ? "
        },
        {
            key: 'categoryImage',
            sql: " and category_image = ? "
        }
    ]

    let sqlString = selectBaseCategoryVo
    let sqlRow = sqlFunKey(rows, sqlarr)
    if (sqlRow.value.length > 0) (sqlString += ' where '), (sqlString += sqlRow.sqlString.substring(4))
    sqlString += 'order by category_sort '

    // 分页数据
    let page = handlePage(rows)
    if (page.length !== 0) sqlRow.value.push(...page), (sqlString += ' LIMIT ? OFFSET ? ')

    return {
        sqlString,
        value: sqlRow.value
    }
}



let insertBaseCategory = (rows = {}) => {
    let sqlarr = [
        {
            key: "categoryName",
            sql: " category_name, "
        },
        {
            key: "categorySort",
            sql: " category_sort, "
        },
        {
            key: "status",
            sql: " status, "
        },
        {
            key: "remark",
            sql: " remark, "
        },
        {
            key: "categoryImage",
            sql: " category_image, "
        },
        {
            key: "createBy",
            sql: " create_by, "
        },
        {
            key: "createTime",
            sql: " create_time "
        },
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    let sqlString = `insert into base_category(${sqlRow.sqlString}) values (${sqlRow.value.map(() => '?').join(',')})`

    return {
        sqlString,
        value: sqlRow.value
    }
}


let selectBaseCategoryByCategoryId = selectBaseCategoryVo + " where category_id = ?"


let updateBaseCategory = (rows = {}) => {
    let sqlarr = [
        {
            key: "categoryName",
            sql: " category_name = ?, ",
        },
        {
            key: "categorySort",
            sql: " category_sort = ?, ",
            isNull: true
        },
        {
            key: "status",
            sql: " status = ?, "
        },
        {
            key: "remark",
            sql: " remark = ?, "
        },
        {
            key: "categoryImage",
            sql: " category_image = ?, ",
            isNull: true
        },
        {
            key: "updateBy",
            sql: " update_by = ?, "
        },
        {
            key: "updateTime",
            sql: " update_time = ? "
        },
        {
            key: "categoryId",
            sql: "  where category_id =? "
        }
    ]


    let sqlRow = sqlFunKey(rows, sqlarr)
    let sqlString = 'update base_category set ' + sqlRow.sqlString

    return {
        sqlString,
        value: sqlRow.value
    }

}


let deleteBaseCategoryByCategoryIds = (rows = []) => {
    let sqlString = `delete from base_category where category_id in (${rows.map(() => '?').join(',')})`
    return {
        sqlString,
        value: rows
    }
}

module.exports = {
    deleteBaseCategoryByCategoryIds,
    updateBaseCategory,
    selectBaseCategoryByCategoryId,
    insertBaseCategory,
    selectBaseCategoryList,
    selectBaseCategoryVo
}