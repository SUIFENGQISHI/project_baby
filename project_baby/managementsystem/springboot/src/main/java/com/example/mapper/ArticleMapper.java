package com.example.mapper;

import com.example.entity.Article;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import java.util.List;

public interface ArticleMapper {
    List<Article> selectAll(Article article);
    Article selectById(Integer id);
    void insert(Article article);
    void updateById(Article article);
    void deleteById(Integer id);

    @Update("update article set password = #{password} where id = #{id}")
    void updatePassword(int id, String password);

    @Select("select count(*) from article where time like concat('%',#{datetime},'%')")
    Long selectCountByDate(String datetime);
}