<%--
  Created by IntelliJ IDEA.
  User: wuhanfeng
  Date: 2021/6/23
  Time: 3:19 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <% pageContext.setAttribute("APP_PATH",request.getContextPath()); %>
    <script src="${APP_PATH}/js/jquery-3.6.0.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <!-- 员工添加模态框 -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <%--添加表单--%>
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" name="email" id="email_add_input" placeholder="dankejun@qq.com ">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">department</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="dept_add_select"></select>
                            </div>
                        </div>


                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="save_emp_btn">添加</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 员工修改模态框 -->
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" >员工修改</h4>
                </div>
                <div class="modal-body">
                    <%--添加表单--%>
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_update_static" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_update_static"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_update_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" name="email" id="email_update_input" placeholder="dankejun@qq.com ">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">department</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="dept_update_select"></select>
                            </div>
                        </div>


                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="update_emp_btn">修改</button>
                </div>
            </div>
        </div>
    </div>

    <%--搭建显示页面--%>
    <div class="container">
    <%--标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all"/></th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <%--表格体--%>
                <tbody></tbody>

            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--分页条--%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>

    <script type="text/javascript">
        var maxPages, currentPage;
        /*1.页面加载完成后，发生Ajax请求，拿到分页数据*/
        $(function () {
            to_page(1);
        });

        function to_page(pageNum) {
            $.ajax({
                url: "${APP_PATH}/emps",
                data: "pageNum=" + pageNum,
                type: "get",
                success: function (result) {
                    // console.log(result);
                    //1.解析JSON显示员工数据
                    build_emp_tables(result);
                    //2.解析并显示分页信息
                    build_page_info(result)
                    //3.解析显示分页条数据
                    build_page_nav(result)
                }
            });
        }
        
        function build_emp_tables(result) {
            $("#emps_table tbody").empty();//清空上一次数据

            var emps = result.extend.pageInfo.list;
            $.each(emps, function (index, item) {
                var checkTd = $("<td><input type='checkbox' class='check_item'/></td>")
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);

                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                    .append("修改");
                //为编辑按钮添加用户Id
                editBtn.attr("edit-id", item.empId);
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                    .append("删除");
                //为删除按钮添加用户Id
                delBtn.attr("del-id", item.empId);
                var btn = $("<td></td>").append(editBtn).append(delBtn);


                $("<tr></tr>").append(checkTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btn)
                    .appendTo("#emps_table tbody")
            });

        }

        function build_page_info(result) {
            $("#page_info_area").empty();//清空上一次数据

            var pageNum = result.extend.pageInfo.pageNum;
            var pages = result.extend.pageInfo.pages;
            var total = result.extend.pageInfo.total;
            maxPages = pages;
            currentPage = pageNum;
            $("#page_info_area").append("当前" + pageNum + "页，共" + pages + "页，共" + total + "条记录");
        }

        // <nav aria-label="Page navigation">
        //     <ul class="pagination">
        //         <li>
        //             <a href="#" aria-label="Previous">
        //                 <span aria-hidden="true">&laquo;</span>
        //             </a>
        //         </li>
        //         <li><a href="#">1</a></li>
        //         <li><a href="#">2</a></li>
        //         <li><a href="#">3</a></li>
        //         <li><a href="#">4</a></li>
        //         <li><a href="#">5</a></li>
        //         <li>
        //             <a href="#" aria-label="Next">
        //                 <span aria-hidden="true">&raquo;</span>
        //             </a>
        //         </li>
        //     </ul>
        // </nav>
        function build_page_nav(result) {
            $("#page_nav_area").empty();//清空上一次数据

            var ul = $("<ul></ul>").addClass("pagination");

            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if (!result.extend.pageInfo.hasPreviousPage) {
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            } else {
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum - 1);
                });
            }

            var postPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if (!result.extend.pageInfo.hasNextPage) {
                postPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            } else {
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                });
                postPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum + 1);
                });
            }

            ul.append(firstPageLi).append(prePageLi);

            $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item));

                if (result.extend.pageInfo.pageNum == item) {
                    numLi.addClass("active")
                }

                numLi.click(function () {
                    to_page(item);
                });

                ul.append(numLi);
            });

            ul.append(postPageLi).append(lastPageLi);

            var nav = $("<nav></nav>").append(ul);
            nav.appendTo("#page_nav_area");
        }

        //清楚提示信息状态
        function reset_form(ele) {
            $(ele)[0].reset();
            $(ele).find("*").removeClass("has-success has-error");
            $(ele).find(".help-block").text("");
        }

        $("#emp_add_modal_btn").click(function () {
            reset_form("#empAddModal form")
            //获取部门信息并显示
            getDepts("#dept_add_select");
            //弹出模态框
            $("#empAddModal").modal({
                backdrop: "static"
            });
        });

        //获取部门信息
        function getDepts(ele) {
            $(ele).empty();//清空上一次数据
            $.ajax({
                url: "${APP_PATH}/depts",
                type: "GET",
                success: function (result) {
                    //{"code":200,"msg":"操作成功！","extend":{"depts":[{"deptId":1,"deptName":"技术部"},{"deptId":2,"deptName":"财务部"}]}}
                    $.each(result.extend.depts, function () {
                        var optionEl = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        optionEl.appendTo(ele);
                    });
                }
            });
        }
        //表单数据校验
        function validata_save_btn() {
            //校验用户名
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,8}$)/
            if (!regName.test(empName)) {
                // alert("用户名不合法");
                show_validata_msg("#empName_add_input","error","用户名由2-8位汉字或4-16位字母数字组合")
                return false;
            } else {
                show_validata_msg("#empName_add_input","success","")
            }

            //验证邮箱
            var email = $("#email_add_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)) {
                // alert("邮箱不合法");
                show_validata_msg("#email_add_input","error","邮箱不合法")
                return false;
            } else {
                show_validata_msg("#email_add_input","success","")
            }
            return true;
        }

        //显示校验信息
        function show_validata_msg(el,status,msg) {
            //清除之前状态
            $(el).parent().removeClass("has-success has-error");

            if ("success" == status) {
                $(el).parent().addClass("has-success");
                $(el).next("span").text(msg);
            } else if ("error" == status) {
                $(el).parent().addClass("has-error");
                $(el).next("span").text(msg);
            }

        }
        //Ajax检验用户名是否可用
        $("#empName_add_input").change(function () {
            var empName = this.value;
            $.ajax({
                url: "${APP_PATH}/checkuser",
                type: "POST",
                data: "empName=" + empName,
                success: function (result) {
                    if (result.code == 200) {
                        show_validata_msg("#empName_add_input", "success", "用户名可用");
                        $("#save_emp_btn").attr("ajax_vd", "success");
                    } else {
                        show_validata_msg("#empName_add_input", "error", result.extend.va_msg);
                        $("#save_emp_btn").attr("ajax_vd", "error");
                    }
                }
            });
        });

        //Ajax提交表单
        $("#save_emp_btn").click(function () {

            if (!validata_save_btn()) {
                return false;
            }
            if ($(this).attr("ajax_vd") == "error") {
                return false;
            }
            $.ajax({
                url: "${APP_PATH}/emp",
                type: "POST",
                data: $("#empAddModal form").serialize(),
                success: function (result) {
                    if (result.code == 200) {
                        // 保存后关闭模态框
                        $("#empAddModal").modal('hide');
                        to_page(maxPages + 1);
                    } else {
                        if (undefined != result.extend.errorFields.email) {
                            show_validata_msg("#email_add_input","error",result.extend.errorFields.email)
                        }
                        if (undefined != result.extend.errorFields.empName) {
                            show_validata_msg("#empName_add_input", "error", "result.extend.errorFields.empName");
                        }

                    }

                }
            });
        });

        //给修改按钮绑定单击事件
        $(document).on("click", ".edit_btn", function () {
            //获取员工信息
            getEmp($(this).attr("edit-id"));

            //把员工id传递给更新按钮
            $("#update_emp_btn").attr("edit-id", $(this).attr("edit-id"));

            //获取部门信息
            getDepts("#dept_update_select");

            //弹出修改模态框
            $("#empUpdateModal").modal({
                backdrop: "static"
            });
        });

        //查询员工信息
        function getEmp(id) {
            $.ajax({
                url: "${APP_PATH}/emp/" + id,
                type: "GET",
                success: function (result) {
                    var empData = result.extend.emp;
                    $("#empName_update_static").text(empData.empName)
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);
                }
            });
        }

        //更新员工信息
        $("#update_emp_btn").click(function () {
            //验证邮箱
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)) {
                // alert("邮箱不合法");
                show_validata_msg("#email_update_input","error","邮箱不合法")
                return false;
            } else {
                show_validata_msg("#email_update_input","success","")
            }

            //更新保存
            $.ajax({
                url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
                type: "PUT",
                data: $("#empUpdateModal form").serialize(),
                success: function () {
                    //关闭模态框
                    $("#empUpdateModal").modal('hide');

                    //回到本页面
                    to_page(currentPage);
                }
            });
        });

        //给删除绑定单击事件
        $(document).on("click", ".delete_btn", function () {
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            var empId = $(this).attr("del-id");
            if (confirm("确定要删除【" + empName +"】吗")) {
                $.ajax({
                    url: "${APP_PATH}/emp/" + empId,
                    type: "DELETE",
                    success: function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                    }
                });
            }
        });

        //全选 全不选
        $("#check_all").click(function () {
            $(".check_item").prop("checked", $(this).prop("checked"));
        });

        //check_item
        $(document).on("click", ".check_item", function () {
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked", flag);
        });

        //批量删除
        $("#emp_delete_all_btn").click(function () {
            var empNames = "";
            var del_ids = "";
            $.each($(".check_item:checked"), function () {
                empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
                del_ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
            });
            //去除末尾多余字符
            empNames = empNames.substring(0, empNames.length - 1);
            del_ids = del_ids.substring(0, del_ids.length - 1);
            if (confirm("确定要删除【" + empNames + "】吗")) {
                $.ajax({
                    url: "${APP_PATH}/emp/" + del_ids,
                    type: "DELETE",
                    success: function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                    }
                });
            }
        });

    </script>

</body>
</html>
