package com.example.controller;
import cn.hutool.core.date.DateField;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import com.example.common.Result;
import com.example.entity.Account;
import com.example.entity.Employee;
import com.example.service.AdminService;
import com.example.service.ArticleService;
import com.example.service.EmployeeService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@RestController
public class WebController {
    @Autowired
    private ArticleService articleService;

    @GetMapping("/hello")
    public Result hello() {
        return Result.success("hello world");
    }

    @GetMapping("barData")
    public Result barData(){
        Map<String,Collection<?>> map=new HashMap<>();
        List<Employee> departmentList=employeeService.selectAll(null);
        Set<String> departmentNameSet=departmentList.stream().map(Employee::getDepartmentName).collect(Collectors.toSet());
        List<Long> departmentCount=new ArrayList<>();
        for(String departmentName:departmentNameSet){
            long count=departmentList.stream().filter(employee->employee.getDepartmentName().equals(departmentName)).count();
            departmentCount.add(count);
        }
        map.put("departmentNameSet",departmentNameSet);
        map.put("departmentCount",departmentCount);
        return Result.success(map);
    }
    @GetMapping("lineData")
    public Result lineData(){
        Date date=new Date();
        System.out.println(date);
        DateTime start= DateUtil.offsetDay(date,-7);
        List<DateTime> dateTimeList=DateUtil.rangeToList(start,date, DateField.DAY_OF_YEAR);
        // 生成用于数据库查询的日期格式（保持不变）
        List<String> queryDateList=dateTimeList.stream().map(dateTime -> DateUtil.format(dateTime,"yyyy-MM-dd")).collect(Collectors.toList());
        // 生成用于前端显示的美化日期格式
        List<String> displayDateList=dateTimeList.stream().map(dateTime -> DateUtil.format(dateTime,"MM月dd日")).collect(Collectors.toList());
        Map<String,Collection<?>> map=new HashMap<>();
        List<Long> dateCount=new ArrayList<>();
        // 使用查询格式进行数据库查询
        for(String datetime:queryDateList){
            dateCount.add(articleService.selectCountByDate(datetime));
        }
        // 返回美化格式的日期列表用于前端显示
        map.put("dateList",displayDateList);
        map.put("dateCount",dateCount);
        return Result.success(map);
    }
    @GetMapping("pieData")
    public Result pieData(){
        List<Map<String,Object>> pieDataList=new ArrayList<>();
        List<Employee> departmentList=employeeService.selectAll(null);
        Set<String> departmentNameSet=departmentList.stream().map(Employee::getDepartmentName).collect(Collectors.toSet());
        for(String departmentName:departmentNameSet){
            long count=departmentList.stream().filter(employee->employee.getDepartmentName().equals(departmentName)).count();
            Map<String,Object> tempMap=new HashMap<>();
            tempMap.put("name",departmentName);
            tempMap.put("value",count);
            pieDataList.add(tempMap);
        }
        return Result.success(pieDataList);
    }
    @Resource
    private EmployeeService employeeService;
    @Resource
    private AdminService adminService;

    @PostMapping("/login")
    public Result login(@RequestBody Account account) {
        String role = account.getRole();
        Account dbaccount;
        if (role.equals("ADMIN")) {
            dbaccount = adminService.login(account);
        } else {
            dbaccount = employeeService.login(account);
        }
        return Result.success(dbaccount);
    }

    @PostMapping("/register")
    public Result register(@RequestBody Employee employee) {
        employeeService.register(employee);
        return Result.success();
    }

    @PutMapping("/updatePassword")
    public Result updatePassword(@RequestBody Account account) {
        String role = account.getRole();
        String password = account.getNewPassword();
        int id = account.getId();
        if (role.equals("ADMIN")) {
            adminService.updatePassword(id,password);
        }else{
            employeeService.updatePassword(id,password );
        }
        return Result.success();
    }
}
