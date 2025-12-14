<template>
  <div class="card">
    <div>
      <el-input :prefix-icon="Search" placeholder="请输入标题" v-model="data.title" style="width:520px;"/>
      <el-button type="primary" style="margin-left: 10px" @click="load">搜索</el-button>
      <el-button type="warning" style="margin-left: 10px" @click="reset">重置</el-button>
    </div>
  </div>
  <div class="card">
    <el-button type="success" style="margin-left: 10px" @click="handleAdd">添加</el-button>
    <el-button type="danger" style="margin-left: 10px" @click="handleDeleteBatch">批量删除</el-button>
  </div>
  <div class="card" style="">
    <el-table :data="data.tableData" style="width:100%;" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="100"/>
      <el-table-column label="封面" width="250">
        <template #default="scope">
          <el-image
              :src="scope.row.img||'http://localhost:8080/files/download/1765158610475_Snipaste_2025-12-08_09-49-53.png'"
              style="width: 100px; height: 100px; "
              fit="cover"
              :preview-teleported="true"
              :preview-src-list="[scope.row.img || 'http://localhost:8080/files/download/1765158610475_Snipaste_2025-12-08_09-49-53.png']"
          />
        </template>
      </el-table-column>
      <el-table-column prop="title" label="标题" width="250"/>
      <el-table-column prop="description" label="描述" width="250" show-overflow-tooltip />
      <el-table-column prop="time" label="发布时间" width="250"/>
      <el-table-column label="查看文章" width="250">
        <template #default="scope">
          <el-button type="primary" @click="handleViewContent(scope.row)">查看文章内容</el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="100">
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

  <el-dialog title="请输入新增的文章信息" v-model="data.formVisible" width="50%" des>
    <el-form :model="data.form"  label-width="150px">
      <el-form-item label="封面" label-width="100px">
        <el-upload
            class="avatar-uploader"
            action="http://localhost:8080/files/upload"
            :show-file-list="false"
            :on-success="handleImgSuccess"
        >
          <img v-if="data.form.img" :src="data.form.img" class="avatar"/>
          <el-icon v-else class="avatar-uploader-icon">
            <Plus/>
          </el-icon>
        </el-upload>
      </el-form-item>
      <el-form-item label="标题" label-width="100px">
        <el-input v-model="data.form.title" placeholder="请输入标题"/>
      </el-form-item>
      <el-form-item label="描述"  label-width="100px">
        <el-input v-model="data.form.description" placeholder="请输入文章简介"/>
      </el-form-item>
      <el-form-item label="文章内容" label-width="100px">
        <div style="border: 1px solid #ccc; width: 100%;" v-if="data.formVisible">
          <Toolbar
              style="border-bottom: 1px solid #ccc"
              :editor="editorRef"
              :defaultConfig="toolbarConfig"
              :mode="mode"
          />
          <Editor
              style="height: 400px; overflow-y: hidden;"
              v-model="data.form.content"
              :defaultConfig="editorConfig"
              :mode="mode"
              @onCreated="handleCreated"
          />
        </div>
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

  <el-dialog title="文章内容" v-model="data.contentVisible" width="800px">
    <div v-html="data.currentContent" style="padding: 20px;"></div>
    <template #footer>
      <el-button @click="data.contentVisible = false">关闭</el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import {Delete, Edit, Search} from "@element-plus/icons-vue";
import {reactive, ref, shallowRef, onBeforeUnmount} from "vue";
import request from "@/utils/request.js";
import {ElMessage, ElMessageBox} from "element-plus";
import '@wangeditor/editor/dist/css/style.css'
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'

const data = reactive({
  form: {
    title:null,
    description:null,
    img:null,
    content:null,
    time:null
  },
  ids: [],
  title: null,
  tableData: [],
  total: 0,
  pageNum: 1,
  pageSize: 10,
  formVisible: false,
  dialogVisible: false,
  contentVisible: false,
  currentContent: ''
})

const editorRef = shallowRef()
const mode = 'default'
const toolbarConfig = {}
const editorConfig = {
  placeholder: '请输入文章内容...',
  MENU_CONF: {
    uploadImage: {
      server: 'http://localhost:8080/files/upload',
      fieldName: 'file',
      maxFileSize: 10 * 1024 * 1024, // 10M
      allowedFileTypes: ['image/*'],
      meta: {},
      metaWithUrl: false,
      headers: {},
      withCredentials: false,
      timeout: 10 * 1000, // 10秒
      onBeforeUpload(file) {
        console.log('上传图片前', file)
        return file
      },
      onProgress(progress) {
        console.log('上传进度', progress)
      },
      onSuccess(file, res) {
        console.log('上传成功', file, res)
      },
      onFailed(file, res) {
        console.log('上传失败', file, res)
        ElMessage.error('图片上传失败')
      },
      onError(file, err, res) {
        console.log('上传出错', file, err, res)
        ElMessage.error('图片上传出错')
      },
      customInsert(res, insertFn) {
        // res 是服务器返回的结果
        // insertFn 是获取图片 url 后，插入到编辑器的方法
        console.log('customInsert', res)
        // 从 res 中获取图片的 url，然后插入编辑器
        const url = res.data || res.url
        if (url) {
          insertFn(url)
        } else {
          ElMessage.error('获取图片链接失败')
        }
      }
    }
  }
}
const formRef = ref()

// 富文本编辑器创建完成
const handleCreated = (editor) => {
  editorRef.value = editor
}

// 组件销毁时，也及时销毁编辑器
onBeforeUnmount(() => {
  const editor = editorRef.value
  if (editor == null) return
  editor.destroy()
})

// 查看文章内容
const handleViewContent = (row) => {
  data.currentContent = row.content || '暂无内容'
  data.contentVisible = true
}
const handleImgSuccess = (res) => {
  console.log(res)
  data.form.img = res.data
}
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
        request.delete("/article/deleteBatch", {
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
  data.ids = rows.map(row => row.id);
}

const handleAdd = () => {
  data.formVisible = true;
  // 初始化表单数据，确保没有 id 字段
  data.form = {
    id: null,
    description: null,
    title: null,
    img: null,
    content: null,
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
        request.delete('/article/deleteById/' + id).then(res => {
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
  request.post('/article/add', data.form).then(res => {
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
  request.put('/article/update', data.form).then(res => {
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
  data.form.id ? edit() : add();
};

const reset = () => {
  data.title = null;
  load();
}

const load = () => {
  request.get('/article/selectPage', {
    params: {
      title: data.title,
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