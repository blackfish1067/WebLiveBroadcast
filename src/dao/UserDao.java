package dao;

import java.sql.*;
import java.util.ArrayList;

import models.User;



public class UserDao {
	public User login(String userID, String password){
		User user = null;
		String sql = "SELECT* FROM userData WHERE userID = ? AND password = ?";
		ResultSet rSet = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBDao.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, password);
			rSet = pstmt.executeQuery();
			if(rSet.next()){
				user = new User();
				user.setUserID(rSet.getString("userID"));
				user.setPassword(rSet.getString("password"));//-----------------------
				}
			conn.close();
			pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
				}finally{
					DBDao.closeConnection(conn);
					}
		return user;
		}
	
	public void register(User user){
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into userData values(?, ?)";
		try{
			conn = DBDao.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getPassword());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBDao.closeConnection(conn);
		}
	}
	
	//------------------------------------------------------
	
	
	public String getPlaySource(String number, String episode){
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "SELECT source FROM video WHERE number = ? AND episode = ?";
		String source = "";
		ResultSet rSet = null;
		try{
			conn = DBDao.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, number);
			pstmt.setString(2, episode); 
			rSet = pstmt.executeQuery();
			if(rSet.next())
				source = rSet.getString("source");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBDao.closeConnection(conn);
		}
		return source;
	}
	
	
}
