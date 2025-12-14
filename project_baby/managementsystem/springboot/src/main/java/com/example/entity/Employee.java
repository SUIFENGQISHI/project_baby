package com.example.entity;

/**
 * 员工实体类
 */
public class Employee extends Account {
    // 添加部门名称字段
    private String departmentName;
    
    public String getDepartmentName() {
        return departmentName;
    }
    
    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }
}