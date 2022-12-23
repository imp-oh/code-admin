<!-- 
    我的申报添加 OR 修改
 -->
<template>
    <div class="monthly-form-add">

        <h1 @click="ishide = !ishide" class="h1_title" title="点击显示历史数据"
            v-if="form.tableDataHistory && form.tableDataHistory.lenght == 0">变更前的数据</h1>
        <table class="c-table align-center" border="0" cellpadding="0" cellspacing="0" v-show="ishide">
            <thead class="has-gutter">
                <tr>
                    <th style="width:80px">姓名</th>
                    <th style="width:300px">{{ form.workerName }}</th>
                    <th style="width:80px">年月</th>
                    <th style="width:100px">{{ form.yearMonth }}</th>
                    <th style="width:100px">主管</th>
                    <th>{{ form.leader }}</th>
                    <th colspan="2" class="back">实际工作完成情况</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>序号</td>
                    <td>工作目标</td>
                    <td>工作量</td>
                    <td>开始时间</td>
                    <td>结束时间</td>
                    <td>备注</td>
                    <td class="back" style="width:100px">实际开始时间</td>
                    <td class="back" style="width:100px">实际结束时间</td>
                </tr>
                <tr v-for="(item, index) in form.tableDataHistory" :key="'history-' + index">
                    <td>{{ index + 1 }}</td>
                    <td>{{ item.target }}</td>
                    <td>{{ item.workload }}%</td>
                    <td>{{ item.beginTime }}</td>
                    <td>{{ item.endTime }}</td>
                    <td>{{ item.remark }}</td>
                    <td style="width:100px">{{ item.actualBeginTime }}</td>
                    <td style="width:100px">{{ item.actualEndTime }}</td>
                </tr>
            </tbody>
        </table>

        <h1>添加我的申报数据</h1>

        <div style="margin-bottom:15px" v-if="form.status != 0 && form.status != 5">
            <el-button size="small" type="primary" @click="handleAdd()">添加申报</el-button>
        </div>

        <el-form ref="form" :model="form" :rules="rules" size="small">
            <table class="c-table align-center" border="0" cellpadding="0" cellspacing="0">
                <thead class="has-gutter">
                    <tr>
                        <th style="width:80px">姓名</th>
                        <th style="width:240px">{{ form.nickName }}</th>
                        <th style="width:120px">年月</th>
                        <th style="width:160px">
                            <el-form-item prop="yearMonth" :rules="rules.yearMonth">
                                <el-date-picker v-model="form.yearMonth" type="month" placeholder="选择月"
                                    value-format="yyyy-MM-dd HH:mm:ss">
                                </el-date-picker>
                            </el-form-item>
                        </th>
                        <th style="width:160px">主管</th>
                        <th colspan="2">{{ form.leader }}</th>
                        <th colspan="4" class="back">实际工作完成情况</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>{{ form && (form.status == 4 || form.status == 1) ? '操作' : '序号' }} </td>
                        <td>工作目标</td>
                        <td>工作量(%)</td>
                        <td>开始时间</td>
                        <td>结束时间</td>
                        <td>任务清单</td>
                        <td>备注</td>
                        <td class="back" style="width:160px">实际开始时间</td>
                        <td class="back" style="width:160px">实际结束时间</td>
                        <td class="back">完成工作量(%)</td>
                        <td class="back">工作目标评价</td>
                    </tr>
                    <tr v-for="(item, index) in form.tableData" :key="'list-' + index">
                        <td>
                            <el-button type="text" @click="handleUpdateData(item)" v-if="form && form.status == 4 || form.status == 1">变更
                            </el-button>
                            <span v-else>{{ index + 1 }}</span>
                        </td>
                        <td>
                            <el-form-item :prop="`tableData.${index}.target`" :rules="rules.target" class="diy-column">
                                <el-input :disabled="!!item.columnId && form.status != 2" type="textarea"
                                    :autosize="{ minRows: 2, maxRows: 4 }" v-model="item.target" maxlength="200">
                                </el-input>
                            </el-form-item>
                        </td>
                        <td>
                            <el-form-item :prop="`tableData.${index}.workload`" :rules="rules.workload">
                                <el-input-number :disabled="!!item.columnId && form.status != 2" style="width:100%"
                                    v-model="item.workload" controls-position="right" :min="0" :max="100">
                                </el-input-number>
                            </el-form-item>
                        </td>
                        <td>
                            <el-form-item :prop="`tableData.${index}.beginTime`" :rules="rules.beginTime">
                                <el-date-picker :disabled="!!item.columnId && form.status != 2" style="width:100%"
                                    v-model="item.beginTime" type="date" placeholder="开始时间" value-format="yyyy-MM-dd">
                                </el-date-picker>
                            </el-form-item>
                        </td>
                        <td>
                            <el-form-item :prop="`tableData.${index}.endTime`" :rules="rules.endTime">
                                <el-date-picker :disabled="!!item.columnId && form.status != 2" style="width:100%"
                                    v-model="item.endTime" type="date" placeholder="结束时间" value-format="yyyy-MM-dd">
                                </el-date-picker>
                            </el-form-item>
                        </td>
                        <td>
                            <el-form-item :prop="`tableData.${index}.taskId`" :rules="rules.taskId">
                                <el-select :disabled="!!item.columnId && form.status != 2" v-model="item.taskId"
                                    clearable placeholder="选择任务清单" style="width:100%">
                                    <el-option v-for="item in taskOptions" :key="'taskOptions' + item.taskId"
                                        :label="item.taskName" :value="item.taskId"></el-option>
                                </el-select>
                            </el-form-item>
                        </td>
                        <td>
                            <el-form-item>
                                <el-input :disabled="!!item.columnId && form.status != 2" type="textarea"
                                    v-model="item.remark" :autosize="{ minRows: 2, maxRows: 4 }" maxlength="200">
                                </el-input>
                            </el-form-item>
                        </td>
                        <td style="width:130px">
                            <el-form-item v-if="form && form.status == 3 || form.status == 5"
                                :prop="`tableData.${index}.actualBeginTime`" :rules="rules.actualBeginTime">
                                <el-date-picker style="width:100%" :disabled="form.status == 5"
                                    v-model="item.actualBeginTime" type="date" placeholder="开始时间"
                                    value-format="yyyy-MM-dd"></el-date-picker>
                            </el-form-item>
                        </td>
                        <td style="width:130px">
                            <el-form-item v-if="form && form.status == 3 || form.status == 5"
                                :prop="`tableData.${index}.actualEndTime`" :rules="rules.actualEndTime">
                                <el-date-picker :disabled="form.status == 5" style="width:100%"
                                    v-model="item.actualEndTime" type="date" placeholder="结束时间"
                                    value-format="yyyy-MM-dd"></el-date-picker>
                            </el-form-item>
                        </td>
                        <td>
                            <el-form-item v-if="status == 2" :prop="`tableData.${index}.workDone`"
                                :rules="rules.workDone">
                                <el-input-number style="width:100%" v-model="item.workDone" controls-position="right"
                                    :min="0" :max="100" @blur="handleChange">
                                </el-input-number>
                            </el-form-item>
                        </td>
                        <td>
                            <el-input v-if="status == 2" type="textarea" v-model="item.jobRating"
                                :autosize="{ minRows: 2, maxRows: 4 }">
                            </el-input>
                        </td>
                    </tr>

                    <!-- 尾部 -->
                    <tr v-if="form.tableData && form.tableData.lenght != 0">
                        <td colspan="9"></td>
                        <td>{{ sum }}%</td>
                        <td></td>
                    </tr>
                </tbody>

            </table>
        </el-form>

        <div class="button_button">
            <template v-if="form.status != 5">
                <el-button type="primary" @click="submitForm(3)" v-if="form && form.status != 3">提交</el-button>
                <el-button type="primary" @click="submitFormFinish()" v-else>提交</el-button>
            </template>
            <el-button type="success" @click="submitForm(2)" v-if="form.status == 2">草稿</el-button>
            <el-button type="warning" @click="handleClose">关闭</el-button>
        </div>
    </div>
