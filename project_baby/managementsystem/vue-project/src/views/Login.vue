<template>
  <div class="login-container">
    <div class="login-box">
      <div style="font-size: 25px; margin-bottom: 20px; color: #6a0dad;">请登录账号</div>
      <el-form ref="formRef" size="large" :rules="data.rules" :model="data.form" style="width: 400px;">
        <el-form-item prop="username">
          <el-input v-model="data.form.username" placeholder="请输入账号" prefix-icon="User"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="data.form.password" placeholder="请输入账号密码" prefix-icon="Key" show-password></el-input>
        </el-form-item>
        <el-form-item prop="role">
          <el-select v-model="data.form.role" placeholder="请选择用户角色">
            <el-option label="管理员" value="ADMIN"></el-option>
            <el-option label="员工" value="EMP"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <el-button type="primary" @click="handleLogin" size="large" style="width: 120px; margin-top: 20px;">登录
      </el-button>
      <!-- 添加注册提示文字 -->
      <div class="register-link">
        还没有账号？请 <span @click="goToRegister">注册</span>
      </div>
    </div>
  </div>
</template>


<script setup>
import {reactive, ref} from "vue";
import {useRouter} from 'vue-router';
import request from "@/utils/request.js";
import {ElMessage} from "element-plus";

const data = reactive({
  form: {
    username: '',
    password: '',

  },
  rules: {
    username: [
      {required: true, message: '请输入用户名', trigger: 'blur'},
      {min: 3, message: '至少要3个字符', trigger: 'blur'}
    ],
    password: [
      {required: true, message: '请输入密码', trigger: 'blur'},
      {min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur'}
    ],
    role: [
      {required: true, message: '请选择用户角色', trigger: 'change'}
    ]
  }
})
const formRef = ref();

const router = useRouter();

const goToRegister = () => {
  // 跳转到注册页面的逻辑
  router.push('/register');
}

const handleLogin = () => {
  formRef.value.validate(valid => {
    if (valid) {
      request.post('/login', data.form).then(res => {
        if (res.code == 200) {
          ElMessage.success("登录成功")
          router.push('/manager/home');
          localStorage.setItem('usermsg', JSON.stringify(res.data))
        } else {
          ElMessage.error(res.msg)
        }
      })
    }

  })
}

</script>

<style scoped>
.login-container {
  background-image: url("@/assets/bag.jpg");
  background-size: cover;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: flex-end;
}

.login-box {
  background-color: rgba(248, 212, 255, 0.7);
  min-width: 500px;
  padding: 50px 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  height: auto;
  margin-right: 90px;
  box-shadow: 0 4px 8px rgba(20, 17, 23, 0.35);
  border-radius: 8px;
}

.register-link {
  margin-top: 10px;
  font-size: 14px;
  color: #000000; /* 黑色字体 */
  cursor: pointer;
  align-self: flex-end; /* 靠右对齐 */
}

.register-link span {
  color: #0000ff; /* 标准蓝色字体 */

}
</style>

