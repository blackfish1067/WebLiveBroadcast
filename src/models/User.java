package models;

public class User {
	private String userID;
	private String passkey;
	
	public String getUserID(){
		return this.userID;
	}
	
	public void setUserID(String userID){
		this.userID = userID;
	}
	
	public String getPassword(){
		return this.passkey;
	}
	
	public void setPassword(String passkey){
		this.passkey = passkey;
	}
}
