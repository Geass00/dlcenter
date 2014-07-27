package tao.servlet;

import java.util.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tao.util.FileUtil;

import tao.util.*;
import tao.service.AdminService;

public class AdminServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("GBK");
		//�����ļ�·��������·�����в�ͬ�Ĵ���
		String requestPath=request.getRequestURI();
		int i=requestPath.lastIndexOf('/');
		String path=requestPath.substring(i);
		RequestDispatcher rd=null;
		//����ģ�Ͳ����
		AdminService as=new AdminService();
		if(path.equals("/addFile")){
			//��������ļ��Ĳ����������ϴ��ļ��Ͱ��ļ���Ϣд�����ݿ�
			String uploadPath="/filescen";
			FileUtil fu=new FileUtil();
			int r=fu.upload(this.getServletContext(), request, response, uploadPath);
			//�����ɹ���ʧ�ܺ󷵻ؽ��ҳ��result.jsp
			if(r==1 && as.add(fu.getFile(),fu.getParameters())==1){
				request.setAttribute("result", "��ӳɹ���");
			}else{
				request.setAttribute("result", "���ʧ�ܣ�");
			}
			rd=request.getRequestDispatcher("/admin/result.jsp");
			rd.forward(request, response);
		}else if(path.equals("/updateFile")){
			//�����ļ�ʱ����ʾ�����µ��ļ���Ϣ
			String id=request.getParameter("id");
			Map file=as.getById(id);
			request.setAttribute("file", file);
			rd=request.getRequestDispatcher("/admin/update.jsp");
			rd.forward(request, response);
		}else if(path.equals("/dealUpdate")){
			//������²��������·��������֣������ϴ��ļ��͸����ļ���Ϣ��
			int result=0;
			String uploadPath="/filescen";
			FileUtil fu=new FileUtil();
			int r= fu.upload(this.getServletContext(),request,response,uploadPath);
			if(r==1){
				Map file=(Map)fu.getFile();
				Map parameters=fu.getParameters();
				if(!file.isEmpty()){
					String realPath=this.getServletContext().getRealPath((String)parameters.get("filePath"));
					result=as.updateFile(realPath, file, parameters);
				}
				result=as.updateInfo(parameters);
			}
			if (result==1){
				request.setAttribute("result","���³ɹ���");
			}else
				request.setAttribute("result","����ʧ��!");
			rd=request.getRequestDispatcher("/admin/result.jsp");
			rd.forward(request, response);
		}else if(path.equals("/recomm")){
			//����Ա�Ƽ�
			String id=request.getParameter("id");
			int r=as.recommFile(id);
			if(r==1)
				request.setAttribute("result","�Ƽ��ɹ���");
			else
				request.setAttribute("result","�Ƽ�ʧ�ܣ�");
			rd=request.getRequestDispatcher("/admin/result.jsp");
			rd.forward(request, response);
			
		}else if(path.equals("/manage")){
			//�ļ���ʾ���ܣ�����ҳ����
			String page = request.getParameter("page");
			int curPage = 0; 
			if (page == null || page.length() < 1) { 
				curPage = 1;
			} else {
				curPage = Integer.parseInt(page);
			}
            PageBean pageBean=as.getPageBean(curPage);
            request.setAttribute("pageBean", pageBean);
            rd=request.getRequestDispatcher("/admin/manageFile.jsp");
			rd.forward(request, response);
		}
		else if(path.equals("/login")){
			String adminName=request.getParameter("username");
			String password=request.getParameter("password");
			boolean checkAdmin=as.loginCheck(adminName, password);
			if(checkAdmin==true){
				rd=request.getRequestDispatcher("/admin/loginSuccess.jsp");
			}else
				rd=request.getRequestDispatcher("/admin/loginFail.jsp");
			rd.forward(request, response);
		}
	}
}
