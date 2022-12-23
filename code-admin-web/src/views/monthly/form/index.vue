<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="创建时间">
        <el-date-picker v-model="dateRange" style="width: 240px" value-format="yyyy-MM-dd" type="monthrange"
          range-separator="-" start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
      </el-form-item>

      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="状态" clearable style="width: 240px">
          <el-option v-for="dict in dict.type.monthly_common_status" :key="dict.value" :label="dict.label"
            :value="dict.value" />
        </el-select>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd"
          v-hasPermi="['monthly:form:add']">新增</el-button>
      </el-col>

      <el-col :span="1.5">
        <el-button type="info" plain icon="el-icon-upload2" size="mini" @click="handleImport"
          v-hasPermi="['monthly:form:import']">导入</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport"
          v-hasPermi="['monthly:form:export']">导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-view" size="mini" @click="handleViewTask">相关任务清单</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="articleList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="申报ID" align="center" prop="monthlyId" />
      <el-table-column label="申报标题" align="center" prop="yearMonth">
        <template slot-scope="scope">
          <div>{{ scope.row.yearMonth }} 工作任务表</div>
        </template>
      </el-table-column>
      <el-table-column label="申报人" align="center" prop="nickName" />
      <el-table-column prop="status" label="状态" width="100">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.monthly_common_status" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-search" @click="handleView(scope.row)">查看</el-button>
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)"
            v-hasPermi="['monthly:form:edit']" v-if="scope.row.status == 4 || scope.row.status == 2">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-edit" v-if="scope.row.status == 3 || scope.row.status == 5"
            @click="handleStatusChange(scope.row)" v-hasPermi="['monthly:form:edit']">
            {{ scope.row.isDay &&
                scope.row.status == 5 ? '撤回'
                : scope.row.isDay && scope.row.status == 3 ? '变更' : '撤回'
            }}
          </el-button>

          <!-- 失败后修改 -->
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)"
            v-hasPermi="['monthly:form:edit']" v-if="scope.row.status == 1">修改</el-button>

          <el-button size="mini" type="text" icon="el-icon-edit" v-if="scope.row.status == 3"
            @click="handleFinish(scope.row)" v-hasPermi="['monthly:form:edit']">完成度</el-button>

          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)"
            v-hasPermi="['monthly:form:remove']" v-if="scope.row.status == 2 && !scope.row.isDay">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize"
      @pagination="getList" />

    <!-- 添加或修改申报对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="80%" append-to-body :close-on-click-modal="false"
      :close-on-press-escape="false" class="diy-dialog">
      <el-form ref="form" :model="form" :rules="rules" label-width="0" size="small">
        <el-form-item label="填报月份" label-width="80px">
          <el-date-picker v-model="form.yearMonth" type="month" placeholder="选择月" value-format="yyyy-MM-dd HH:mm:ss">
          </el-date-picker>
          <el-button style="margin-left:15px" type="primary" plain icon="el-icon-plus" size="small"
            @click="handleAddTable">添加</el-button>
        </el-form-item>

        <el-table :data="form.tableData" stripe style="width: 100%" :row-class-name="tableRowClassName">
          <el-table-column label="序号" width="60">
            <template slot-scope="scope">
              <div class="diys" style="margin-bottom:22px">{{ scope.$index + 1 }}</div>
            </template>
          </el-table-column>
          <el-table-column prop="target" label="工作目标">
            <template slot-scope="scope">
              <el-form-item :prop="`tableData.${scope.$index}.target`" :rules="rules.target" class="diy-column">
                <el-input :disabled="scope.row.isDay" type="textarea" :autosize="{ minRows: 2, maxRows: 4 }"
                  v-model="scope.row.target" maxlength="200"></el-input>
              </el-form-item>
            </template>
          </el-table-column>
          <el-table-column prop="taskId" label="任务清单" width="160px">
            <template slot-scope="scope">
              <el-form-item :prop="`tableData.${scope.$index}.taskId`" :rules="rules.taskId">
                <el-select :disabled="scope.row.isDay" v-model="scope.row.taskId" clearable placeholder="请选择任务清单"
                  style="width:100%">
                  <el-option v-for="item in taskOptions" :key="'taskOptions' + item.taskId" :label="item.taskName"
                    :value="item.taskId"></el-option>
                </el-select>
              </el-form-item>
            </template>
          </el-table-column>

          <el-table-column prop="workload" label="工作量(%)" width="160px">
            <template slot-scope="scope">
              <el-form-item :prop="`tableData.${scope.$index}.workload`" :rules="rules.workload">
                <el-input-number :disabled="scope.row.isDay" style="width:100%" v-model="scope.row.workload"
                  controls-position="right" :min="0" :max="100"></el-input-number>
              </el-form-item>
            </template>
          </el-table-column>

          <el-table-column prop="beginTime" label="开始时间" width="160px">
            <template slot-scope="scope">
              <el-form-item :prop="`tableData.${scope.$index}.beginTime`" :rules="rules.beginTime">
                <el-date-picker :disabled="scope.row.isDay" style="width:100%" v-model="scope.row.beginTime" type="date"
                  placeholder="选择日期" value-format="yyyy-MM-dd"></el-date-picker>
              </el-form-item>
            </template>
          </el-table-column>
          <el-table-column prop="endTime" label="结束时间" width="160px">
            <template slot-scope="scope">
              <el-form-item :prop="`tableData.${scope.$index}.endTime`" :rules="rules.endTime">
                <el-date-picker :disabled="scope.row.isDay" style="width:100%" v-model="scope.row.endTime" type="date"
                  placeholder="选择日期" value-format="yyyy-MM-dd"></el-date-picker>
              </el-form-item>
            </template>
          </el-table-column>
          <el-table-column prop="remark" label="备注" width="200">
            <template slot-scope="scope">
              <el-form-item>
                <el-input :disabled="scope.row.isDay" type="textarea" autosize v-model="scope.row.remark"
                  maxlength="200"></el-input>
              </el-form-item>
            </template>
          </el-table-column>

          <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="80">
            <template slot-scope="scope">
              <el-form-item>
                <el-button size="mini" type="text" icon="el-icon-delete" v-if="!scope.row.isDay"
                  @click="handleDialogDelete(scope.row, scope.$index)">删除</el-button>
                <el-button size="mini" type="text" icon="el-icon-edit-outline" v-else
                  @click="handleDialogBefore(scope.row, scope.$index)">变更</el-button>
              </el-form-item>
            </template>
          </el-table-column>
        </el-table>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm('3')">提交</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 实际完成 -->
    <el-dialog :title="title" :visible.sync="openFinish" width="80%" append-to-body :close-on-click-modal="false"
      :close-on-press-escape="false">
      <el-form ref="formFinish" :model="formFinish" :rules="rules" label-width="0" size="small">
        <el-form-item label="填报月份" label-width="80px">
          <el-date-picker :disabled="true" v-model="formFinish.yearMonth" type="month" placeholder="选择月"
            value-format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
        </el-form-item>

        <el-table :data="formFinish.tableData" stripe style="width: 100%" :row-class-name="tableRowClassName">
          <el-table-column type="index" label="序号" width="60"></el-table-column>
          <el-table-column prop="target" label="工作目标"></el-table-column>
          <el-table-column prop="taskId" label="任务清单" width="160px">
            <template slot-scope="scope">
              <el-form-item :prop="`tableData.${scope.$index}.taskId`" :rules="rules.taskId">
                <el-select :disabled="scope.row.isDay" v-model="scope.row.taskId" clearable placeholder="请选择任务清单"
                  style="width:100%">
                  <el-option v-for="item in taskOptions" :key="'taskOptions' + item.taskId" :label="item.taskName"
                    :value="item.taskId"></el-option>
                </el-select>
              </el-form-item>
            </template>
          </el-table-column>

          <el-table-column prop="workload" label="工作量(%)" width="100px">
            <template slot-scope="scope">
              <div style="margin-bottom:20px">{{ scope.row.workload }}%</div>
            </template>
          </el-table-column>

          <el-table-column prop="beginTime" label="实际开始时间" width="160px">
            <template slot-scope="scope">
              <el-form-item :prop="`tableData.${scope.$index}.actualBeginTime`" :rules="rules.actualBeginTime">
                <el-date-picker style="width:100%" v-model="scope.row.actualBeginTime" type="date" placeholder="选择日期"
                  value-format="yyyy-MM-dd"></el-date-picker>
              </el-form-item>
            </template>
          </el-table-column>
          <el-table-column prop="endTime" label="实际结束时间" width="160px">
            <template slot-scope="scope">
              <el-form-item :prop="`tableData.${scope.$index}.actualEndTime`" :rules="rules.actualEndTime">
                <el-date-picker style="width:100%" v-model="scope.row.actualEndTime" type="date" placeholder="选择日期"
                  value-format="yyyy-MM-dd"></el-date-picker>
              </el-form-item>
            </template>
          </el-table-column>
        </el-table>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <!-- <el-button type="success" @click="submitForm('1')">草稿</el-button> -->
        <el-button type="primary" @click="submitFormFinish()">提交</el-button>
        <el-button @click="cancelFinish">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 用户导入对话框 -->
    <el-dialog :title="upload.title" :visible.sync="upload.open" width="400px" append-to-body>
      <el-upload ref="upload" :limit="1" accept=".xlsx, .xls" :headers="upload.headers"
        :action="upload.url + '?updateSupport=' + upload.updateSupport" :disabled="upload.isUploading"
        :on-progress="handleFileUploadProgress" :on-success="handleFileSuccess" :auto-upload="false" drag>
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">
          将文件拖到此处，或
          <em>点击上传</em>
        </div>
        <div class="el-upload__tip text-center" slot="tip">
          <div class="el-upload__tip" slot="tip">
            <el-checkbox v-model="upload.updateSupport" />是否更新已经存在的用户数据
          </div>
          <span>仅允许导入xls、xlsx格式文件。</span>
          <el-link type="primary" :underline="false" style="font-size:12px;vertical-align: baseline;"
            @click="importTemplate">下载模板</el-link>
        </div>
      </el-upload>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitFileForm">确 定</el-button>
        <el-button @click="upload.open = false">取 消</el-button>
      </div>
    </el-dialog>



    <!-- 相关任务查看 -->
    <!-- 实际完成 -->
    <el-dialog title="相关任务详情" :visible.sync="openView" width="80%" append-to-body :close-on-click-modal="false"
      :close-on-press-escape="false">
      <el-form label-width="0" size="small">
        <el-form-item label="填报月份" label-width="80px">
          <el-date-picker v-model="formView.yearMonth" type="month" placeholder="选择月" value-format="yyyy-MM"
            @change="hnadleChangeMonth">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="任务清单" label-width="80px">
          <el-select v-model="formView.taskId" clearable placeholder="请选择任务清单" @change="hnadleChangeTask">
            <el-option v-for="item in taskOptions" :key="'taskOptions' + item.taskId" :label="item.taskName"
              :value="item.taskId"></el-option>
          </el-select>
        </el-form-item>
      </el-form>

      <el-table :data="taskList" stripe style="width: 100%">
        <el-table-column type="index" label="序号" width="60"></el-table-column>
        <el-table-column prop="taskName" label="任务类型"></el-table-column>
        <el-table-column prop="target" label="工作目标"></el-table-column>
        <el-table-column prop="beginTime" label="开始时间"></el-table-column>
        <el-table-column prop="endTime" label="结束时间"></el-table-column>
        <el-table-column prop="nickName" label="申请人"></el-table-column>
      </el-table>

      <div slot="footer" class="dialog-footer">
        <el-button @click="openView = false">取 消</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { formatDate, formatTimes } from '@/utils'