</template>

<script>
import { initInfo, addPost, updatePost, list, delPost, getPost, changeFormStatus, updateFinishPost, getTaskList } from "@/api/monthly/form";
import { taskAll } from '@/api/monthly/task'
import { formatDate, formatTimes } from '@/utils'
export default {
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
            form: {
                status: 2
            },
            taskOptions: [], // 任务清单
            rules: {
                workDone: [
                    { required: true, message: "完成工作量不能为空", trigger: "blur" },
                    { pattern: /(^(\d|[1-9]\d)?$)|(^100$)/, message: '请不要超过0-100', trigger: 'blur' },
                ],
                yearMonth: [{ required: true, message: '请填写年月', trigger: 'blur' }],
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
            },
            ishide: false,
            sum: 0,
            status: 0, // 状态控制 0添加
        }
    },
    mounted () {
        this.getList()
    },
    methods: {
        init (res = {}) {
            var date = new Date()
            var beginTime = new Date(date.getFullYear(), date.getMonth(), 1)
            var endTime = new Date(date.getFullYear(), date.getMonth() + 1, 0)
            res.data.tableData = [
                {
                    target: '',
                    workload: 0,
                    beginTime: formatDate(beginTime),
                    endTime: formatDate(endTime),
                    remark: ''
                }
            ]
            res.data.yearMonth = formatDate(beginTime)
            return res.data
        },
        // 添加一项数据
        handleAdd () {
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
        getList () {
            let { monthlyId } = this.$route.params

            let ajaxName = monthlyId ? getPost : initInfo
            ajaxName(monthlyId).then(res => {
                if (res.code !== 200) return
                if (!monthlyId) return this.form = this.init(res)
                this.form = res.data
            })
            // 任务清单
            taskAll().then(res => {
                this.taskOptions = res.data
            })
        },

        /** 计算工作量 */
        getSum () {
            let sum = 0
            this.form.tableData.forEach(item => {
                if (item.status != 1) sum += item.workload
            })
            return sum
        },

        handleClose () {
            const obj = { path: "/monthly/form" };
            this.$tab.closeOpenPage(obj);
        },

        /** 监听总进度 */
        handleChange () {
            let sum = 0
            this.form.tableData.forEach(item => {
                if (this.isNumber(item.workDone)) {
                    sum += ((Number(item.workDone) * Number(item.workload)) / 100)
                }
            })
            this.sum = sum
        },

        isNumber (val) {
            var regPos = /^[0-9]+.?[0-9]*/; //判断是否是数字。
            if (regPos.test(val)) {
                return true;
            } else {
                return false;
            }
        },


        /** 事件-变更 */
        handleUpdateData (row) {
            row.beforeId = row.columnId
            row.columnId = ''
        },

        /**
         * 完成度 提交
         */
        submitFormFinish () {
            this.$refs['form'].validate(valid => {
                if (valid && this.form.monthlyId != undefined) {
                    updateFinishPost(this.form).then(response => {
                        this.$modal.msgSuccess('完成度填写完毕')
                        // this.getList()
                        this.handleClose()
                    })
                }
            })
        },


        /** 提交按钮 */
        submitForm (status) {
            this.$refs['form'].validate(valid => {
                if (valid) {
                    let form = JSON.parse(JSON.stringify(this.form))
                    form.status = status
                    if (form.monthlyId != undefined) {
                        updatePost(form).then(response => {
                            this.$modal.msgSuccess('修改成功')
                            this.open = false
                            // this.getList()
                             this.handleClose()
                        })
                    } else {
                        addPost(form).then(response => {
                            this.$modal.msgSuccess('新增成功')
                            this.open = false
                            // this.getList()
                             this.handleClose()
                        })
                    }
                }
            })
        }



    }
}
</script>
<style>
.monthly-form-add .el-form-item--medium {
    margin-bottom: 0;
}
</style>

