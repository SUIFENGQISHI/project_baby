<template>
  <div style="height: 60px ;background-color: #2f6dd3; display: flex; align-items: center;">
    <div style="margin-left: 20px; color: white; font-size: 20px; font-weight: bold;">
      <img src="">
      后台管理系统
    </div>
    <div style="flex: 1"></div>
    <div style="width: 150px;align-items: center;display: flex"><img
        :src="data.currentUser.avatar||'http://localhost:8080/files/download/1765158610475_Snipaste_2025-12-08_09-49-53.png'"
        width="40px" height="40px"
        style="border-radius: 50%"/>
      <span style="margin-left: 20px;color: #ebeef5">{{ data.currentUser.name }}</span>
    </div>

  </div>

  <div style="display: flex;  ">
    <div style="width:200px; min-height:calc(100vh - 60px)">
      <el-menu router
               default-active="router.currentRoute.value.path"
               :default-openeds="['1']"
               background-color="#e4d5d56b"
               text-color="#333"
               active-text-color="#ffffff"
               style="border:1px solid rgba(239,206,218,0.8); height: 100%">
        <el-menu-item index="/manager/home">
          <el-icon>
            <House/>
          </el-icon>
          系统首页
        </el-menu-item>
        <el-menu-item index="/manager/data">
          <el-icon>
            <DataAnalysis/>
          </el-icon>
          数据统计
        </el-menu-item>
        <el-menu-item index="/manager/department">
          <el-icon><OfficeBuilding /></el-icon>
          部门管理
        </el-menu-item>
        <el-menu-item index="/manager/article">
          <el-icon>
            <Reading/>
          </el-icon>
          文章管理
        </el-menu-item>
        <el-sub-menu index="1">
          <template #title>
            <el-icon>
              <User/>
            </el-icon>
            <span>用户管理</span>
          </template>
          <el-menu-item index="/manager/employee">员工信息</el-menu-item>
          <el-menu-item index="/manager/admin">管理员信息</el-menu-item>
        </el-sub-menu>
        <el-menu-item index="/manager/person">
          <el-icon>
            <UserFilled/>
          </el-icon>
          个人信息
        </el-menu-item>
        <el-menu-item index="/manager/password">
          <el-icon>
            <Lock/>
          </el-icon>
          修改密码
        </el-menu-item>
        <el-menu-item @click="handleLogout">
          <el-icon>
            <SwitchButton/>
          </el-icon>
          退出登录
        </el-menu-item>
      </el-menu>
    </div>
    <div style="padding: 10px; flex:1;background-color: rgba(205,239,222,0.23);  ">
      <router-view @user-info-updated="refreshUserInfo"></router-view>
    </div>
  </div>
</template>


<script setup>
import {Lock, User} from "@element-plus/icons-vue";
import {reactive} from "vue";
import router from "@/router/index.js";


const data = reactive({
  currentUser: JSON.parse(localStorage.getItem("usermsg") || "{}")
})

const refreshUserInfo = (newUserInfo) => {
  data.currentUser = newUserInfo;
}

const handleLogout = () => {
  router.push('/login')
  localStorage.removeItem("usermsg")
  data.currentUser = {}
}

</script>


<style>
.el-menu .el-menu-item.is-active {
  background-color: rgba(227, 102, 195, 0.42)
}


</style>