<%@ page pageEncoding="GBK" %>
<%@ page import="tao.util.PageBean,java.util.*"%>   
<%@ include file="/header.jsp" %>
<body bgcolor="#d5e5ce">
<center>
	<h2>
		文件详细信息
	</h2>
	<%
	String url = request.getContextPath()+ "/servlet/UserServlet";
	Map m= (Map)request.getAttribute("file");
	List<Map> comm=(List<Map>)request.getAttribute("comm");
	%>
	<table border width="70%">
		<tr>
			<td bgcolor="#CCCCCC" width="15%">
				文件说明:	
			</td>
			<td width="45%">
				<%=m.get("fileTitle") %>
			</td>
			<td bgcolor="#CCCCCC" width="15%">
				文件大小:
			</td>
			<td>
				<%=m.get("fileSize") %>
			</td>
			</tr>
			
			<tr>
			<td bgcolor="#CCCCCC" width="15%">
				更新日期
			</td>
			<td width="45%">
			<%=m.get("lastModified") %>
			</td>
			<td bgcolor="#CCCCCC" width="15%">
				下载次数
			</td>
			<td>
			<%=m.get("hits") %>
			</td>
			</tr>
			
			<tr>
			<td bgcolor="#CCCCCC" width="15%">
				详细描述
			</td>
			<td width="45%">
			<%=m.get("description") %>
			</td>
			</tr>
			<tr>
			
			 <td colspan="4" align="center">
			 	<a href="<%=request.getContextPath()%>/servlet/UserServlet/download?id=<%=m.get("fileID")%>">下载</a>
			 	&nbsp;&nbsp;&nbsp;&nbsp;
			 	<a href="<%=request.getContextPath()%>/servlet/UserServlet/listFile">返回</a>
			</tr>
	</table>
	<table width="650px">
		<%for(int i=0;i<comm.size();i++) { %>
		<table width="650px">

			<tr><td width="50%"><b><%=comm.get(i).get("commentator") %>:</b></td><td width="50%">发表时间：<%=comm.get(i).get("commTime")%></td></tr>
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
         alert("评论内容不能为空！");
         return false;
      }else{
         return true;
      }
   }
</script>
	<form name="f" action="<%=url%>/addComment" onSubmit="return check()">
	<table>
	<tr><td><input type="hidden" name="id" value=<%=m.get("fileID") %>></input> </td></tr>
	<tr><td>昵称:</td><td><input type="text" name="nickname" size="40"></input>（您可以输入，也可以不输入此项。）</td></tr>
	<tr><td>评论:</td><td><textarea name="content" rows="4" cols ="80" size="200"></textarea></td></tr></table>
	<input type="submit" value ="提交">
	
	</form>
</center>
</body>>