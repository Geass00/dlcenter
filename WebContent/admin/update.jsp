<%@ page pageEncoding="GBK" %>
<%@ include file="/header.jsp" %>
<%@ page import="tao.util.PageBean,java.util.*"%>  
<%
	String url = request.getContextPath()+ "/servlet/AdminServlet";
	String url2 = request.getContextPath()+ "/servlet/UserServlet";
%>

<body bgcolor="#d5e5ce">
<form method="post" action="<%=url%>/dealUpdate" enctype="multipart/form-data" name="f" onSubmit="return check()">
     <%
     Map m=(Map)request.getAttribute("file");
      %>
     <input type="hidden" name="id" value="<%=m.get("fileID")%>">
      <input type="hidden" name="filePath" value="<%=m.get("filePath")%>">
     
      <div align="center">
            <h2>�ļ��޸�</h2>
            <table border="0" cellspacing="1" width="60%">
              <tr> 
                <td width="20%" align="right" bgcolor="#CCCCCC"><b>�ļ�˵��</b></td>
                <td bgcolor="#CCCCCC"> 
                  <input type="text" name="name" size="50" value="<%=m.get("fileTitle")%>">
                </td>
              </tr>
              <tr> 
                <td align="right" bgcolor="#CCCCCC"><b>�ļ�����</b></td>
                <td bgcolor="#CCCCCC"> 
                  <select name="type">
                 
                      <option value="01">ͼƬ</option>
                      <option value="02">Flash</option>
                      <option value="03">����</option>
                      <option value="04">С��Ƶ</option>
                      <option value="05">����</option>
                  </select>
                </td>
              </tr>
              <tr> 
                <td align="right" bgcolor="#CCCCCC"><b>��ϸ����</b></td>
                <td bgcolor="#CCCCCC"> 
                  <textarea rows="6" name="description" cols="50" ><%=m.get("description")%></textarea>
                </td>
              </tr>
              <tr>
              <td align="right" bgcolor="#cccccc"><b>�����ļ�</b></td>
              <td><font size="2"><a href="<%=url2 %>/showFile?id=<%=m.get("fileID") %>"><%=m.get("fileName") %></a></font></td>
              </tr>
              <tr>
                <td align="right" bgcolor="#CCCCCC"><b>�����ϴ�</b></td>
                <td bgcolor="#CCCCCC"> 
                  <input type="file" name="file">
                </td>
              </tr>
            </table>
       </div>
       <div align="center">
            <p> 
               <input type="submit" value="�ύ">
               <input type="reset" value="����">
            </p>
       </div>
</form>

</body>