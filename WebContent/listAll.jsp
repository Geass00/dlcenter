<%@ page pageEncoding="GBK" %>
<%@ page import="tao.util.PageBean,java.util.*"%>
<%@ include file="/header.jsp" %>
<body bgcolor="#d5e5ce">
<div>
<center>
<h2><font color=Blue>������������</font></h2>
<%
	PageBean pb = (PageBean)request.getAttribute("pageBean");
	List<HashMap> fl = pb.getData();
	String url = request.getContextPath()+ "/servlet/UserServlet";
%>	
<script>
   function check(){
      file=document.f.fileName.value;
      if(file==""){
         alert("������ؼ���");
         return false;
         }
         
         else
         	return true;
   }
</script>

<table width=60% >
<tr><td align="right"><a href="<%=url%>/sortByDate">�����Ƽ�</a>&nbsp;&nbsp;<a href="<%=url%>/sortByHits">��������</a></td></tr>
<tr><td><form action="<%=url%>/search" method="post" name="f" onSubmit="return check()"><input type="text"  name="fileName"/><input type="submit"  value="�ļ�����"/></form> </td></tr>
</table><br>
<% 
for(int i=0;i<fl.size();i++){
%>
<table>
 <tr><td><a href="<%=url%>/showFile?id=<%=fl.get(i).get("fileID")%>"><%=fl.get(i).get("fileTitle")%></a></td></tr>
  <tr><td>�ļ���С:<%=fl.get(i).get("fileSize")%>�ֽ�&nbsp&nbsp&nbsp
  ��������:<%=fl.get(i).get("lastModified")%>&nbsp&nbsp&nbsp
  ���ش���:<%=fl.get(i).get("hits")%>
  </tr>
  <tr><td>��ϸ����:<%=fl.get(i).get("description")%></td>
  </tr>
</table>
<br>
<%}%>
 
ÿҳ<%=pb.getPageSize()%>��  ��<%=pb.getTotalRows()%>��  ҳ��<%=pb.getCurPage()%>/<%=pb.getTotalPages()%>
<%
	if ( pb.getCurPage()==1){
%>
	��ҳ ��һҳ
<%} else {%>
	<a href="<%=request.getContextPath()%>/servlet/UserServlet/listFile?page=1">��ҳ</a>
	<a href="<%=request.getContextPath()%>/servlet/UserServlet/listFile?page=<%=pb.getCurPage()-1%>">��һҳ</a>
<%}%>
<%
	if ( pb.getCurPage()==pb.getTotalPages()){
%>
	��һҳ βҳ
<%} else {%>
	<a href="<%=request.getContextPath()%>/servlet/UserServlet/listFile?page=<%=pb.getCurPage()+1%>">��һҳ</a>
	<a href="<%=request.getContextPath()%>/servlet/UserServlet/listFile?page=<%=pb.getTotalPages()%>">βҳ</a>
<%}%>

</center>
</div>
</body>