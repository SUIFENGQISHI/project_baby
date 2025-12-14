<template>
  <div class="card">
    <div>
      <el-input :prefix-icon="Search" placeholder="请输入内容" v-model="data.name" style="width:520px;"/>
      <el-button type="primary" style="margin-left: 10px" @click="load">搜索</el-button>
      <el-button type="warning" style="margin-left: 10px" @click="reset">重置</el-button>
    </div>
  </div>
  <div class="card">
    <el-button type="success" style="margin-left: 10px" @click="handleAdd">添加</el-button>
    <el-button type="danger" style="margin-left: 10px" @click="handleDeleteBatch">批量删除</el-button>
    <el-upload
        style="margin-left: 10px;display: inline-block"
        action="http://localhost:8080/employee/import"
        :show-file-list="false"
        :on-success="importSucess"
    >
      <el-button type="primary" style="margin-left: 10px">导入</el-button>
    </el-upload>
    <el-button type="info" style="margin-left: 10px" @click="exportData">导出</el-button>
  </div>
  <div class="card" style="">
    <el-table :data="data.tableData" style="width:100%;" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column label="头像" width="80">
        <template #default="scope">
          <img
              :src="scope.row.avatar||'http://localhost:8080/files/download/1765158610475_Snipaste_2025-12-08_09-49-53.png'"
              style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover;"
          />
        </template>
      </el-table-column>
      <el-table-column prop="name" label="姓名" width="180"/>
      <el-table-column prop="username" label="账号" width="180"/>
      <el-table-column prop="sex" label="性别" width="100"/>
      <el-table-column prop="no" label="工号" width="180"/>
      <el-table-column prop="age" label="年龄" width="180"/>
      <el-table-column prop="description" label="个人介绍" show-overflow-tooltip width="180"/>
      <!-- 将部门ID列替换为部门名称列 -->
      <el-table-column prop="departmentName" label="部门" width="180"/>
      <el-table-column label="操作" width="180">
        <template #default="scope">
          <el-button circle :icon="Edit" type="primary" @click="handleEdit(scope.row)"></el-button>
          <el-button circle :icon="Delete" type="danger" @click="handleDelete(scope.row.id)"></el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="demo-pagination-block">
      <el-pagination
          v-model:current-page="data.pageNum"
          v-model:page-size="data.pageSize"
          :page-sizes="[10, 20, 30, 40]"
          background
          layout="total, sizes, prev, pager, next, jumper"
          :total="data.total"
          @size-change="load"
          @current-change="load"
      />
    </div>
  </div>

  <el-dialog title="请输入新增的用户信息" v-model="data.formVisible" width="600px" des>
    <el-form :model="data.form" ref="formRef" :rules="data.rules" label-width="150px">
      <el-form-item label="姓名" label-width="100px">
        <el-input v-model="data.form.name" placeholder="请输入姓名"/>
      </el-form-item>
      <el-form-item label="头像" label-width="100px">
        <el-upload
            class="avatar-uploader"
            action="http://localhost:8080/files/upload"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
        >
          <img v-if="data.form.avatar" :src="data.form.avatar" class="avatar"/>
          <el-icon v-else class="avatar-uploader-icon">
            <Plus/>
          </el-icon>
        </el-upload>
      </el-form-item>
      <el-form-item label="账号" prop="username" label-width="100px">
        <el-input v-model="data.form.username" placeholder="请输入员工账号"/>
      </el-form-item>
      <el-form-item label="性别" label-width="100px">
        <el-select v-model="data.form.sex" placeholder="请选择性别">
          <el-option label="男" value="男"/>
          <el-option label="女" value="女"/>
        </el-select>
      </el-form-item>
      <el-form-item label="工号" label-width="100px">
        <el-input v-model="data.form.no" placeholder="请输入员工工号"/>
      </el-form-item>
      <el-form-item label="年龄" label-width="100px">
        <el-input-number v-model="data.form.age" style="width: 180px" placeholder="请输入年龄"/>
      </el-form-item>
      <el-form-item label="个人介绍" label-width="100px">
        <el-input type="textarea" v-model="data.form.description" placeholder="请输入个人介绍"/>
      </el-form-item>
      <el-form-item label="部门" label-width="100px">
        <el-select v-model="data.form.departmentId" placeholder="请选择部门">
          <el-option v-for="item in data.departmentList" :key="item.id" :label="item.name" :value="item.id"/>
        </el-select>
      </el-form-item>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="cancel">取消</el-button>
        <el-button type="primary"
                   @click="save">
          保存
        </el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import {Delete, Edit, Plus, Search} from "@element-plus/icons-vue";
