const { handlePage, sqlFunKey } = require('@/utils/mysql')
const { handleDataScope } = require('@/enums/dataScopeAspect')
const { isUserAdmin, isRolesAdmin } = require('@/utils/permissions')

let selectEditorList = (rows = {}, loginUser = {}) => {
    let sqlString = 'SELECT article_id,title,tags,cast(description as char) as description,`status`,views_count,cover_img FROM base_article u WHERE `status` IS NOT null '
    let sqlarr = [
        {
            key: 'title',
            sql: " and title like concat('%', ?, '%') "
        },
        {
            key: 'tags',
            sql: " and tags like concat('%', ?, '%') "
        },
        {
            key: 'status',
            sql: " and status = ? ",
            isNull: true
        },
        {
            key: 'articleId',
            sql: " and article_id = ? ",
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    // let dataScope = handleDataScope({ userAlias: "u", deptAlias: "d", loginUser })  // 数据权控制
    // console.log(dataScope)
    // sqlString += dataScope
    if (sqlRow.value.length > 0) sqlString += sqlRow.sqlString


    sqlString += `${!isUserAdmin(loginUser.userId) ? ' AND u.user_id = ' + loginUser.userId : ''} order by article_sort,create_time DESC`

    // 分页数据
    let page = handlePage(rows)
    if (page.length !== 0) sqlRow.value.push(...page), (sqlString += ' LIMIT ? OFFSET ? ')
    return {
        sqlString,
        value: sqlRow.value
    }
}


let insertBasePage = (rows = {}) => {
    let sqlarr = [
        {
            key: "articleId",
            sql: " article_id, ",
            isNull: true
        },
        {
            key: "userId",
            sql: " user_id, ",
            isNull: true
        },
        {
            key: "categoryId",
            sql: " category_id, ",
            isNull: true
        },
        {
            key: "articleSort",
            sql: " article_sort, "
        },
        {
            key: "title",
            sql: " title, "
        },
        {
            key: "tags",
            sql: " tags, "
        },
        {
            key: "description",
            sql: " description, "
        },
        {
            key: "coverImg",
            sql: " cover_img, "
        },
        {
            key: "status",
            sql: " status, ",
            isNull: true
        },
        {
            key: "viewsCount",
            sql: " views_count, ",
            isNull: true
        },
        {
            key: "remark",
            sql: " remark, "
        },
        {
            key: "createBy",
            sql: " create_by, "
        },
        {
            key: "createTime",
            sql: " create_time "
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    let sqlString = `insert into base_article(${sqlRow.sqlString}) values (${sqlRow.value.map(() => '?').join(',')})`

    return {
        sqlString,
        value: sqlRow.value
    }
}


let insertUpload = (rows = {}) => {
    let sqlarr = [
        {
            key: "imageId",
            sql: " image_id, ",
        },
        {
            key: "imageType",
            sql: " image_type, ",
        },
        {
            key: "articleId",
            sql: " article_id, ",
            isNull: true
        },
        {
            key: "imageSize",
            sql: " image_size, ",
            isNull: true
        },
        {
            key: "imageMimeType",
            sql: " image_mime_type, ",
        },
        {
            key: "imagePath",
            sql: " image_path, ",
        },
        {
            key: "createBy",
            sql: " create_by, ",
        },
        {
            key: "createTime",
            sql: " create_time ",
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    let sqlString = `insert into base_images(${sqlRow.sqlString}) values (${sqlRow.value.map(() => '?').join(',')})`

    return {
        sqlString,
        value: sqlRow.value
    }

}




let insertArticleData = "insert into base_article_data(article_id,mark_content) values (?,?)"


let selectBaseImage = "SELECT * FROM base_images i left join base_article a on i.article_id = a.article_id WHERE  i.article_id = ? AND a.user_id = ? "


let updateEditor = (rows = {}) => {
    let sqlarr = [
        {
            key: "userId",
            sql: " user_id = ?, ",
            isNull: true
        },
        {
            key: "categoryId",
            sql: " category_id = ?, ",
            isNull: true
        },
        {
            key: "articleSort",
            sql: " article_sort = ?, "
        },
        {
            key: "title",
            sql: " title = ?, "
        },
        {
            key: "tags",
            sql: " tags = ?, "
        },
        {
            key: "description",
            sql: " description = ?, "
        },
        {
            key: "coverImg",
            sql: " cover_img = ?, "
        },
        {
            key: "status",
            sql: " status = ?, ",
            isNull: true
        },
        {
            key: "viewsCount",
            sql: " views_count = ?, "
        },
        {
            key: "remark",
            sql: " remark = ?, "
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
            key: "articleId",
            sql: " where article_id = ? "
        }
    ]

    let sqlRow = sqlFunKey(rows, sqlarr)
    let sqlString = 'update base_article set ' + sqlRow.sqlString

    return {
        sqlString,
        value: sqlRow.value
    }
}


let updateBaseData = 'UPDATE base_article_data SET mark_content= ? WHERE article_id = ?'

let deleteImage = (rows = []) => {
    let sqlString = `delete from base_images where image_id in (${rows.map(() => '?').join(',')})`
    return {
        sqlString,
        value: rows
    }
}

let selectPageId = () => {
    return "SELECT cast(d.mark_content as char) as mark_content,u.title,u.tags,u.cover_img, cast(u.description as char) as description,u.article_id FROM base_article u left join base_article_data d on u.article_id = d.article_id WHERE u.article_id = ? AND u.user_id = ?"
}



let selectImages = "SELECT * FROM base_images WHERE article_id = ?"

let deleteEditorId = "delete from base_article where article_id = ? "

let deleteEditorDataId = "delete from base_article_data where article_id = ?"

let deleteEditorImageId = "delete from base_images where article_id = ?"

module.exports = {
    deleteEditorId,
    deleteEditorDataId,
    deleteEditorImageId,
    selectImages,
    selectPageId,
    deleteImage,
    updateBaseData,
    updateEditor,
    selectBaseImage,
    insertArticleData,
    insertUpload,
    insertBasePage,
    selectEditorList
}