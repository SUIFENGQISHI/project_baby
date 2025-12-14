package com.example.mapper;

import com.example.entity.Department;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;


@Mapper
public interface DepartmentMapper {

    List<Department> selectAll(Department department);

    Department selectById(Integer id);

    void insert(Department department);

    void updateById(Department department);

    void deleteById(Integer id);

    @Select("select * from department where name = #{name}")
    Department selectByName(String name);

}
