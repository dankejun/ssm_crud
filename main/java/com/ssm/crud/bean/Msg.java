package com.ssm.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * Time: 2021/7/3
 * Author: Dankejun
 * Description: 通用返回数据
 */
public class Msg {

    private int code;//200成功  400失败
    private String msg;
    private Map<String, Object> extend = new HashMap<>();

    public static Msg success() {
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("操作成功！");
        return result;
    }
    public static Msg fail() {
        Msg result = new Msg();
        result.setCode(400);
        result.setMsg("操作失败！");
        return result;
    }

    public Msg add(String key, Object value) {
        this.getExtend().put(key, value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
