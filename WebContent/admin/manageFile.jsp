<%@ page pageEncoding="GBK" %>
<%@ page import="tao.util.PageBean,java.util.*"%>
<%@ include file="/header.jsp" %>

<body bgcolor="#d5e5ce">
<center>
<h2>�ļ���������</h2>
<center>
<table width="650px"><tr><td > 
<font color="#808000">��ӭ����<%=session.getAttribute("name")%>!!!</font></td>
<td>
<font color="#ff8000"><em><a href="<%=request.getContextPath()%>/admin/login.jsp">�˳�</a></em></font><br>
</td></tr>
</table>
<a href="<%=request.getContextPath()%>/admin/addFile.jsp">�ļ����</a></center>
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
  <tr><td>�ļ���С:<%=fl.get(i).get("fileSize")%>�ֽ�&nbsp&nbsp&nbsp
  ��������:<%=fl.get(i).get("lastModified")%>&nbsp&nbsp&nbsp
  ���ش���:<%=fl.get(i).get("hits")%>
  </tr>
  <tr><td>��ϸ����:<%=fl.get(i).get("description")%></td>
  </tr>
  <tr><td align="right">
  <a href="<%=url %>/recomm?id=<%=fl.get(i).get("fileID")%>">�Ƽ�</a>
  &nbsp&nbsp<a href="<%=url %>/updateFile?id=<%=fl.get(i).get("fileID")%>">�޸�</a></td>
</table>
<hr width="600px" size="1px" color="#COCOCO">
<br>
<%	}	%>
  �ܹ�<%=pb.getTotalRows()%>�� ҳ��<%=pb.getCurPage()%>/<%=pb.getTotalPages()%>&nbsp
<%
	if ( pb.getCurPage()==1){
%>
	��ҳ ��һҳ
<%	} else {%>
	<a href="<%=url%>/manage?page=1">��ҳ</a>
	<a href="<%=url%>/manage?page=<%=pb.getCurPage()-1%>">��һҳ</a>
<%	}	%>
<%
	if ( pb.getCurPage()>=pb.getTotalPages()){
%>
	��һҳ βҳ
<%	} else {%>
	<a href="<%=url%>/manage?page=<%=pb.getCurPage()+1%>">��һҳ</a>
	<a href="<%=url%>/manage?page=<%=pb.getTotalPages()%>">βҳ</a>
<%}%>
</center>

</body>