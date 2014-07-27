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
            <h2>文件修改</h2>
            <table border="0" cellspacing="1" width="60%">
              <tr> 
                <td width="20%" align="right" bgcolor="#CCCCCC"><b>文件说明</b></td>
                <td bgcolor="#CCCCCC"> 
                  <input type="text" name="name" size="50" value="<%=m.get("fileTitle")%>">
                </td>
              </tr>
              <tr> 
                <td align="right" bgcolor="#CCCCCC"><b>文件类型</b></td>
                <td bgcolor="#CCCCCC"> 
                  <select name="type">
                 
                      <option value="01">图片</option>
                      <option value="02">Flash</option>
                      <option value="03">音乐</option>
                      <option value="04">小视频</option>
                      <option value="05">其他</option>
                  </select>
                </td>
              </tr>
              <tr> 
                <td align="right" bgcolor="#CCCCCC"><b>详细描述</b></td>
                <td bgcolor="#CCCCCC"> 
                  <textarea rows="6" name="description" cols="50" ><%=m.get("description")%></textarea>
                </td>
              </tr>
              <tr>
              <td align="right" bgcolor="#cccccc"><b>现有文件</b></td>
              <td><font size="2"><a href="<%=url2 %>/showFile?id=<%=m.get("fileID") %>"><%=m.get("fileName") %></a></font></td>
              </tr>
              <tr>
                <td align="right" bgcolor="#CCCCCC"><b>重新上传</b></td>
                <td bgcolor="#CCCCCC"> 
                  <input type="file" name="file">
                </td>
              </tr>
            </table>
       </div>
       <div align="center">
            <p> 
               <input type="submit" value="提交">
               <input type="reset" value="重填">
            </p>
       </div>
</form>

</body>