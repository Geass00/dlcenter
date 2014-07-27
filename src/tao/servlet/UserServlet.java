package tao.servlet;

import java.util.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import tao.service.UserService;
import tao.util.FileUtil;
import tao.util.PageBean;

public class UserServlet extends HttpServlet {

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
		UserService us=new UserService();
		System.out.println(path);
		if(path.equals("/listFile")){
			//�����ļ���ʾ���ܣ�����ҳ����
			String page = request.getParameter("page");
			int curPage = 0; 
			if (page == null || page.length() < 1) { 
				curPage = 1;
			} else {
				curPage = Integer.parseInt(page);
			}
            PageBean pageBean=us.getPageBean(curPage);
            request.setAttribute("pageBean", pageBean);
            rd=request.getRequestDispatcher("/listAll.jsp");
			rd.forward(request, response);
		}else if(path.equals("/showFile")){
			//��ʾ�����ļ��ľ�����Ϣ
			String id=request.getParameter("id");
			Map file=us.getById(id);
			List comment=us.getAllComments(id);
			request.setAttribute("comm", comment);
			request.setAttribute("file", file);
            rd=request.getRequestDispatcher("/showFile.jsp");
			rd.forward(request, response);	
		}
		else if(path.equals("/sortByHits")){
			PageBean pageBean=us.getPageBean("sortByHits",1);
            request.setAttribute("pageBean", pageBean);
            rd=request.getRequestDispatcher("/listAll.jsp");
			rd.forward(request, response);
		}else if(path.equals("/sortByDate")){
			PageBean pageBean=us.getPageBean("sortByDate",1);
            request.setAttribute("pageBean", pageBean);
            rd=request.getRequestDispatcher("/listAll.jsp");
			rd.forward(request, response);
		}else if(path.equals("/addComment")){
			// ��������
			String id=request.getParameter("id");
			String nickname=request.getParameter("nickname");
			String content=request.getParameter("content");
			int r=us.addComment(id, nickname, content);
			if(r==1)
				request.setAttribute("result","���۳ɹ���");
			else
				request.setAttribute("result","����ʧ�ܣ�");
			rd=request.getRequestDispatcher("/result.jsp");
			rd.forward(request, response);
		}
		else if(path.equals("/search")){
			// �����ļ�
			String fileName=request.getParameter("fileName");
			PageBean pageBean=us.getSearchList(fileName,1);
            request.setAttribute("pageBean", pageBean);
			rd=request.getRequestDispatcher("/listAll.jsp");
			rd.forward(request, response);
		}
		//�����ļ�
		else if(path.equals("/download")){
			String id=request.getParameter("id");
			Map file=us.getById(id);
			FileUtil fu=new FileUtil();
			int result=0;
			result=	fu.download(this.getServletContext(), response, file);
			if (result==1)
			us.updateHits(id);	
			rd=request.getRequestDispatcher("/result.jsp");
		}
	}
}
