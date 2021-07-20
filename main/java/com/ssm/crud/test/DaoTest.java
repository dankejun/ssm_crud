package com.ssm.crud.test;


import com.ssm.crud.bean.Department;
import com.ssm.crud.bean.Employee;
import com.ssm.crud.dao.DepartmentMapper;
import com.ssm.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//
import java.util.UUID;

/**
 * Time: 2021/6/23
 * Author: Dankejun
 * Description: Dao层测试
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class DaoTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD() {
        System.out.println(departmentMapper);

        //插入部门
        // departmentMapper.insertSelective(new Department(null, "技术部"));
        // departmentMapper.insertSelective(new Department(null, "财务部"));

        //插入员工
        // employeeMapper.insertSelective(new Employee(null,"Jack","1","jack@qq.com",1));

        //批量插入多个员工：使用批量sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, "M", uid + "@qq.com", 1));
        }
        System.out.println("批量完成");
    }
}
