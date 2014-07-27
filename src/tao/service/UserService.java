package tao.service;

import java.util.*;

import tao.util.DBUtil;
import tao.util.PageBean;

public class UserService {
	private static final int PAGESIZE = 3;		// 页面显示记录条数
	
	private DBUtil db=new DBUtil();
	
	// 分页显示查询结果时，将当前页中的所有信息封装到PageBean中
	public PageBean getPageBean(int curPage){
		String sql="select count(*) from fileInfo";
		int total = db.getTotalRows(sql, new Object[]{});
		sql="select top " + PAGESIZE + " * from (select top " + (total-(curPage-1)*PAGESIZE) + 
				" * from fileInfo order by lastModified) t1 order by lastModified desc";
		System.out.println(sql);
		List data=db.getList(sql, new Object[]{});
		PageBean pb=new PageBean();
		pb.setData(data);
		pb.setCurPage(curPage);
		pb.setPageSize(PAGESIZE);
		pb.setTotalRows(total);
		return pb;
	}
	
	public PageBean getPageBean(String op,int curPage){
		String sortType="lastModified";
		if (op.equals("sortByHits")){
			sortType="hits";
		}else if(op.equals("sortByDate")){
			sortType="lastModified";
		}
		String sql="select count(*) from fileInfo";
		int total = db.getTotalRows(sql, new Object[]{});
		sql="select top " + PAGESIZE + " * from (select top " + (total-(curPage-1)*PAGESIZE) + 
				" * from fileInfo order by " + sortType + ") t1 order by " + sortType +" desc";
		System.out.println(sql);
		List data=db.getList(sql, new Object[]{});
		PageBean pb=new PageBean();
		pb.setData(data);
		pb.setCurPage(curPage);
		pb.setPageSize(PAGESIZE);
		pb.setTotalRows(total);
		return pb;
	}
	
	
    //通过id获得单条数据信息
	public Map getById(String id){
		String sql="select * from fileInfo where fileID=?";
		return db.getMap(sql, new Object[]{id});
	}
	
	public int addComment(String id,String nickname,String content){
		String sql="insert into comment(fileID,commentator,content,commTime) " +
				"values(?,?,?,getdate())";
		int result =db.update(sql,new Object[]{id,nickname,content});
		return result;
	}
	public List<Map> getAllComments(String id){
		String sql="select * from comment where fileID=?";
		List<Map> data=db.getList(sql, new Object[]{id});
		return data;
	}
	public PageBean getSearchList(String fileName,int curPage){
		System.out.println(fileName);
		String sql="select count(*) from fileInfo where fileTitle like "+"'%"+fileName+"%'";
		System.out.println(sql);
		int total = db.getTotalRows(sql, new Object[]{});
		System.out.println(total);
		sql="select * from fileInfo where  fileTitle like "+"'%"+fileName+"%'";
		System.out.println(sql);
		List data=db.getList(sql, new Object[]{});
		PageBean pb=new PageBean();
		pb.setData(data);
		pb.setCurPage(curPage);
		pb.setPageSize(PAGESIZE);
		pb.setTotalRows(total);
		return pb;
	}
	public void updateHits(String id){
		//更新下载次数
		String sql="update fileInfo set hits=hits+1 where fileID=?";
		 db.update(sql, new Object[]{id});
		
	}
}

