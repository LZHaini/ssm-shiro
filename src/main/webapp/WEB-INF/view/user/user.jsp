<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/view/common.jsp" %>
<html>
<head>
    <title>用户管理</title>

    <script type="text/javascript">
        $(function () {
            //初始化用户窗口
            initUserWin();
            //初始化用户编辑窗口
            if (hasPermission("user_query")) {
                queryUser();
            }

            initUserEditWin();
            //初始化用户分配窗口
            initUserDistributeWin();
        })

        function initUserWin() {
            $("#userWin").datagrid({
                fit: true,
                rownumbers: true,
                //单选
                singleSelect: true,
                autoRowHeight: false,
                //有分页
                pagination: true,
                pageSize: 2,
                pageList: [2, 10, 20, 30, 40],
                fitColumns: true,
                toolbar: "#usertb",
                columns: [[
                    {field: 'username', title: '用户名', width: 100},
                    {field: 'realname', title: '真实姓名', width: 100},
                    {field: 'phone', title: '电话', width: 100},
                    {field: 'email', title: '邮箱', width: 100},
                    {
                        field: 'status', title: '状态', width: 100,
                        formatter: function (value, row, index) {
                            if (value == "1") {
                                return "有效";
                            } else {
                                return "<span style='color:red'>无效</span>";
                            }
                        }
                    },
                    {
                        field: 'id', title: '操作', width: 100,
                        formatter: function (value, row, index) {
                            return "<a href='javascript:void(0)' onclick='showDistributeWin(" + value + ")'>分配角色</a>";
                            /* return "<a href='javascript:void(0)' onclick='showDistributeWin(" + value + ")'>分配角色</a>";*/
                        }
                    },
                ]],
                //onDblClickRow在用户双击一行的时候触发，参数包括：
                // index：点击的行的索引值，该索引值从0开始。
                // row：对应于点击行的记录。
                onDblClickRow: function (index, field, value) {
                    //console.log(row);
                    $("#userWin").datagrid("selectRow", index);
                    var row = $("#userWin").datagrid("getSelected");
                    //双击打开用户编辑窗口
                    $("#id").val(row.id);
                    $("#username").textbox("setValue", row.username);
                    $("#realname").textbox("setValue", row.realname);
                    $("#phone").textbox("setValue", row.phone);
                    $("#email").textbox("setValue", row.email);
                    $("#status").combobox("setValue", row.status);
                    openUserWditWin();
                }
            })
        }

        function showDistributeWin(userid) {
            /*if (!hasPermission("user_role")) {
                return;
            }*/

            if (!hasPermission("user_role")) {
                return;
            }
            $('#distributeWin').window("open");
            $("#userid").val(userid);
            initRoleDistributeGid(userid);
        }

        function initRoleDistributeGid(userid) {
            $("#distributeRoleTree").datagrid({
                fit: true,
                rownumbers: true,
                singleSelect: false,
                url: path + "/role/queryRoleByUserId?userid=" + userid,
                autoRowHeight: false,
                pagination: false,
                fitColumns: true,
                columns: [[
                    {field: 'id', title: '', checkbox: true},
                    {field: 'rolename', title: '角色名称', width: 100},
                    {field: 'rolecode', title: '角色编码', width: 100},
                    /*{field:'checked',title:'是够勾选',width:100}*/
                ]],
                onLoadSuccess: function (data) {
                    //onLoadSuccess 在数据加载成功的时候触发 属性data 。
                    // console.log(data);/**/
                    var rows = data.rows;
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        if (row.checked) {
                            $("#distributeRoleTree").datagrid("selectRow", i);
                            //selectRow 选择一行，index 行索引从0开始。
                        }
                    }
                }
            })
        }

        function closeDistributeWin() {
            $('#distributeWin').window("close");
        }

        function queryUser() {
            var username = $("#query_username").textbox("getValue");
            var realname = $("#query_realname").textbox("getValue");
            var phone = $("#query_phone").textbox("getValue");
            var email = $("#query_email").textbox("getValue");
            var status = $("#query_status").combobox("getValue");
            //console.log(username);
            // console.log(realname);
            // console.log(status);
            console.log("真好！");
            $("#userWin").datagrid("options").url = path + "/user/queryUser";
            $("#userWin").datagrid("options").queryParams = {
                //通过options方法返回返回属性对象。
                // 可以获取他的属性queryParams，url等等
                username: username,
                realname: realname,
                phone: phone,
                email: email,
                status: status,
            };
            //load 通过调用这个方法从服务器加载新数据。
            $("#userWin").datagrid("load");
        }

        function initUserEditWin() {
            $('#userEditWin').window({
                title: "用户编辑窗口",
                modal: true,
                closed: true,
                iconCls: 'icon-edit',
                width: 300,
                height: 300,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                footer: "#footer",
                onBeforeClose: function () {
                    $("#id").val("");
                    $("#username").textbox("setValue", "");
                    $("#realname").textbox("setValue", "");
                    $("#phone").textbox("setValue", "");
                    $("#email").textbox("setValue", "");
                    $("#status").combobox("setValue", "");
                }
            });
        }

        function openUserWditWin() {

            if (!hasPermission("user_edit")) {
                return;
            }

            $('#userEditWin').window("open");
        }

        function closeUserEditWin() {
            $('#userEditWin').window("close");
        }

        function submitUser() {
            var id = $("#id").val();
            var username = $("#username").textbox("getValue");
            var realname = $("#realname").textbox("getValue");
            var phone = $("#phone").textbox("getValue");
            var email = $("#email").textbox("getValue");
            var status = $("#status").combobox("getValue");

            if (username == "" || realname == "" || email == "" || phone == "") {
                $.messager.alert("提示", "所有内容均为必填项");
                return;
            }
            $.ajax({
                url: path + "/user/saveOrUpUser",
                type: "post",
                dataType: "json",
                data: {
                    id: id,
                    username: username,
                    realname: realname,
                    phone: phone,
                    email: email,
                    status: status,
                },
                success: function (result) {
                    if (result.success) {
                        $.messager.alert("提示", result.info, "不能为空", function () {
                            closeUserEditWin();
                            queryUser();
                        });
                    } else {
                        $.messager.alert("提示", result.info);
                    }
                }
            })
        }

        function initUserDistributeWin() {
            $('#distributeWin').window({
                title: "分配角色窗口",
                modal: true,
                closed: true,
                iconCls: 'icon-edit',
                width: 340,
                height: 300,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                footer: "#footer2",
                onBeforeClose: function () {
                    $("#userid").val("");
                }
            });
        }


        function submitDistribute() {
            if (!hasPermission("user_distribute")) {
                return;
            }
            //提交分配权限
            var userid = $("#userid").val();
            var checked = $("#distributeRoleTree").datagrid("getChecked");
            //getChecked 在复选框中选中的时候返回所有行。
            if (checked.length == 0) {
                $.messager.alert("提示", "请至少选择一个角色");
                return;
            }
            //console.log(checked);
            var roleids = [];
            for (var i = 0; i < checked.length; i++) {
                roleids.push(checked[i].id);
            }
            $.ajax({
                url: path + "/user/distribute",
                type: "post",
                dataType: "json",
                traditional: true,
                data: {
                    roleids: roleids,
                    userid: userid
                },
                success: function (result) {
                    if (result.success) {
                        $.messager.alert("提示", result.info, "", function () {
                            closeDistributeWin();
                        });
                    } else {
                        $.messager.alert("提示", result.info);
                    }
                }
            });
        }

    </script>
