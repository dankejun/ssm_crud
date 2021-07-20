package com.ssm.crud.service;

import com.ssm.crud.bean.Department;
import com.ssm.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Time: 2021/7/4
 * Author: Dankejun
 * Description:
 */
@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    /**
     * 查询部门信息
     * @return
     */
    public List<Department> getDepts() {
        List<Department> depts = departmentMapper.selectByExample(null);
        return depts;
    }
}
