package com.example.mapper;

import com.example.entity.Employee;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;


@Mapper
public interface EmployeeMapper {

    List<Employee> selectAll(Employee employee);

    Employee selectById(Integer id);

    void insert(Employee employee);

    void updateById(Employee employee);

    void deleteById(Integer id);

    @Select("select * from employee where username = #{username}")
    Employee selectByUsername(String username);
    @Update("update employee set password = #{password} where id = #{id}")
    void updatePassword(int id, String password);
}
