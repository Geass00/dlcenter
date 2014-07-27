<%@ page pageEncoding="GBK" %>
<%@ include file="/header.jsp" %>

<body bgcolor="#d5e5ce">
<script>
   function check(){
      name=document.f.name.value;
      file=document.f.file.value;
      if(name==""){
         alert("名称不能为空！");
         return false;
      }else if(file==""){
         alert("请选择要上传的目标文件！");
         return false;
      }else{
         return true;
      }
   }
</script>
<%
	String url = request.getContextPath()+ "/servlet/AdminServlet";
%>
<form method="post" action="<%=url%>/addFile" enctype="multipart/form-data" name="f" onSubmit="return check()">
      <div align="center">
            <h2>文件添加</h2>
            <table border="0" cellspacing="1" width="60%">
              <tr> 
                <td width="20%" align="right" bgcolor="#CCCCCC"><b>文件说明</b></td>
                <td bgcolor="#CCCCCC"> 
                  <input type="text" name="name" size="50">
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
                  <textarea rows="6" name="description" cols="50"></textarea>
                </td>
              </tr>
              <tr>
                <td align="right" bgcolor="#CCCCCC"><b>文件上传</b></td>
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