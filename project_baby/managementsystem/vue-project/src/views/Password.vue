<template>
  <div class="card" style="width: 600px ;margin:100px 430px;padding-right: 80px;padding-top: 50px">
    <el-form ref="formRef" :rules="data.rules" :model="data.form" label-width="150px">
      <el-form-item label="原密码" label-width="100px" prop="password">
        <el-input placeholder="请输入原密码" v-model="data.form.password" show-password/>
      </el-form-item>
      <el-form-item label="新密码" label-width="100px" prop="newPassword">
        <el-input placeholder="请输入要修改为的密码" v-model="data.form.newPassword" show-password/>
      </el-form-item>
      <el-form-item label="确认密码" label-width="100px" prop="confirmPassword">
        <el-input placeholder="请确认新密码" v-model="data.form.confirmPassword" show-password/>
      </el-form-item>
      <el-form-item>
        <el-button size="large" type="primary" @click="updatePassword" style="margin-left:0; margin-right: 50px">
          确定修改
        </el-button>
        <el-button size="large">取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>


<script setup>
import {reactive, ref} from "vue";
import request from "@/utils/request.js";
import {ElMessage} from "element-plus";
import router from "@/router/index.js";
const formRef = ref();
const userStr = localStorage.getItem("usermsg");
const user = userStr ? JSON.parse(userStr) : {};
const validatePass = (rule, value, callback) => {
  if (!value) {
    callback(new Error('请输入原密码'))
  }else if (value !== user.password) {
    callback(new Error("原密码输入错误！"))
  } else {
    callback()
  }
}
const validateConfirmPass = (rule, value, callback) => {
  if (!value) {
    callback(new Error('请确认新密码'))
  }else if (value !== data.form.newPassword) {
    callback(new Error("两次密码不相同，请重新输入！"))
  } else {
    callback()
  }
}
const data = reactive({
  form: {
    password:'',
    newPassword: '',
    confirmPassword: ''
  },
  rules: {
    password: [
        {required: true, message: '请输入原密码', trigger: 'blur'},
        {validator: validatePass, message: '原密码错误', trigger: 'blur'}
    ],
    newPassword: [
      {required: true, message: '请输入新密码', trigger: 'blur'},
    ],
    confirmPassword: [
      {required: true, message: '请确认密码', trigger: 'blur'},
      {validator: validateConfirmPass, message: '密码输入不匹配', trigger: 'blur'}
    ]
  },

})

const updatePassword = () => {
  formRef.value.validate(valid=>{
    if(valid){
      request.put('/updatePassword', {
        id: user.id,
        role: user.role,
        newPassword: data.form.newPassword
      }).then(res => {
        if(res.code == 200){
          ElMessage.success("修改密码成功")
          localStorage.removeItem("usermsg");
          router.push('/login');
        }else{
          ElMessage.error(res.msg)
        }
      })
    }
  })
}

</script>


<style scoped>

</style>