import { addPost, updatePost, list, delPost, getPost, changeFormStatus, updateFinishPost, getTaskList } from '@/api/monthly/form'
import { taskAll } from '@/api/monthly/task'
import { getToken } from '@/utils/auth'

export default {
  name: 'Article',
  dicts: ['monthly_common_status'],
  data () {
    const chackWorkload = (rule, value, callback) => {
      if (!this.open) return callback()
      let sum = this.getSum()
      if (sum < 1) {
        callback(new Error('总工作量不能小于1%'))
      } else if (sum >= 101) {
        callback(new Error('总工作量不能大于100%'))
      } else {
        callback()
      }
    }

    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 日期范围
      dateRange: [],
      // 总条数
      total: 0,
      // 【请填写功能名称】表格数据
      articleList: [],
      // 任务清单
      taskOptions: [],
      // 弹出层标题
      title: '',
      // 是否显示弹出层
      open: false,

      // 用户导入参数
      upload: {
        // 是否显示弹出层（用户导入）
        open: false,
        // 弹出层标题（用户导入）
        title: '',
        // 是否禁用上传
        isUploading: false,
        // 是否更新已经存在的用户数据
        updateSupport: 0,
        // 设置上传的请求头部
        headers: { gitce: getToken() },
        // 上传的地址
        url: process.env.VUE_APP_BASE_API + '/monthly/form/importData'
      },

      // 相关任务弹框层
      openView: false,
      formView: {
        yearMonth: null,
        taskId: ""
      },
      taskList: [],

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

      // 是否显示弹出层
      openFinish: false,
      formFinish: {},

      // 表单参数
      form: {},
      // 表单校验
      rules: {
        target: [{ required: true, message: '工作目标不能为空', trigger: 'blur' }],
        beginTime: [{ required: true, message: '开始时间不能为空', trigger: 'blur' }],
        endTime: [{ required: true, message: '结束时间不能为空', trigger: 'blur' }],

        actualBeginTime: [{ required: true, message: '实际开始时间不能为空', trigger: 'blur' }],
        actualEndTime: [{ required: true, message: '实际结束时间不能为空', trigger: 'blur' }],
        taskId: [{ required: true, message: '任务清单不能为空', trigger: 'blur' }],
        workload: [
          { pattern: /^\d+$/, message: '请输入数字', trigger: 'blur' },
          { validator: chackWorkload, trigger: 'blur' }
        ]
      }
    }
  },
  created () {
    this.getList()
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList () {
      this.loading = true
      list(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.articleList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    getTaskList () {
      getTaskList(this.formView).then(res => {
        this.taskList = res.rows
      })
    },

    // 获取任务清单
    getTask () {
      taskAll().then(res => {
        this.taskOptions = res.data
      })
    },

    // 隐藏一行
    tableRowClassName ({ row, rowIndex }) {
      if (row.status == 1) {
        return 'is-delete' //可以动态添加class样式
      }
      return ''
    },

    // 取消按钮
    cancel () {
      this.open = false
      this.reset()
    },

    cancelFinish () {
      this.openFinish = false
      this.resetForm('formFinish')
    },

    // 表单重置
    reset () {
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
    handleQuery () {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery () {
      this.resetForm('queryForm')
      this.handleQuery()
      this.dateRange = []
    },
    // 多选框选中数据
    handleSelectionChange (selection) {
      this.ids = selection.map(item => item.monthlyId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },

    /** 审核按钮操作 */
    handleReview (row) { },
    /** 修改按钮操作 */
    handleUpdate (row) {
      this.$router.push(`/monthly/form-data/update/${row.monthlyId}`)
    },

    /** 新增按钮操作 */
    handleAdd () {
      // this.reset()
      // this.getTask()
      // this.open = true
      // this.title = '添加申报'
      this.$router.push('/monthly/form-data/add')
    },

    /** 提交按钮 */
    submitForm: function (status) {
      let isArr = this.form.tableData.filter(item => item.status != 1)
      if (isArr.length == 0) this.$modal.msgError('请填写申报')

      this.$refs['form'].validate(valid => {
        if (valid) {
          this.form.status = status
          if (this.form.monthlyId != undefined) {
            updatePost(this.form).then(response => {
              this.$modal.msgSuccess('修改成功')
              this.open = false
              this.getList()
            })
          } else {
            addPost(this.form).then(response => {
              this.$modal.msgSuccess('新增成功')
              this.open = false
              this.getList()
            })
          }
        }
      })
    },

    /** 删除按钮操作 */
    handleDelete (row) {
      const monthlyIds = row.monthlyId || this.ids
      this.$modal
        .confirm('是否确认删除【请填写功能名称】编号为"' + monthlyIds + '"的数据项？')
        .then(function () {
          return delPost(monthlyIds)
        })
        .then(() => {
          this.getList()
          this.$modal.msgSuccess('删除成功')
        })
        .catch(() => { })
    },
    /** 导出按钮操作 */
    handleExport () {
      this.download(
        'monthly/form/export',
        {
          ...this.addDateRange(this.queryParams, this.dateRange)
        },
        `月报申请-${new Date().getTime()}.xlsx`
      )
    },

    getSum () {
      let sum = 0
      this.form.tableData.forEach(item => {
        if (item.status != 1) sum += item.workload
      })
      return sum
    },

    /** 弹框-添加-表格row */
    handleAddTable () {
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
    handleDialogDelete (row, index) {
      if (!row.columnId) this.form.tableData.splice(index, 1)
      else row.status = 1
    },

    // 状态修改
    handleStatusChange (row) {
      this.$modal
        .confirm(`确认要撤回${row.yearMonth}工作任务表吗？`)
        .then(function () {
          return changeFormStatus(row.monthlyId, row.status)
        })
        .then(res => {
          this.$modal.msgSuccess('修改成功')
          row.status = res.data.status
        })
        .catch(function () {
          // row.status = status
          // row.status = row.status === "0" ? "1" : "0";
        })
    },

    handleDialogBefore (row, index) {
      if (row.columnId) {
        row.beforeId = row.columnId
        row.columnId = ''
        row.isDay = false
      }
    },

    /** 查看申报详情 */
    handleView (row) {
      this.$router.push('/monthly/form-data/index/' + row.monthlyId)
    },
    
    /** 完成度 - 事件 */
    handleFinish (row) {
      // this.getTask()
      // getPost(row.monthlyId).then(response => {
      //   this.formFinish.status = 5
      //   this.formFinish = response.data
      //   this.openFinish = true
      //   this.title = '实际工作完成度'
      // })
      this.$router.push(`/monthly/form-data/update/${row.monthlyId}`)
    },

    submitFormFinish () {
      this.$refs['formFinish'].validate(valid => {
        if (valid && this.formFinish.monthlyId != undefined) {
          console.log('吉纳省的')
          updateFinishPost(this.formFinish).then(response => {
            this.$modal.msgSuccess('完成度填写完毕')
            this.openFinish = false
            this.getList()
          })
        }
      })
    },


    /** 下载模板操作 */
    importTemplate () {
      this.download('system/user/importTemplate', {}, `user_template_${new Date().getTime()}.xlsx`)
    },

    /** 导入按钮操作 */
    handleImport () {
      this.upload.title = '用户导入'
      this.upload.open = true
    },

    // 文件上传中处理
    handleFileUploadProgress (event, file, fileList) {
      this.upload.isUploading = true
    },
    // 文件上传成功处理
    handleFileSuccess (response, file, fileList) {
      this.upload.open = false
      this.upload.isUploading = false
      this.$refs.upload.clearFiles()
      this.$alert(
        "<div style='overflow: auto;overflow-x: hidden;max-height: 70vh;padding: 10px 20px 0;'>" + response.msg + '</div>',
        '导入结果',
        { dangerouslyUseHTMLString: true }
      )
      this.getList()
    },
    // 提交上传文件
    submitFileForm () {
      this.$refs.upload.submit()
    },

    // 相关任务详情
    handleViewTask () {
      this.getTask()
      this.openView = true

      var date = new Date()
      var beginTime = new Date(date.getFullYear(), date.getMonth(), 1)
      this.formView.yearMonth = formatTimes(beginTime, 'yyyy-MM')

      this.getTaskList()
    },

    // 选择年月
    hnadleChangeMonth (value) {
      this.getTaskList()
    },
    // 选择任务类型
    hnadleChangeTask (value) {
      this.getTaskList()
    }
  }
}
</script>
<style>
.el-table .is-delete {
  display: none;
}

.diy-dialog .diy-column {
  margin-bottom: 22px;
}
</style>