package com.ssm.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.crud.bean.Employee;
import com.ssm.crud.bean.Msg;
import com.ssm.crud.service.EmployeeService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Time: 2021/6/23
 * Author: Dankejun
 * Description: 和员工相关的操作
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {
            employeeService.deleteBatch(ids);
        } else {
            employeeService.deleteEmp(Integer.parseInt(ids));
        }

        return Msg.success();
    }

    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee emp = employeeService.getEmp(id);

        return Msg.success().add("emp", emp);
    }

    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam(value = "empName") String empName) {
        String regx = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u2E80-\\u9FFF]{2,8}$)";
        boolean isMatch = empName.matches(regx);
        if (!isMatch) {
            return Msg.fail().add("va_msg","用户名由4-16位字母数字组合或2-8位汉字");
        }
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名已经存在");
        }
    }

    /**
     * 新建员工信息
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        Map<String, Object> map = new HashMap<>();
        if (result.hasErrors()) {
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail();
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 分页查询员工数据
     *
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpWithJson(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum, Model model) {
        PageHelper.startPage(pageNum, 5);

        List<Employee> emps = employeeService.getAll();

        //连续显示5页
        PageInfo pageInfo = new PageInfo(emps,5);

        return Msg.success().add("pageInfo",pageInfo);
    }

    // @RequestMapping("/emps")
    public String getEmp(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum, Model model) {
        PageHelper.startPage(pageNum, 5);

        List<Employee> emps = employeeService.getAll();

        //连续显示5页
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo", pageInfo);

        return "list";
    }
}
