<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>Wopop</title>
    <link href="${path}/static/demo/css/style.css" rel="stylesheet" type="text/css">

</head>

<body class="login">

<div class="login_m">
    <div class="login_logo"><img src="${path}/static/demo/images/logo.png" width="196" height="46"></div>
    <div class="login_boder">
        <div class="login_padding">
            <h2>用户名</h2>
            <label>
                <input type="text" id="username" class="txt_input txt_input2" value="Your name">
            </label>
            <h2>密码</h2>
            <label>
                <input type="password" name="textfield2" id="userpwd" class="txt_input" value="******">
            </label>
            <p class="forgot"><a href="javascript:void(0);">忘记密码?</a></p>
            <div class="rem_sub">
                <div class="rem_sub_l">
                    <input type="checkbox" name="checkbox" id="save_me">
                    <label for="checkbox">记住</label>
                </div>
                <label>
                    <input type="submit" class="sub_button" name="button" id="button" value="登录" style="opacity: 0.7;">
                </label>
            </div>
        </div>
    </div><!--login_boder end-->
</div><!--login_m end-->

<br />
<br />

<p align="center"> More Templates <a href="#">源码之家</a></p>

</body>
</html>