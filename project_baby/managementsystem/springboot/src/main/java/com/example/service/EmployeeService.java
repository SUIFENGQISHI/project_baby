package com.example.service;


import com.example.entity.Account;
import com.example.entity.Employee;
import com.example.exception.CustomException;
import com.example.mapper.EmployeeMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Resource
    private EmployeeMapper employeeMapper;

    public List<Employee> selectAll(Employee employee) {
        List<Employee> list =employeeMapper.selectAll(employee);
        return list;
    }

    public Employee selectById(Integer id) {
        Employee employee =employeeMapper.selectById(id);
        return employee;
    }

    public PageInfo<Employee> selectPage(Employee employee,Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Employee> list=employeeMapper.selectAll(employee);
        return PageInfo.of(list);

    }

    public void insert(Employee employee) {
        String username=employee.getUsername();
        Employee dbemployee=employeeMapper.selectByUsername(username);

        if(dbemployee!=null){
            throw new CustomException("用户已存在","500");
        }
        employee.setRole("EMP");
        if(employee.getPassword()==null){
            employee.setPassword("123456");
        }
        if(employee.getName()==null){
            employee.setName(employee.getUsername());
        }
        employeeMapper.insert(employee);
    }

    public void update(Employee employee) {
        employeeMapper.updateById(employee);
    }

    public void deleteById(Integer id) {
        employeeMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            employeeMapper.deleteById(id);
        }
    }

    public Employee login(Account account) {
        String username =account.getUsername();
        String password = account.getPassword();
        Employee dbemployee=employeeMapper.selectByUsername( username);
        if(dbemployee==null){
            throw new CustomException("用户不存在","500");
        }else{
            if(!dbemployee.getPassword().equals(password)){
                throw new CustomException("账号或密码错误","500");
            }
        }
        return dbemployee;
    }

    public void register(Employee employee) {
        this.insert(employee);
    }

    public void updatePassword(int id, String password) {
        employeeMapper.updatePassword(id,password);
    }
}
