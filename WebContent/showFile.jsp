<%@ page pageEncoding="GBK" %>
<%@ page import="tao.util.PageBean,java.util.*"%>   
<%@ include file="/header.jsp" %>
<body bgcolor="#d5e5ce">
<center>
	<h2>
		�ļ���ϸ��Ϣ
	</h2>
	<%
	String url = request.getContextPath()+ "/servlet/UserServlet";
	Map m= (Map)request.getAttribute("file");
	List<Map> comm=(List<Map>)request.getAttribute("comm");
	%>
	<table border width="70%">
		<tr>
			<td bgcolor="#CCCCCC" width="15%">
				�ļ�˵��:	
			</td>
			<td width="45%">
				<%=m.get("fileTitle") %>
			</td>
			<td bgcolor="#CCCCCC" width="15%">
				�ļ���С:
			</td>
			<td>
				<%=m.get("fileSize") %>
			</td>
			</tr>
			
			<tr>
			<td bgcolor="#CCCCCC" width="15%">
				��������
			</td>
			<td width="45%">
			<%=m.get("lastModified") %>
			</td>
			<td bgcolor="#CCCCCC" width="15%">
				���ش���
			</td>
			<td>
			<%=m.get("hits") %>
			</td>
			</tr>
			
			<tr>
			<td bgcolor="#CCCCCC" width="15%">
				��ϸ����
			</td>
			<td width="45%">
			<%=m.get("description") %>
			</td>
			</tr>
			<tr>
			
			 <td colspan="4" align="center">
			 	<a href="<%=request.getContextPath()%>/servlet/UserServlet/download?id=<%=m.get("fileID")%>">����</a>
			 	&nbsp;&nbsp;&nbsp;&nbsp;
			 	<a href="<%=request.getContextPath()%>/servlet/UserServlet/listFile">����</a>
			</tr>
	</table>
	<table width="650px">
		<%for(int i=0;i<comm.size();i++) { %>
		<table width="650px">

			<tr><td width="50%"><b><%=comm.get(i).get("commentator") %>:</b></td><td width="50%">����ʱ�䣺<%=comm.get(i).get("commTime")%></td></tr>
			<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp<%=comm.get(i).get("content") %></td></tr>
		</table>
		<hr width="650px" size="1px" color="#COCOCO">
		<br>
	<%} %>
	</table>
	</table>
	<script>
   function check(){
      content=document.f.content.value;
      if(content==""){
         alert("�������ݲ���Ϊ�գ�");
         return false;
      }else{
         return true;
      }
   }
</script>
	<form name="f" action="<%=url%>/addComment" onSubmit="return check()">
	<table>
	<tr><td><input type="hidden" name="id" value=<%=m.get("fileID") %>></input> </td></tr>
	<tr><td>�ǳ�:</td><td><input type="text" name="nickname" size="40"></input>�����������룬Ҳ���Բ���������</td></tr>
	<tr><td>����:</td><td><textarea name="content" rows="4" cols ="80" size="200"></textarea></td></tr></table>
	<input type="submit" value ="�ύ">
	
	</form>
</center>
</body>>