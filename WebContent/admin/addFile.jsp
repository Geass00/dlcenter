<%@ page pageEncoding="GBK" %>
<%@ include file="/header.jsp" %>

<body bgcolor="#d5e5ce">
<script>
   function check(){
      name=document.f.name.value;
      file=document.f.file.value;
      if(name==""){
         alert("���Ʋ���Ϊ�գ�");
         return false;
      }else if(file==""){
         alert("��ѡ��Ҫ�ϴ���Ŀ���ļ���");
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
            <h2>�ļ����</h2>
            <table border="0" cellspacing="1" width="60%">
              <tr> 
                <td width="20%" align="right" bgcolor="#CCCCCC"><b>�ļ�˵��</b></td>
                <td bgcolor="#CCCCCC"> 
                  <input type="text" name="name" size="50">
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
                  <textarea rows="6" name="description" cols="50"></textarea>
                </td>
              </tr>
              <tr>
                <td align="right" bgcolor="#CCCCCC"><b>�ļ��ϴ�</b></td>
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