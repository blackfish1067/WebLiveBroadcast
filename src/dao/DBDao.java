package dao;

import java.sql.*;

public class DBDao {
	public static Connection getConnection(){
		Connection conn = null;
		try{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn = (Connection)DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=Live", "sa", "123456");
		    System.out.println("数据库连接成功");
		}catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}
	
	protected static void closeConnection(Connection conn){
		if(conn != null){
			try{
				conn.close();
				System.out.println("数据库连接断开");
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
}
