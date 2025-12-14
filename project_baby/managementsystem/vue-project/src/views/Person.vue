<template>
  <div class="card" style="width: 600px ;margin:100px 430px;padding-right: 80px;padding-top: 50px">
    <el-form :model="data.form" ref="formRef" :rules="data.rules" label-width="150px">
      <el-form-item style="margin-left: 80px">
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
      <el-form-item label="姓名" label-width="100px">
        <el-input v-model="data.form.name" placeholder="请输入姓名"/>
      </el-form-item>
      <el-form-item label="账号" prop="username" label-width="100px">
        <el-input v-model="data.form.username" placeholder="请输入员工账号" disabled/>
      </el-form-item>

      <div v-if="user.role==='EMP'">
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
        <el-form-item label="部门ID" label-width="100px">
          <el-input v-model="data.form.departmentId" placeholder="请输入部门ID"/>
        </el-form-item>
      </div>
      <el-form-item>
        <el-button size="large" type="primary" @click="submitUserInfo" style="margin-left:0; margin-right: 50px">
          更改个人信息
        </el-button>
        <el-button size="large" @click="reset">重置个人信息</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>


<script setup>

import {reactive, ref} from "vue";
import {ElMessage} from "element-plus";
import request from "@/utils/request.js";

const formRef = ref();
const userStr = localStorage.getItem("usermsg");
const user = userStr ? JSON.parse(userStr) : {};

const data = reactive({
  form: {
    id: user.id || '',
    name: user.name || '',
    password: user.password || '',
    role: user.role || '',
    username: user.username || '',
    sex: user.sex || '',
    no: user.no || '',
    age: user.age || '',
    description: user.description || '',
    departmentId: user.departmentId || '',
    avatar: user.avatar || '',  // 添加这一行
  },
  rules: {
    username: {
      required: true,
      message: '账号不能为空',
      trigger: 'blur',
    }
  }
})

const handleAvatarSuccess=(res)=>{
  console.log(res)
  data.form.avatar=res.data
}

const emit = defineEmits(['user-info-updated'])

const submitUserInfo = () => {
  formRef.value.validate((valid) => {
    if (valid) {
      // 先获取用户的最新信息，确保我们有完整的数据
      let getUserUrl = '/employee/selectById/' + user.id;
      if (user.role === 'ADMIN') {
        getUserUrl = '/admin/selectById/' + user.id;
      }
      request.get(getUserUrl).then(res => {
        if (res.code === '200') {
          // 将表单中的修改字段与数据库中的原有字段合并
          // 确保保留重要的password和role字段，避免被更新为null
          const formData = {
            ...res.data,           // 数据库中的完整用户信息
            ...data.form,          // 表单中修改过的字段
            password: res.data.password,  // 确保保留原始密码
            role: res.data.role           // 确保保留原始角色
          };
          
          let url = '/employee/update'
          if (user.role === 'ADMIN') {
            url = '/admin/update'
          }
          request.put(url, formData).then(updateRes => {
            if (updateRes.code === '200') {
              ElMessage.success('修改成功')
              // 更新localStorage中的用户信息
              const updatedUserInfo = {...res.data, ...data.form}
              localStorage.setItem("usermsg", JSON.stringify(updatedUserInfo))
              emit('user-info-updated', updatedUserInfo)
            } else {
              ElMessage.error(updateRes.msg)
            }
          })
        } else {
          ElMessage.error('获取用户信息失败')
        }
      })
    }
  })
}

const reset = () => {
  // 获取最新的用户信息来重置表单
  let getUserUrl = '/employee/selectById/' + user.id;
  if (user.role === 'ADMIN') {
    getUserUrl = '/admin/selectById/' + user.id;
  }
  
  request.get(getUserUrl).then(res => {
    if (res.code === '200') {
      const userData = res.data;
      data.form = {
        id: userData.id || '',
        name: userData.name || '',
        username: userData.username || '',
        sex: userData.sex || '',
        no: userData.no || '',
        age: userData.age || '',
        description: userData.description || '',
        departmentId: userData.departmentId || '',
        avatar: userData.avatar || '',  // 添加这一行
        // 注意：不包含password和role字段，因为它们不在表单中显示
      }
    } else {
      ElMessage.error('获取用户信息失败')
    }
  })
}
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
  width: 178px;
  height: 178px;
  text-align: center;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>