<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/view/common.jsp" %>
<html>
<head>
    <title> X X 管理员管理系统</title>
    <script type="text/javascript">

        $(function () {
            //窗体初始化防范，让他能够在页面记载完成之后，完成初始化工作，并隐藏
            initPwdChangeWin();
            //初始化功能菜单树形结构
            gnmk();
            //初始化子菜单窗口
            mainTab();
            zhuti();
            changecss('${path}/static/test/lan.css');
        });

        function logout() {
            $.messager.confirm('提示', '确定要退出系统吗？', function (r) {
                if (r) {
                    window.location.replace(path + "/user/logout");
                }
            });
        }

        function openPwdChangeWin() {
            $('#pwdChangeWin').window('open')
        }

        function initPwdChangeWin() {
            $('#pwdChangeWin').window({
                title: "密码修改窗口",
                modal: true,
                closed: true,
                iconCls: 'icon-edit',
                width: 400,
                height: 260,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                footer: "#footer",
                onBeforeClose: function () {
                    $("#oldpwd").passwordbox("setValue", "");
                    $("#newpwd").passwordbox("setValue", "");
                    $("#repwd").passwordbox("setValue", "");
                }
            });
        }


        function closePwdChangeWin() {
            //取消修改密码
            $('#pwdChangeWin').window('close');
        }

        function submitPwdChange() {
            var oldpwd = $("#oldpwd").passwordbox("getValue");
            var newpwd = $("#newpwd").passwordbox("getValue");
            var repwd = $("#repwd").passwordbox("getValue");
            if (oldpwd == "" || newpwd == "" || repwd == "") {
                $.messager.alert("提示", "所有的内容都为必填项");
                return;
            }
            if (repwd != newpwd) {
                $.messager.alert("提示", "两次密码输入不一致");
                return;
            }
            $.ajax({
                url: path + "/user/pwdChage",
                type: "post",
                dataType: "json",
                data: {
                    oldpwd: oldpwd,
                    newpwd: newpwd
                },
                success: function (result) {

                    if (result.success) {
                        $.messager.alert("提示", "修改成功！请立即重新登录", "", function () {
                            window.location.replace(path + "/user/logout");
                        });
                    } else {
                        $.messager.alert("提示", result.info);
                    }
                }
            })
        }

        function gnmk() {
            //功能模块树形结构
            $("#gn").tree({
                /*url:path+'/static/test/tree_data1.json',*/
                url: path + "/user/initMenu",
                method: 'get',
                animate: true,
                onClick: function (node) {
                    //console.log(node);
                    addPanel(node);
                }
            })
        }

        function mainTab() {
            //main是展示功能菜单子页面的独立窗口
            $('#tab').tabs('add', {
                title: "首页",
                content: "<iframe src='" + path + "/user/personal'" +
                " style='width:100%;height:100%' frameborder='0' scrolling='auto'></iframe>",
                closable: false,
                fit: true
                //fit 设置为true时，选项卡的大小将铺满它所在的容器。
            });
        }

        function addPanel(node) {
            //添加独立窗口的事件  在项目中实现点击子菜单显示(add)独立窗口，
            // 同时点击重复子菜单不会(exists)在出现只会展示当前点击(select)的子菜单页面
            var flag = $('#tab').tabs("exists", node.text);
            //exists 表明指定的面板是否存在，'which'参数可以是选项卡面板的标题或索引。比如node.text，node.url等等
            if (!flag) {
                if (node.url == "" || node.url == undefined) {
                } else {
                    $('#tab').tabs('add', {
                        //add 添加一个新选项卡面板，选项参数是一个配置对象，查看选项卡面板属性的更多细节。在添加一个新选项卡面板的时候它将变成可选的。
                        //添加一个非选中状态的选项卡面板时，记得设置'selected'属性为false。
                        title: node.text,
                        content: "<iframe src='" + path + node.url + "' style='width:100%;height:100%' frameborder='0' scrolling='auto'></iframe>",
                        closable: true,
                        fit: true
                    });
                }
            } else {
                $('#tab').tabs("select", node.text);
                //select 选择一个选项卡面板，'which'参数可以是选项卡面板的标题或者索引。
            }
        }

        function bj() {
            $('#Win').window('open')
        }

        function zhuti() {
            $('#Win').window({
                title: "修改背景色",

                iconCls: 'icon-edit',
                width: 160,
                height: 100,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false
            });
        }

        function changecss(url) {
            if (url != "") {
                skin.href = url;
                var expdate = new Date();
                expdate.setTime(expdate.getTime() + (24 * 60 * 60 * 1000 * 30));
            }
        }
    </script>

