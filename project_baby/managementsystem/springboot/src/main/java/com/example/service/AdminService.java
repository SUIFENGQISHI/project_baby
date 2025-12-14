package com.example.service;


import com.example.entity.Account;
import com.example.entity.Admin;
import com.example.exception.CustomException;
import com.example.mapper.AdminMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    @Resource
    private AdminMapper adminMapper;

    public List<Admin> selectAll(Admin admin) {
        List<Admin> list =adminMapper.selectAll(admin);
        return list;
    }

    public Admin selectById(Integer id) {
        Admin admin =adminMapper.selectById(id);
        return admin;
    }

    public PageInfo<Admin> selectPage(Admin admin,Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Admin> list=adminMapper.selectAll(admin);
        return PageInfo.of(list);

    }

    public void insert(Admin admin) {
        String username=admin.getUsername();
        Admin dbadmin=adminMapper.selectByUsername(username);

        if(dbadmin!=null){
            throw new CustomException("用户已存在","500");
        }
        admin.setRole("ADMIN");
        if(admin.getPassword()==null){
            admin.setPassword("123456");
        }
        if(admin.getName()==null){
            admin.setName(admin.getUsername());
        }
        adminMapper.insert(admin);
    }

    public void update(Admin admin) {
        adminMapper.updateById(admin);
    }

    public void deleteById(Integer id) {
        adminMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            adminMapper.deleteById(id);
        }
    }

    public Admin login(Account account) {
        String username = account.getUsername();
        String password = account.getPassword();
        Admin dbadmin=adminMapper.selectByUsername( username);
        if(dbadmin==null){
            throw new CustomException("用户不存在","500");
        }else{
            if(!dbadmin.getPassword().equals(password)){
                throw new CustomException("账号或密码错误","500");
            }
        }
        return dbadmin;
    }

    public void register(Admin admin) {
        this.insert(admin);
    }

    public void updatePassword(int id, String password) {
        adminMapper.updatePassword(id,password);
    }
}