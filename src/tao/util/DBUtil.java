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

	// ��ȡ���Ӷ���
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

	// ��ȡ������
	private PreparedStatement getPrepareStatement(String sql) {
		try {
			pstmt = getConnection().prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pstmt;
	}

	// ��pstmt��SQL������ò�����Ҫ�������������ʽ������
	private void setParams(String sql, Object[] params) {
		pstmt = this.getPrepareStatement(sql);
		for (int i = 0; i < params.length; i++)
			try {
				pstmt.setString(i + 1, (String) params[i]);
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	
	// ִ�����ݿ��ѯ����ʱ�����ؽ���ļ�¼������
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
	
	// ִ�����ݿ��ѯ����ʱ�������صĶ��������¼��װ��List������
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
	
	// ִ�����ݿ��ѯ����ʱ�������ص�һ�������¼��װ��List������
	public Map getMap(String sql, Object[] params){
		List list=getList(sql, params);
		if(list.isEmpty())
			return null;
		else
		    return (Map)list.get(0);
		
	}
	
	// �������ݿ�ʱ���õ�update����
	public int update(String sql, Object[] params) {
		int recNo = 0;// ��ʾ��Ӱ��ļ�¼����
		try {
			setParams(sql, params);// ����sql����params������pstmt����
			recNo = pstmt.executeUpdate();// ִ�и��²���
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return recNo;
	}
	
	
	
	// �رն���
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