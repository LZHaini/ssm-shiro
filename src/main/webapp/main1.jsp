<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript">
        function logout() {
            window.location.replace("${path}/user/logout");
        }
    </script>
    <script type="text/css"/>
    <style>
        .userList {
            border-style: solid;
            border-width: 5px;
        }
    </style>
</head>
<body>
<h1>主工作界面，欢迎您${sessionScope.username}</h1>

<h3><a href="javascript:void(0)" onclick="logout()">退出登录</a></h3>
<table class="userList">
    <tr>
        <td>ID</td>
        <td>用户名</td>
        <td>电话号码</td>
        <td>邮箱</td>
    </tr>
    <c:forEach items="${us}" var="ur">
        <tr>
            <td>${ur.id}</td>
            <td>${ur.username}</td>
            <td>${ur.phone}</td>
            <td>${ur.email}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
