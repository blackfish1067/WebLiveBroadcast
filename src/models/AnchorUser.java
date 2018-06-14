package models;

public class AnchorUser implements User {

	//定义私有属性
	private String userID;
	private String passWord;
	
	public String getUserID(){
		return this.userID;
	}
	
	public void setUserID(String userID){
		this.userID = userID;
	}
	
	public String getPassword(){
		return this.passWord;
	}
	
	public void setPassword(String passWord){
		this.passWord = passWord;
	}

}
