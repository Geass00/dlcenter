<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/header.jsp" %>
<body bgcolor="#d5e5ce">
<div align="center">
  <script>
  function check(){
    var adminName=document.f.username.value;
    var password=document.f.password.value;
    if(adminName==""){
       alert("用户名不能为空");
       return false;
    }else if(password==""){
       alert("密码不能为空");
       return false;
    }else{
       return true;
    }
  }
  </script>
  <%
  String url = request.getContextPath()+ "/servlet/AdminServlet";
   %>
   <div width=380px;">
<center>
<div style="font-size:28px;font-family:'隶书';">
管理员用户登录</div><br>
<form method="post" action="<%=url%>/login" name="f" onSubmit="return check()">
<table>
<tr><td align="center">用户名：<td><input type="text" name="username" size="19"><td>
<tr><td align="center"> 密     码：<td><input type="password" name="password" size="21">
</table>
<input type="submit" value="登录">
<input type="reset" value="重置">
</form>
</div>
</div>>