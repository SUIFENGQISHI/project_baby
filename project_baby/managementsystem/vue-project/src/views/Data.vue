<template>
  <div>
    <div style="display: flex; flex-wrap: wrap; gap: 10px">
      <div style="flex: 1; min-width: 600px; height: 400px" id="bar" class="card"></div>
      <div style="flex: 1; min-width: 600px; height: 400px" id="line" class="card"></div>
      <!-- 从此处换行，开始第二行 -->
      <div style="flex: 1; min-width: 600px; height: 400px" id="pie" class="card"></div>

    </div>
  </div>
</template>


<script setup>
import * as echarts from 'echarts';
import {onMounted} from "vue";
import request from "@/utils/request.js";


const barOption = {
  title: {
    text: '各部门员工数量'
  },
  legend: {
    data: ['人数']
  },
  tooltip: {},
  xAxis: {
    data: []
  },
  yAxis: {},
  series: [
    {
      name: '人数',
      type: 'bar',
      data: [],
      itemStyle: {
        color: (params) => {
          console.log(params);
          const colors = ['#5470c6', '#91cc75', '#fac858', '#ee6666', '#73c0de', '#3ba272', '#fc8452', '#9a60b4', '#ea7ccc'];
          return colors[params.dataIndex % colors.length];
        }
      }
    }
  ]
};
const lineOption = {
  title: {
    text: '近一周文章数量'
  },
  legend: {
    trigger:'item'
  },
  tooltip: {},
  xAxis: {
    data: []
  },
  yAxis: {},
  series: [
    {
      name: '数量',
      type: 'line',
      data: [],
      smooth: true,
    }
  ],
};

const pieOption = {
  title: {
    text: '各部门员工比例'
  },
  legend: {},
  tooltip: {
    trigger: 'item'
  },
  series: [
    {
      label:{
        formatter:'{b}: {c}人 ({d}%)',
      },
      type: 'pie',
      data: [],
    }
  ],
};

onMounted(() => {
  const barChart = echarts.init(document.getElementById('bar'));
  const lineChart = echarts.init(document.getElementById('line'));
  const pieChart = echarts.init(document.getElementById('pie'))
  request.get('/barData').then(res => {
    barOption.xAxis.data = res.data.departmentNameSet;
    barOption.series[0].data = res.data.departmentCount;
    barChart.setOption(barOption);
  })
  request.get('/lineData').then(res => {
    lineOption.xAxis.data = res.data.dateList;
    lineOption.series[0].data = res.data.dateCount;
    lineChart.setOption(lineOption);
  })
  request.get('/pieData').then(res => {
    pieOption.series[0].data = res.data;
    pieChart.setOption(pieOption)
  })
})

</script>
<style scoped>

</style>