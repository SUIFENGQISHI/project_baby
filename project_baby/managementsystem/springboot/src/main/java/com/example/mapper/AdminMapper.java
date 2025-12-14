package com.example.mapper;

import com.example.entity.Admin;
import org.apache.ibatis.annotations.Update;
import java.util.List;

public interface AdminMapper {
    List<Admin> selectAll(Admin admin);
    Admin selectById(Integer id);
    Admin selectByUsername(String username);
    void insert(Admin admin);
    void updateById(Admin admin);
    void deleteById(Integer id);

    @Update("update admin set password = #{password} where id = #{id}")
    void updatePassword(int id, String password);
}