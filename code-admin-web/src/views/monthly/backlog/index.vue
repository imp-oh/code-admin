<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">

      <el-form-item label="申报人" prop="workerName">
        <el-input v-model="queryParams.workerName" placeholder="请输入申报人" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="年份" prop="tags">
        <el-date-picker v-model="queryParams.year" type="year" placeholder="选择年" clearable
          @keyup.enter.native="handleQuery">
        </el-date-picker>

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
          v-hasPermi="['monthly:form:add']">审核</el-button>
      </el-col>

      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="articleList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="文章ID" align="center" prop="monthlyId" />
      <el-table-column label="文章标题" align="center" prop="yearMonth">
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
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleReview(scope.row)"
            v-hasPermi="['monthly:backlog:review']">审核</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize"
      @pagination="getList" />



  </div>
</template>

<script>
import { formatDate } from '@/utils'
import { addPost, updatePost, list, delPost, getPost, changeBacklogStatus } from "@/api/monthly/backlog";
export default {
  name: "Article",
  dicts: ['monthly_common_status'],
  data () {

    const chackWorkload = (rule, value, callback) => {
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
      // 总条数
      total: 0,
      // 【请填写功能名称】表格数据
      articleList: [],
      // 弹出层标题
      title: "",
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
        viewsCount: null,
      },
      // 表单数据

      // 表单参数
      form: {},
      // 表单校验
      rules: {
        target: [
          { required: true, message: "工作目标不能为空", trigger: "blur" }
        ],
        beginTime: [
          { required: true, message: "开始时间不能为空", trigger: "blur" }
        ],
        endTime: [
          { required: true, message: "结束时间不能为空", trigger: "blur" }
        ],
        workload: [
          { pattern: /^\d+$/, message: '请输入数字', trigger: 'blur' },
          { validator: chackWorkload, trigger: 'blur' }
        ],

      }
    };
  },
  created () {
    this.getList();
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList () {
      this.loading = true;
      list(this.queryParams).then(response => {
        this.articleList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel () {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset () {
      var date = new Date();
      var beginTime = new Date(date.getFullYear(), date.getMonth(), 1);
      var endTime = new Date(date.getFullYear(), date.getMonth() + 1, 0);
      this.form = {
        yearMonth: formatDate(beginTime),
        tableData: [
          {
            target: "",
            workload: 0,
            beginTime: formatDate(beginTime),
            endTime: formatDate(endTime),
            remark: ""
          }
        ],
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery () {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery () {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange (selection) {
      this.ids = selection.map(item => item.monthlyId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },

    /** 审核按钮操作 */
    handleReview (row) {
      this.$router.push('/monthly/backlog-data/index/' + row.monthlyId)
    },
    /** 修改按钮操作 */
    handleUpdate (row) {
      this.reset();
      const monthlyId = row.monthlyId || this.ids
      getPost(monthlyId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改申报";
      });
    },

    /** 新增按钮操作 */
    handleAdd () {
      this.reset();
      this.open = true;
      this.title = "添加申报";
    },

    /** 提交按钮 */
    submitForm: function (status) {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.status = status
          if (this.form.monthlyId != undefined) {
            updatePost(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addPost(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },


    /** 删除按钮操作 */
    handleDelete (row) {
      const monthlyIds = row.monthlyId || this.ids;
      this.$modal.confirm('是否确认删除【请填写功能名称】编号为"' + monthlyIds + '"的数据项？').then(function () {
        return delPost(monthlyIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => { });
    },
    /** 导出按钮操作 */
    handleExport () {
      this.download('system/article/export', {
        ...this.queryParams
      }, `article_${new Date().getTime()}.xlsx`)
    },

    getSum () {
      let sum = 0;
      this.form.tableData.forEach(item => {
        sum += item.workload
      })
      return sum
    },

    /** 弹框-添加-表格row */
    handleAddTable () {
      var date = new Date();
      var beginTime = new Date(date.getFullYear(), date.getMonth(), 1);
      var endTime = new Date(date.getFullYear(), date.getMonth() + 1, 0);
      this.form.tableData.push({
        target: "",
        workload: 0,
        beginTime: formatDate(beginTime),
        endTime: formatDate(endTime),
        remark: ""
      })
    },
    /** 弹框删除 */
    handleDialogDelete (row, index) {
      this.form.tableData.splice(index, 1)
    },


    // 状态修改
    handleStatusChange (row, status) {
      this.$modal.confirm(`确认要撤回${row.yearMonth}工作任务表吗？`).then(function () {
        return changeBacklogStatus(row.monthlyId, status);
      }).then(() => {
        this.$modal.msgSuccess(text + "成功");

      }).catch(function () {
        row.status = status
        // row.status = row.status === "0" ? "1" : "0";
      });
    },

  }
};
</script>
<style>
.diy-dialog .diy-column {
  margin-bottom: 22px;
}
</style>