<template>
  <div class="login-container">
    <div class="login-box">
      <div style="font-size: 25px; margin-bottom: 20px; color: #6a0dad;">请注册账号</div>
      <el-form ref="formRef" size="large" :model="data.form" style="width: 400px;" :rules="data.rules">
        <el-form-item prop="username">
          <el-input v-model="data.form.username" placeholder="请输入账号" prefix-icon="User"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="data.form.password" placeholder="请输入账号密码" prefix-icon="Key" show-password></el-input>
        </el-form-item>
        <el-form-item prop="confirmPassword">
          <el-input v-model="data.form.confirmPassword" placeholder="请再次确认密码" prefix-icon="Key" show-password></el-input>
        </el-form-item>
      </el-form>
      <el-button type="primary" @click="handleRegister" size="large" style="width: 120px; margin-top: 20px;">注册
      </el-button>

      <div class="register-link">
        已经有账号？请 <span @click="goToLogin">登录</span>
      </div>
    </div>
  </div>
</template>


<script setup>
import {reactive, ref} from "vue";
import {useRouter} from 'vue-router';
import {ElMessage} from "element-plus";
import request from "@/utils/request.js";

const validatePass = (rule, value, callback) => {
  if (!value) {
    callback(new Error('请确认密码'))
  }else if (value !== data.form.password) {
    callback(new Error("密码输入不匹配！"))
  } else {
    callback()
  }
}

const data = reactive({
  form: {},
  rules: {
    username: [
      {required: true, message: '请输入用户名', trigger: 'blur'},
      {min: 3, message: '至少要3个字符', trigger: 'blur'}
    ],
    password: [
      {required: true, message: '请输入密码', trigger: 'blur'},
      {min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur'}
    ],
    confirmPassword: [
      {required: true, message: '请确定密码', trigger: 'blur'},
      {min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur'},
      {validator: validatePass, message: '密码输入不匹配', trigger: 'blur'}
    ]
  },
})
const formRef = ref();

const router = useRouter();

const goToLogin = () => {
  // 跳转到注册页面的逻辑
  router.push('/login');
}
const handleRegister = () => {
  formRef.value.validate(valid=>{
    if(valid){
      request.post('/register', data.form).then(res => {
        if(res.code == 200){
          ElMessage.success("注册成功")
          router.push('/login');
        }else{
          ElMessage.error(res.msg)
        }
      })
    }else{
      ElMessage.error("账户或密码不合法");
    }
  })

}


</script>

<style scoped>
.login-container {
  background-image: url("@/assets/bag-register.jpg");
  background-size: cover;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: flex-start;
}

.login-box {
  background-color: rgba(248, 212, 255, 0.7);
  min-width: 500px;
  padding: 50px 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  height: auto;
  margin-left: 280px;
  box-shadow: 0 4px 8px rgba(20, 17, 23, 0.35);
  border-radius: 8px;
}

.register-link {
  margin-top: 10px;
  font-size: 14px;
  color: #000000;
  cursor: pointer;
  align-self: flex-end;
}

.register-link span {
  color: #0000ff;

}
</style>