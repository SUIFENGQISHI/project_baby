import {createRouter, createWebHistory} from 'vue-router'


const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        {
            path: '/',
            redirect: '/login'
        },
        {
            path: '/manager',
            component: () => import("@/views/Manager.vue"),
            beforeEnter: (to, from, next) => {
                // 检查用户是否已登录
                const userStr = localStorage.getItem("usermsg");
                if (userStr) {
                    next();
                } else {
                    next('/login');
                }
            },
            children: [
                {
                    path: 'home',
                    name: 'home',
                    meta: {
                        title: '首页'
                    },
                    component: () => import("@/views/Home.vue"),
                },

                {
                    path: 'data',
                    name: 'data',
                    meta: {
                        title: '数据查询页面'
                    },
                    component: () => import("@/views/Data.vue"),
                },
                {
                    path: 'employee',
                    name: 'employee',
                    meta: {
                        title: '员工信息'
                    },
                    component: () => import("@/views/Employee.vue"),
                },
                {
                    path: 'admin',
                    name: 'admin',
                    meta: {
                        title: '管理员信息'
                    },
                    component: () => import("@/views/Admin.vue")
                }, {
                    path: 'person',
                    name: 'person',
                    meta: {
                        title: '个人信息'
                    },
                    component: () => import("@/views/Person.vue")
                },
                {
                    path: 'password',
                    name: 'password',
                    meta: {
                        title: '修改密码'
                    },
                    component: () => import("@/views/Password.vue")
                }, {
                    path: 'article',
                    name: 'article',
                    meta: {
                        title: '文章管理'
                    },
                    component: () => import("@/views/Article.vue")
                },
                {
                    path:'department',
                    name: 'department',
                    meta: {
                        title: '部门管理'
                    },
                    component: () => import("@/views/Department.vue")
                }

            ]
        },
        {
            path: '/login',
            name: 'login',
            meta: {
                title: '登录'
            },
            component: () => import("@/views/Login.vue"),
        },
        {
            path: '/register',
            name: 'register',
            meta: {
                title: '注册'
            },
            component: () => import("@/views/Register.vue")
        }


    ],
})


router.beforeEach((to, from, next) => {
    document.title = to.meta.title
    next()
})
export default router