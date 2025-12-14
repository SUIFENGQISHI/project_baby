package com.example.common;

import com.example.exception.CustomException;

public class Result {
    private String msg;
    private String code;
    private Object data;

    public  static Result success() {
        Result result = new Result();
        result.setCode("200");
        result.setMsg("请求成功");
        return result;
    }

    public  static Result success(Object data) {
        Result result = success();
        result.setData(data);
        return result;
    }

    public static Result error(){
        Result result = new Result();
        result.setCode("500");
        result.setMsg("请求失败");
        return result;
    }
    public static Result error(Exception e){
        Result result = error();
        result.setMsg(e.getMessage());
        return result;
    }

    public static Result error(CustomException e){
        Result result = new Result();
        result.setMsg(e.getMessage());
        result.setCode(e.getCode());
        return result;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
