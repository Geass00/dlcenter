package tao.service;

import java.util.*;
import java.io.*;

import tao.util.*;

public class AdminService {
	private static final int PAGESIZE = 3;		// 页面显示记录条数
	
	private DBUtil db=new DBUtil();

    //添加信息
	public int add(Map file,Map parameters){
		int result=0;
		Object fileTitle=parameters.get("name");
		Object fileSize=file.get("size");
		String hits="0";
		Object caltID=parameters.get("type");
		Object description=parameters.get("description");
		Object filePath=file.get("filePath");
		Object fileName=file.get("fileName");
		String sql="insert into fileInfo(fileTitle,lastModified,fileSize,hits," +
				"catlID,description,filePath,fileName,status) values(?,getdate(),?,?,?,?,?,?,?)";
		result=db.update(sql, new Object[]{fileTitle,fileSize,hits,caltID,description,filePath,fileName,"1"});
		System.out.println(sql);
		return result;
	}
	
	// 分页显示查询结果时，将当前页中的所有信息封装到PageBean中
	public PageBean getPageBean(int curPage){
		String sql="select count(*) from fileInfo";
		int total = db.getTotalRows(sql, new Object[]{});
		sql="select top " + PAGESIZE + " * from (select top " + (total-(curPage-1)*PAGESIZE) + 
				" * from fileInfo order by lastModified) t1 order by lastModified desc";
		
		List data=db.getList(sql, new Object[]{});
		System.out.println(sql);
		PageBean pb=new PageBean();
		pb.setData(data);
		pb.setCurPage(curPage);
		pb.setPageSize(PAGESIZE);
		pb.setTotalRows(total);
		return pb;
	}
	public boolean loginCheck(String adminName,String password){
		String sql="select * from adminUser where adminName=? and password=?";
		System.out.println(sql);
		Map m=db.getMap(sql, new Object[]{adminName,password});
		if(m==null)
			return false;
		else
			return true;
	}
	public Map getById(String id){
		String sql="select * from fileInfo where fileID=?";
		
		return db.getMap(sql, new Object[]{id});
	}
	public int recommFile(String id){
		String sql="update fileInfo set status=2 where fileID=?";
		int res= db.update(sql, new Object[]{id});
		return res;
	}
	//更新上传文件
	public int updateFile(String realPath,Map file,Map parameters){
		int result=0;
		File f=new File(realPath);
		f.delete();
		String sql="update fileInfo set fileSize=?,filePath=?,fileName=? where fileID=?";
		result=db.update(sql, new Object[]{file.get("size"),file.get("filePath"),file.get("fileName"),parameters.get("id")});
		System.out.println(sql);
		return result;
	}
	public int updateInfo(Map parameters){
		Object id=parameters.get("id");
		Object name=parameters.get("name");
		Object type=parameters.get("type");
		Object description=parameters.get("description");
		String sql="update fileInfo set fileTitle=?,lastModified=getdate(),catlID=?,description=? where fileID=?";
		return db.update(sql, new Object[]{name,type,description,id});
	}
		
}