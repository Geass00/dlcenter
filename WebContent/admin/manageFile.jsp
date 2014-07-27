<%@ page pageEncoding="GBK" %>
<%@ page import="tao.util.PageBean,java.util.*"%>
<%@ include file="/header.jsp" %>

<body bgcolor="#d5e5ce">
<center>
<h2>文件管理中心</h2>
<center>
<table width="650px"><tr><td > 
<font color="#808000">欢迎您：<%=session.getAttribute("name")%>!!!</font></td>
<td>
<font color="#ff8000"><em><a href="<%=request.getContextPath()%>/admin/login.jsp">退出</a></em></font><br>
</td></tr>
</table>
<a href="<%=request.getContextPath()%>/admin/addFile.jsp">文件添加</a></center>
<br>
<%
	String url = request.getContextPath()+ "/servlet/AdminServlet";
	String url2 = request.getContextPath()+ "/servlet/UserServlet";
	PageBean pb = (PageBean)request.getAttribute("pageBean");
	List<HashMap> fl = pb.getData();
	for(int i=0;i<fl.size();i++){
%>
<table width="650px">
  <tr><td><a href="<%=url2%>/showFile?id=<%=fl.get(i).get("fileID")%>"><%=fl.get(i).get("fileTitle")%></a></td></tr>
  <tr><td>文件大小:<%=fl.get(i).get("fileSize")%>字节&nbsp&nbsp&nbsp
  更新日期:<%=fl.get(i).get("lastModified")%>&nbsp&nbsp&nbsp
  下载次数:<%=fl.get(i).get("hits")%>
  </tr>
  <tr><td>详细描述:<%=fl.get(i).get("description")%></td>
  </tr>
  <tr><td align="right">
  <a href="<%=url %>/recomm?id=<%=fl.get(i).get("fileID")%>">推荐</a>
  &nbsp&nbsp<a href="<%=url %>/updateFile?id=<%=fl.get(i).get("fileID")%>">修改</a></td>
</table>
<hr width="600px" size="1px" color="#COCOCO">
<br>
<%	}	%>
  总共<%=pb.getTotalRows()%>行 页数<%=pb.getCurPage()%>/<%=pb.getTotalPages()%>&nbsp
<%
	if ( pb.getCurPage()==1){
%>
	首页 上一页
<%	} else {%>
	<a href="<%=url%>/manage?page=1">首页</a>
	<a href="<%=url%>/manage?page=<%=pb.getCurPage()-1%>">上一页</a>
<%	}	%>
<%
	if ( pb.getCurPage()>=pb.getTotalPages()){
%>
	下一页 尾页
<%	} else {%>
	<a href="<%=url%>/manage?page=<%=pb.getCurPage()+1%>">下一页</a>
	<a href="<%=url%>/manage?page=<%=pb.getTotalPages()%>">尾页</a>
<%}%>
</center>

</body>