</head>
<body>
<table id="userWin"></table>
<div id="usertb" style="padding:2px 5px;">
    用户名: <input id="query_username" class="easyui-textbox" style="width:110px">
    真实姓名: <input id="query_realname" class="easyui-textbox" style="width:110px">
    电话: <input id="query_phone" class="easyui-textbox" style="width:110px">
    邮箱: <input id="query_email" class="easyui-textbox" style="width:110px">
    状态:
    <select id="query_status" class="easyui-combobox" data-options="editable:false" panelHeight="auto"
            style="width:100px">
        <option value="">全部</option>
        <option value="1">有效</option>
        <option value="2">无效</option>
    </select>
    <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryUser()">搜 索</a>
    <shiro:hasPermission name="user_edit">
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="openUserWditWin()">增 加</a>
    </shiro:hasPermission>
</div>

<div id="userEditWin" style="padding:5px;" align="center">
    <input type="hidden" id="id">
    <div style="margin-bottom:10px">
        <input class="easyui-textbox" id="username" label="用户名:" labelPosition="left" style="width:90%;">
    </div>
    <div style="margin-bottom:10px">
        <input class="easyui-textbox" id="realname" label="真实姓名:" labelPosition="left" style="width:90%;">
    </div>
    <div style="margin-bottom:10px">
        <div style="margin-bottom:10px">
            <input class="easyui-textbox" id="phone" label="电话号码:" labelPosition="left" style="width:90%;">
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-textbox" id="email" label="邮箱:" labelPosition="left" style="width:90%;">
        </div>
        <div style="margin-bottom:10px">
            <select class="easyui-combobox" id="status" label="状态:" data-options="panelHeight:'auto',editable:false"
                    labelPosition="left" style="width:90%;">
                <option value="1">有效</option>
                <option value="2">无效</option>
            </select>
        </div>
    </div>
    <div id="footer" style="padding:5px;" align="center">
        <a href="#" class="easyui-linkbutton" onclick="submitUser()" data-options="iconCls:'icon-ok'">提 交</a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="#" class="easyui-linkbutton" onclick="closeUserEditWin()" data-options="iconCls:'icon-cancel'">取 消</a>
    </div>
</div>

<div id="distributeWin">
    <input type="hidden" id="userid">
    <table id="distributeRoleTree"></table>
</div>
<div id="footer2" style="padding:5px;" align="center">
    <a href="#" class="easyui-linkbutton" onclick="submitDistribute()" data-options="iconCls:'icon-ok'">提 交</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="#" class="easyui-linkbutton" onclick="closeDistributeWin()" data-options="iconCls:'icon-cancel'">取 消</a>
</div>
</body>
</html>

