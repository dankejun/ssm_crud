package com.ssm.crud.controller;

import com.ssm.crud.bean.Department;
import com.ssm.crud.bean.Msg;
import com.ssm.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Time: 2021/7/4
 * Author: Dankejun
 * Description: 和部门相关的操作
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDeptWithJson() {
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts", depts);
    }
}
