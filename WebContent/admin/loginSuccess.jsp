<%@ page pageEncoding="GBK" %>
<%@ page import="tao.util.PageBean,java.util.*"%>   
<%@ include file="/header.jsp" %>

<body bgcolor="#d5e5ce">
<center>
<%
String name=request.getParameter("username");
%>
<table width="50%" algin="center"><tr><td></td><td algin="right">
��ӭ����<font color="green" ><%=name%></font>!!!</td>
<%
session.setAttribute("name",name);
 %>
<td>
<a href="<%=request.getContextPath()%>/admin/login.jsp">�˳�</a>
</td></tr>
</table><br><br>
<h2><a href="<%=request.getContextPath()%>/servlet/AdminServlet/manage">����������</a></h2>
<% response.setHeader("refresh","2;url=request.getContextPath()/servlet/AdminServlet/manage");%>
</center>
</body>