package com.ssm.crud.service;

import com.ssm.crud.bean.Employee;
import com.ssm.crud.bean.EmployeeExample;
import com.ssm.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Time: 2021/6/23
 * Author: Dankejun
 * Description:
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 验证用户名是否可用
     * @param empName
     * @return 返回TRUE表示可用，否则不可用
     */
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(String ids) {
        List<Integer> delIds = new ArrayList<>();
        String[] strings = ids.split("-");
        for (String s : strings) {
            delIds.add(Integer.parseInt(s));
        }
        EmployeeExample example =new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(delIds);
        employeeMapper.deleteByExample(example);
    }
}
