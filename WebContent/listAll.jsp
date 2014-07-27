<%@ page pageEncoding="GBK" %>
<%@ page import="tao.util.PageBean,java.util.*"%>
<%@ include file="/header.jsp" %>
<body bgcolor="#d5e5ce">
<div>
<center>
<h2><font color=Blue>数据下载中心</font></h2>
<%
	PageBean pb = (PageBean)request.getAttribute("pageBean");
	List<HashMap> fl = pb.getData();
	String url = request.getContextPath()+ "/servlet/UserServlet";
%>	
<script>
   function check(){
      file=document.f.fileName.value;
      if(file==""){
         alert("请输入关键字");
         return false;
         }
         
         else
         	return true;
   }
</script>

<table width=60% >
<tr><td align="right"><a href="<%=url%>/sortByDate">最新推荐</a>&nbsp;&nbsp;<a href="<%=url%>/sortByHits">热门下载</a></td></tr>
<tr><td><form action="<%=url%>/search" method="post" name="f" onSubmit="return check()"><input type="text"  name="fileName"/><input type="submit"  value="文件搜索"/></form> </td></tr>
</table><br>
<% 
for(int i=0;i<fl.size();i++){
%>
<table>
 <tr><td><a href="<%=url%>/showFile?id=<%=fl.get(i).get("fileID")%>"><%=fl.get(i).get("fileTitle")%></a></td></tr>
  <tr><td>文件大小:<%=fl.get(i).get("fileSize")%>字节&nbsp&nbsp&nbsp
  更新日期:<%=fl.get(i).get("lastModified")%>&nbsp&nbsp&nbsp
  下载次数:<%=fl.get(i).get("hits")%>
  </tr>
  <tr><td>详细描述:<%=fl.get(i).get("description")%></td>
  </tr>
</table>
<br>
<%}%>
 
每页<%=pb.getPageSize()%>行  共<%=pb.getTotalRows()%>行  页数<%=pb.getCurPage()%>/<%=pb.getTotalPages()%>
<%
	if ( pb.getCurPage()==1){
%>
	首页 上一页
<%} else {%>
	<a href="<%=request.getContextPath()%>/servlet/UserServlet/listFile?page=1">首页</a>
	<a href="<%=request.getContextPath()%>/servlet/UserServlet/listFile?page=<%=pb.getCurPage()-1%>">上一页</a>
<%}%>
<%
	if ( pb.getCurPage()==pb.getTotalPages()){
%>
	下一页 尾页
<%} else {%>
	<a href="<%=request.getContextPath()%>/servlet/UserServlet/listFile?page=<%=pb.getCurPage()+1%>">下一页</a>
	<a href="<%=request.getContextPath()%>/servlet/UserServlet/listFile?page=<%=pb.getTotalPages()%>">尾页</a>
<%}%>

</center>
</div>
</body>