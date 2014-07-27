package tao.util;

import java.sql.*;
import java.util.*;

public class DBUtil {
	private static final String DRIVERCLASS = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static final String URL = "jdbc:sqlserver://localhost:1433;DatabaseName=dlDB";
	private static final String USERNAME = "sa";
	private static final String PASSWORD = "123";
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	// 获取连接对象
	private Connection getConnection() {
		try {
			Class.forName(DRIVERCLASS);
			conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

	// 获取语句对象
	private PreparedStatement getPrepareStatement(String sql) {
		try {
			pstmt = getConnection().prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pstmt;
	}

	// 给pstmt的SQL语句设置参数（要求参数以数组形式给出）
	private void setParams(String sql, Object[] params) {
		pstmt = this.getPrepareStatement(sql);
		for (int i = 0; i < params.length; i++)
			try {
				pstmt.setString(i + 1, (String) params[i]);
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	
	// 执行数据库查询操作时，返回结果的记录总数。
	public int getTotalRows(String sql, Object[] params) {
		int totalRows = 0;
		try {
			this.setParams(sql, params);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next())
				totalRows = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return totalRows;
	}
	
	// 执行数据库查询操作时，将返回的多条结果记录封装到List对象中
	public List getList(String sql, Object[] params){
		List list = new ArrayList<HashMap>();
		try {
			this.setParams(sql, params);
			ResultSet rs = pstmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			while(rs.next()) {
			    Map m = new HashMap();
			    for (int i = 1; i <= rsmd.getColumnCount(); i++) {
				   String colName = rsmd.getColumnName(i);
				   int type=rsmd.getColumnType(i);
				   m.put(colName, rs.getString(colName));
			    }
			    list.add(m);
		    }
		 } catch (SQLException e) {
			e.printStackTrace();
		 }finally{
			close();
		}
		return list;
	}
	
	// 执行数据库查询操作时，将返回的一条结果记录封装到List对象中
	public Map getMap(String sql, Object[] params){
		List list=getList(sql, params);
		if(list.isEmpty())
			return null;
		else
		    return (Map)list.get(0);
		
	}
	
	// 更新数据库时调用的update方法
	public int update(String sql, Object[] params) {
		int recNo = 0;// 表示受影响的记录行数
		try {
			setParams(sql, params);// 根据sql语句和params，设置pstmt对象
			recNo = pstmt.executeUpdate();// 执行更新操作
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return recNo;
	}
	
	
	
	// 关闭对象
	private void close() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
		}
	}
}