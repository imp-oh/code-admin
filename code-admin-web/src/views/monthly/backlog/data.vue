<template>
    <div class="backlog-data">

        <h1 @click="ishide = !ishide" class="h1_title" title="点击显示历史数据"
            v-if="form.tableDataHistory && form.tableDataHistory.lenght != 0">变更前的数据</h1>
        <table class="c-table align-center" border="0" cellpadding="0" cellspacing="0" v-show="ishide">
            <thead class="has-gutter">
                <tr>
                    <th style="width:80px">姓名</th>
                    <th style="width:300px">{{ form.nickName }}</th>
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

        <h1>申报数据</h1>

        <el-form ref="form" :model="form" :rules="rules">
            <table class="c-table align-center" border="0" cellpadding="0" cellspacing="0">
                <thead class="has-gutter">
                    <tr>
                        <th style="width:80px">姓名</th>
                        <th style="width:300px">{{ form.nickName }}</th>
                        <th style="width:80px">年月</th>
                        <th style="width:100px">{{ form.yearMonth }}</th>
                        <th style="width:100px">主管</th>
                        <th>{{ form.leader }}</th>
                        <th colspan="4" class="back">实际工作完成情况</th>
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
                        <td class="back">完成工作量(%)</td>
                        <td class="back">工作目标评价</td>
                    </tr>
                    <tr v-for="(item, index) in form.tableData" :key="'list-' + index">
                        <td>{{ index + 1 }}</td>
                        <td>{{ item.target }}</td>
                        <td>{{ item.workload }}%</td>
                        <td>{{ item.beginTime }}</td>
                        <td>{{ item.endTime }}</td>
                        <td>{{ item.remark }}</td>
                        <td style="width:100px">{{ item.actualBeginTime }}</td>
                        <td style="width:100px">{{ item.actualEndTime }}</td>
                        <td>
                            <el-form-item :prop="`tableData.${index}.workDone`" :rules="rules.workDone">
                                <el-input-number style="width:100%" v-model="item.workDone" controls-position="right"
                                    :min="0" :max="100" @blur="handleChange">
                                </el-input-number>
                            </el-form-item>
                        </td>
                        <td>
                            <el-input type="textarea" v-model="item.jobRating" :autosize="{ minRows: 2, maxRows: 4 }">
                            </el-input>
                        </td>
                    </tr>

                    <!-- 尾部 -->
                    <tr v-if="form.tableData && form.tableData.lenght != 0">
                        <td colspan="8"></td>
                        <td>{{ sum }}%</td>
                        <td></td>
                    </tr>
                </tbody>

            </table>
        </el-form>

        <div class="button_button">
            <el-button type="success" @click="submitForm(0)">通过</el-button>
            <el-button type="danger" @click="submitForm(1)">不通过</el-button>
            <el-button type="warning" @click="handleClose">关闭</el-button>
        </div>
    </div>
</template>

<script>
import { getPost, updatePost } from "@/api/monthly/backlog";
export default {
    data () {
        return {
            form: {},
            rules: {
                workDone: [
                    { required: true, message: "完成工作量不能为空", trigger: "blur" },
                    { pattern: /(^(\d|[1-9]\d)?$)|(^100$)/, message: '请不要超过0-100', trigger: 'blur' },
                ],
            },
            ishide: false,
            sum: 0
        }
    },
    mounted () {
        this.getList()
    },
    methods: {
        getList () {
            let { monthlyId } = this.$route.params
            getPost(monthlyId).then(response => {
                this.form = response.data;
            });
        },

        submitForm (status) {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    this.form.status = status
                    if (this.form.monthlyId != undefined) {
                        updatePost(this.form).then(response => {
                            this.$modal.msgSuccess("修改成功");
                            this.open = false;
                            this.handleClose()
                        });
                    }
                }
            });
        },

        handleClose () {
            const obj = { path: "/monthly/backlog" };
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
        }

    }
}
</script>
<style>
.backlog-data .el-form-item--medium {
    margin-bottom: 0;
}
</style>

<style scoped lang="scss">
$border: 1px solid #e7e7e7;
$padding: 12px 10px;
$font-size:14px;

.h1_title {
    color: #4fa98c;
    cursor: pointer;
}

.h1_title:hover {
    text-decoration: underline;
}

.backlog-data {
    padding: 20px;

    .button_button {
        margin-top: 20px;
        text-align: center;
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