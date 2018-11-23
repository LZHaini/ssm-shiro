<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title> X X 管理员管理系统</title>
    <script type="text/javascript" src="${path}/static/login/js/jquery-1.9.0.min.js"></script>
    <script type="text/javascript" src="${path}/static/login/js/login.js"></script>
    <link href="${path}/static/login/css/login2.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${path}/static/login/js/jquery.cookie.js"></script>

    <script type="text/javascript">
        $(function () {
            var username = $.cookie("username");
            var password = $.cookie("password");
            var remember = $.cookie("remember");
            //alert(username+"-----"+password+"----"+remember);
            if (remember != null) {
                $("#username").val(username);
                $("#password").val(password);
                $("#remember").attr("checked", "checked");
            }
        });

        function login() {
            var remember = $("#remember").is(":checked");
            var username = $("#username").val();
            var password = $("#password").val();
            if (username == "" || password == "") {
                alert("请填写用户名和密码");
                return;
            }
            $.ajax({
                url: "${path}/user/login",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    username: username,
                    password: password
                },
                success: function (result) {
                    console.log(result);
                    if (result.success) {
                        alert(result.info);
                        if (remember) {
                            $.cookie("username", username, {expires: 7});
                            $.cookie("password", password, {expires: 7});
                            $.cookie("remember", remember, {expires: 7});
                        } else {
                            $.cookie("username", null);
                            $.cookie("password", null);
                            $.cookie("remember", null);
                        }
                        window.location.href = "${path}/user/tomain";
                    } else {
                        alert(result.info);
                    }
                }
            });
        }
    </script>
</head>
<body>
<h1> X X 管理员管理系统<sup>2018</sup></h1>
<div class="login" style="margin-top:50px;">
    <div class="header">
        <div class="switch" id="switch">
            <a class="switch_btn_focus" id="switch_qlogin" href="javascript:void(0);" tabindex="7">快速登录</a>
            <div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 64px; left: 0px;"></div>
        </div>
    </div>

    <div class="web_qr_login" id="web_qr_login" style="display: block; height: 235px;">
        <!--登录-->
        <div class="web_login" id="web_login">
            <div class="login-box">
                <div class="login_form">
                    <form name="loginform" accept-charset="utf-8" id="login_form" class="loginForm">
                        <input type="hidden" name="did" value="0"/>
                        <input type="hidden" name="to" value="log"/>
                        <div class="uinArea" id="uinArea">
                            <label class="input-tips" for="username">帐号：</label>
                            <div class="inputOuter" id="uArea">
                                <input type="text" id="username" name="username" class="inputstyle"/>
                            </div>
                        </div>
                        <div class="pwdArea" id="pwdArea">
                            <label class="input-tips" for="password">密码：</label>
                            <div class="inputOuter" id="pArea">

                                <input type="password" id="password" name="password" class="inputstyle"/>
                            </div>
                        </div>
                        <input type="checkbox" name="remember" id="remember"/>记住密码
                        <div style="padding-left:50px;margin-top:20px;">
                            <input type="button" onclick="login()" value="登 录" style="width:150px;"
                                   class="button_blue"/></div>
                    </form>
                </div>
            </div>
        </div>
        <!--登录end-->
    </div>
</div>
<div class="jianyi">*推荐使用ie8或以上版本ie浏览器或Chrome内核浏览器访问本站</div>
</body>
</html>
