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
		//分析文件路径，根据路径进行不同的处理。
		String requestPath=request.getRequestURI();
		int i=requestPath.lastIndexOf('/');
		String path=requestPath.substring(i);
		RequestDispatcher rd=null;
		//创建模型层对象
		AdminService as=new AdminService();
		if(path.equals("/addFile")){
			//处理添加文件的操作，包括上传文件和把文件信息写入数据库
			String uploadPath="/filescen";
			FileUtil fu=new FileUtil();
			int r=fu.upload(this.getServletContext(), request, response, uploadPath);
			//操作成功或失败后返回结果页面result.jsp
			if(r==1 && as.add(fu.getFile(),fu.getParameters())==1){
				request.setAttribute("result", "添加成功！");
			}else{
				request.setAttribute("result", "添加失败！");
			}
			rd=request.getRequestDispatcher("/admin/result.jsp");
			rd.forward(request, response);
		}else if(path.equals("/updateFile")){
			//更新文件时，显示待更新的文件信息
			String id=request.getParameter("id");
			Map file=as.getById(id);
			request.setAttribute("file", file);
			rd=request.getRequestDispatcher("/admin/update.jsp");
			rd.forward(request, response);
		}else if(path.equals("/dealUpdate")){
			//处理更新操作，更新分两个部分，更新上传文件和更新文件信息。
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
				request.setAttribute("result","更新成功！");
			}else
				request.setAttribute("result","更新失败!");
			rd=request.getRequestDispatcher("/admin/result.jsp");
			rd.forward(request, response);
		}else if(path.equals("/recomm")){
			//管理员推荐
			String id=request.getParameter("id");
			int r=as.recommFile(id);
			if(r==1)
				request.setAttribute("result","推荐成功！");
			else
				request.setAttribute("result","推荐失败！");
			rd=request.getRequestDispatcher("/admin/result.jsp");
			rd.forward(request, response);
			
		}else if(path.equals("/manage")){
			//文件显示功能，带分页处理。
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