</head>
<body class="easyui-layout">
<div id="a1" data-options="region:'north',border:false"
     style="height:104px;padding:17px;
             ">
    <div style="float:left;font-size: 33px;"><strong>权限管理系统</strong></div>
    <div style="font-size: 20px;float:right;padding-top: 8px">
        <strong>
            <a class="b1" style="text-decoration: none" href="javascript:void(0)" onclick="openPwdChangeWin()">
                欢迎您${sessionScope.username}
            </a>&nbsp;&nbsp;&nbsp;&nbsp;
            <a class="b1" style="text-decoration: none" href="javascript:void(0)" onclick="logout()">退出登录</a>
        </strong><br>
        <div style="float: right;margin-top: 10px;margin-right: 30px;
   height: 20px;width: 21px;">
            <a style="text-decoration: none" href="javascript:void(0)" onclick="onclick=bj()">
                <img src="${path}/static/easyui/themes/icons/im.png" width="21px" height="20px">
            </a>
        </div>
        <div id="Win" class="easyui-window" title="My Window" closed="true"
             style="width:260px;height:100px;padding:5px;">
            <a href="javascript:void(0)" style="text-decoration: none"
               onclick="changecss('${path}/static/test/hui.css')">
                <img src="${path}/static/easyui/themes/icons/im.png" width="21px" height="20px">
                灰色
            </a>
            <a href="javascript:void(0)" style="text-decoration: none"
               onclick="changecss('${path}/static/test/hong.css')">
                <img src="${path}/static/easyui/themes/icons/im.png" width="21px" height="20px">
                粉色
            </a>
            <a href="javascript:void(0)" style="text-decoration: none"
               onclick="changecss('${path}/static/test/lan.css')">
                <img src="${path}/static/easyui/themes/icons/im.png" width="21px" height="20px">
                蓝色(默认)
            </a>
        </div>
    </div>
</div>
</div>
<div data-options="region:'west',split:true,title:'功能菜单'" style="width:200px;padding:10px;">
    <ul id="gn"></ul>
</div>
<div data-options="region:'center'">
    <div id="tab" class="easyui-tabs">

    </div>
    <div id="pwdChangeWin" style="width:100%;padding:10px 30px;">
        <div style="margin-bottom:10px">
            <input class="easyui-passwordbox" id="oldpwd" label="原始密码:" labelPosition="left" style="width:100%;">
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-passwordbox" id="newpwd" label="新密码:" labelPosition="left" style="width:100%;">
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-passwordbox" id="repwd" label="确认密码:" labelPosition="left" style="width:100%;">
        </div>
    </div>
    <div id="footer" style="padding:5px;" align="center">
        <a href="#" class="easyui-linkbutton" onclick="submitPwdChange()" data-options="iconCls:'icon-ok'">提 交</a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="#" class="easyui-linkbutton" onclick="closePwdChangeWin()" data-options="iconCls:'icon-cancel'">取 消</a>
    </div>
</div>

</body>
</html>
<%--<html>
<head>
    <title>Title</title>
    <script type="text/javascript">
        function logout(){
            window.location.replace("${path}/user/logout");
        }
    </script>
</head>
<body>
<h1>主工作界面，欢迎您${sessionScope.username}</h1>

<h3><a href="javascript:void(0)" onclick="logout()">退出登录</a></h3>
</body>
</html>--%>


<%--<body>
<h1>主工作界面，欢迎您${sessionScope.username}</h1>

<h3><a href="javascript:void(0)" onclick="logout()">退出登录</a></h3>
&lt;%&ndash;<table>
    <tr>
        <td>ID</td>
        <td>用户名</td>
        <td>电话号码</td>
        <td>邮箱</td>
    </tr>
    <c:forEach items="${user}" var="ur">
        <tr>
            <td >${ur.id}</td>
            <td >${ur.username}</td>
            <td >${ur.phone}</td>
            <td >${ur.email}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>--%>