<style scoped lang="scss">
$border: 1px solid #e7e7e7;
$padding: 12px 10px;
$font-size: 14px;

.h1_title {
    color: #4fa98c;
    cursor: pointer;
}

.h1_title:hover {
    text-decoration: underline;
}

.monthly-form-add {
    padding: 20px;

    .button_button {
        margin-top: 20px;
        text-align: center;
    }

    .el-form-item .el-input {
        width: 100%;
    }
}

.back {
    background: #FBE4D5;
}

.c-table {
    width: 100%;
    table-layout: fixed;
    border-right: $border;
    border-collapse: collapse;
    border-spacing: 0;

    thead {
        th {
            border: $border;
            border-right: 0;
            font-size: $font-size;
            padding: $padding;
            color: #595959;
            text-align: left;
            text-overflow: ellipsis;
            white-space: normal;
            word-break: break-all;

            .level {
                border-bottom: $border;
                padding: 3px 0;
            }

            .long {
                display: block;
                overflow: hidden;

                span {
                    border-right: $border;
                    padding: 0 3px;
                    height: 30px;
                    line-height: 30px;
                    float: left;
                    box-sizing: border-box;
                }
            }
        }
    }

    tbody {
        tr {
            td {
                border: $border;
                border-right: 0;
                border-top: 0;
                font-size: $font-size;
                padding: $padding;
                text-align: left;
                color: #595959;
                text-overflow: ellipsis;
                white-space: normal;
                word-break: break-all;
            }
        }
    }

    /** 可以点击的链接 */
    .link {
        cursor: pointer;
        color: #1e87f0;
    }

    .padding-0 {
        padding: 0;
    }

    /** 去掉 input || textarea 边框 */
    .c-table-input,
    .c-table-select {

        input,
        textarea {
            border: 0;
        }

        .el-icon-arrow-up {
            display: none;
        }
    }
}


// 去除头padding 
.c-table.padding-0 thead th {
    padding: 0;
}


// text-align：配置
.c-table.align-center thead th,
.c-table.align-center tbody tr td {
    text-align: center;
}

.c-table.align-right thead th,
.c-table.align-right tbody tr td {
    text-align: right;
}
</style>