import {reactive, ref} from "vue";
import request from "@/utils/request.js";
import {ElMessage, ElMessageBox} from "element-plus";


const data = reactive({
  form: {
    name: null,
    username: null,
    sex: null,
    no: null,
    age: null,
    description: null,
    departmentId: null
  },
  rules: {
    username: {
      required: true,
      message: '账号不能为空',
      trigger: 'blur',
    }
  },
  ids: [],
  name: null,
  employeeList: [],
  tableData: [],
  total: 0,
  pageNum: 1,
  pageSize: 10,
  formVisible: false,
  dialogVisible: false,
  departmentList: [],
})
const formRef = ref();

const exportData = () => {

  window.open('http://localhost:8080/employee/export')

}
const importSucess=(res)=>{
  if(res.code==='200'){
    ElMessage.success('导入成功')
    load()
  }else{
    ElMessage.error(res.msg||'导入失败')
  }
}
const handleAvatarSuccess = (res) => {
  console.log(res)
  data.form.avatar = res.data
}

request.get("/department/selectAll").then((res) => {
  data.departmentList = res.data;
})
const handleDeleteBatch = () => {
  if (data.ids.length === 0) {
    ElMessage.warning('请选择要删除的记录');
    return;
  }
  ElMessageBox.confirm(
      '删除的数据无法被恢复，是否确定删除？',
      '警告',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      }
  ).then(() => {
        request.delete("/employee/deleteBatch", {
          data: data.ids
        }).then(res => {
          if (res.code === '200') {
            ElMessage.success('删除成功');
            load();
          } else {
            ElMessage.error(res.msg || '删除失败');
          }
        })
      }
  ).catch(() => {
    ElMessage({
      type: 'info',
      message: '取消删除',
    })
  })

}

const handleSelectionChange = (rows) => {
  console.log(rows)
  data.ids = rows.map((row) => {row.id});
}

const handleAdd = () => {
  data.formVisible = true;
  // 初始化表单数据，确保没有 id 字段
  data.form = {
    id: null,
    name: null,
    username: null,
    sex: null,
    no: null,
    age: null,
    description: null,
    departmentId: null
  };
}
const cancel = () => {
  ElMessage({
    type: 'info',
    message: '取消',
  })
  data.formVisible = false;
}
const handleDelete = (id) => {
  ElMessageBox.confirm(
      '删除的数据无法被恢复，是否确定删除？',
      '警告',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      }
  )
      .then(() => {
        request.delete('/employee/deleteById/' + id).then(res => {
          if (res.code === '200') {
            ElMessage.success('删除成功');
            load();
          }
        }).catch(err => {
          console.error('请求出错:', err);
          ElMessage.error('网络异常，请稍后再试！');
        });
      })
      .catch(() => {
        ElMessage({
          type: 'info',
          message: '取消删除',
        })
      })
}

const handleEdit = (row) => {
  // 使用浅拷贝避免直接引用表格数据
  data.form = {...row};
  data.formVisible = true;
}

const add = () => {
  request.post('/employee/add', data.form).then(res => {
    if (res.code === '200') {
      data.formVisible = false;
      ElMessage.success('添加成功');
      load();
    } else {
      ElMessage.error(res.msg || '添加失败');
    }
  }).catch(err => {
    console.error('请求出错:', err);
    ElMessage.error('网络异常，请稍后再试！');
  });
};

const edit = () => {
  request.put('/employee/update', data.form).then(res => {
    if (res.code === '200') {
      data.formVisible = false;
      ElMessage.success('修改成功');
      load();
    } else {
      ElMessage.error(res.msg || '修改失败');
    }
  }).catch(err => {
    console.error('请求出错:', err);
    ElMessage.error('网络异常，请稍后再试！');
  });
};

const save = () => {
  console.log(formRef);
  formRef.value.validate(valid => {
    if (valid) {
      data.form.id ? edit() : add();
    }
  })

};

const reset = () => {
  data.name = null;
  load();
}

const load = () => {
  request.get('/employee/selectPage', {
    params: {
      name: data.name,
      pageNum: data.pageNum,
      pageSize: data.pageSize
    }
  }).then(res => {
    data.tableData = res.data.list;
    data.total = res.data.total;
  })
}


load();

</script>

<style scoped>
.avatar-uploader .avatar {
  width: 178px;
  height: 178px;
  display: block;
  border-radius: 50%;
  object-fit: cover;
}
</style>

<style>
.avatar-uploader .el-upload {
  border: 2px solid #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
  width: 178px;
  height: 178px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 50px;
  height: 50px;
  text-align: center;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
<style scoped>

</style>