package com.example.controller;

import cn.hutool.poi.excel.*;
import com.example.common.Result;
import com.example.entity.Employee;
import com.example.service.EmployeeService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

@RestController
@RequestMapping("/employee")
public class EmployeeController {


    @Resource
    private EmployeeService employeeService;


    @PostMapping("/add")
    public Result add(@RequestBody Employee employee) {
        employeeService.insert(employee);
        return Result.success(employee);
    }
    @PostMapping("/import")
    public Result importExcel(MultipartFile file) throws IOException {
        InputStream inputStream=file.getInputStream();
        ExcelReader reader=ExcelUtil.getReader(inputStream);
        reader.addHeaderAlias("编号","id");
        reader.addHeaderAlias("用户名","username");
        reader.addHeaderAlias("姓名","name" );
        reader.addHeaderAlias("性别","sex");
        reader.addHeaderAlias("工号","no" );
        reader.addHeaderAlias("年龄","age" );
        reader.addHeaderAlias("描述","description" );
        reader.addHeaderAlias("部门ID","departmentId");
        reader.addHeaderAlias("角色","role" );
        List<Employee> list=reader.readAll(Employee.class);
        for(Employee employee: list){
            employeeService.insert(employee);
        }
        return Result.success(list);
    }

    @DeleteMapping("/deleteById/{id}")
    public Result deleteById(@PathVariable Integer id) {
        employeeService.deleteById(id);
        return Result.success();
    }

    @DeleteMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        employeeService.deleteBatch(ids);
        return Result.success();
    }


    @PutMapping("/update")
    public Result update(@RequestBody Employee employee) {
        employeeService.update(employee);
        return Result.success(employee);
    }

    @GetMapping("export")
    public void exportExcel(HttpServletResponse response) throws IOException {
        List<Employee> list = employeeService.selectAll(null);
        ExcelWriter writer = ExcelUtil.getWriter(true);
        writer.addHeaderAlias("id", "编号");
        writer.addHeaderAlias("username", "用户名");
        writer.addHeaderAlias("name", "姓名");
        writer.addHeaderAlias("sex", "性别");
        writer.addHeaderAlias("no", "工号");
        writer.addHeaderAlias("age", "年龄");
        writer.addHeaderAlias("description", "描述");
        writer.addHeaderAlias("departmentId", "部门ID");
        writer.addHeaderAlias("role", "角色");
        writer.setOnlyAlias( true);
        writer.write(list, true);
        //设置输出的文件名称，设置浏览器响应格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("员工信息", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");
        ServletOutputStream os = response.getOutputStream();
        writer.flush(os);
        writer.close();


    }

    @GetMapping("/selectAll")
    public Result selectAll(Employee employee) {
        List<Employee> list = employeeService.selectAll(employee);
        return Result.success(list);
    }

    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Employee employee = employeeService.selectById(id);
        return Result.success(employee);
    }
//    @GetMapping("/selectByPath")
//    public Result selectByPath(@RequestParam Integer id) {
//        Employee employee = employeeService.selectById(id);
//        return Result.success(employee);
//    }

    @GetMapping("selectPage")
    public Result selectPage(Employee employee,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Employee> pageInfo = employeeService.selectPage(employee, pageNum, pageSize);
        return Result.success(pageInfo);
    }
}
