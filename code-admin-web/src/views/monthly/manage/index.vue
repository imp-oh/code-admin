<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="申报人" prop="nickName">
        <el-input v-model="queryParams.nickName" placeholder="请输入申报人" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="年份" prop="tags">
        <el-date-picker
          v-model="dateRange"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="monthrange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>

      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="状态" clearable style="width: 240px">
          <el-option v-for="dict in dict.type.monthly_common_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['monthly:manage:export']">导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="articleList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="角色ID" align="center" prop="userId" />
      <el-table-column label="申报人" align="center" prop="nickName" />
      <el-table-column label="申报人账号" align="center" prop="userName" />

      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-search">查看</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script>
import { formatDate } from '@/utils'
import { list, changeFormStatus } from '@/api/monthly/manage'
export default {
  name: 'Article',
  dicts: ['monthly_common_status'],
  data() {

    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 日期范围
      dateRange: [],
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 【请填写功能名称】表格数据
      articleList: [],
      // 弹出层标题
      title: '',
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        categoryId: null,
        articleSort: null,
        title: null,
        tags: null,
        description: null,
        coverImg: null,
        status: null,
        viewsCount: null
      },

      // 表单参数
      form: {},

    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true
      list(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.articleList = response.rows
        this.total = response.total
        this.loading = false
      })
    },

    // 表单重置
    reset() {
      var date = new Date()
      var beginTime = new Date(date.getFullYear(), date.getMonth(), 1)
      var endTime = new Date(date.getFullYear(), date.getMonth() + 1, 0)
      this.form = {
        yearMonth: formatDate(beginTime),
        tableData: [
          {
            target: '',
            workload: 0,
            beginTime: formatDate(beginTime),
            endTime: formatDate(endTime),
            remark: ''
          }
        ]
      }
      this.resetForm('form')
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm('queryForm')
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.monthlyId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },

    /** 导出按钮操作 */
    handleExport() {
      this.download(
        'monthly/manage/export',
        {
          ...this.addDateRange(this.queryParams, this.dateRange)
        },
        `月报-${new Date().getTime()}.zip`
      )
    },

    getSum() {
      let sum = 0
      this.form.tableData.forEach(item => {
        sum += item.workload
      })
      return sum
    },

    /** 弹框-添加-表格row */
    handleAddTable() {
      var date = new Date()
      var beginTime = new Date(date.getFullYear(), date.getMonth(), 1)
      var endTime = new Date(date.getFullYear(), date.getMonth() + 1, 0)
      this.form.tableData.push({
        target: '',
        workload: 0,
        beginTime: formatDate(beginTime),
        endTime: formatDate(endTime),
        remark: ''
      })
    },
    /** 弹框删除 */
    handleDialogDelete(row, index) {
      this.form.tableData.splice(index, 1)
    },

    // 状态修改
    handleStatusChange(row, status) {
      this.$modal
        .confirm(`确认要撤回${row.yearMonth}工作任务表吗？`)
        .then(function () {
          return changeFormStatus(row.monthlyId, status)
        })
        .then(() => {
          this.$modal.msgSuccess(text + '成功')
        })
        .catch(function () {
          row.status = status
          // row.status = row.status === "0" ? "1" : "0";
        })
    }
  }
}
</script>
<style>
.diy-dialog .diy-column {
  margin-bottom: 22px;
}
</style>