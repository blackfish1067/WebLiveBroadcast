package models;

public class User {
	/**
	 * 2018/6/14
	 * content: 添加注释、构造器，修改合适的变量名
	 */
	
	//定义私有属性
	private String userID;
	private String passWord;
	
	//无参数的构造器
	public User() {
		
	}
	
	//有参数的构造器
	public User(String userID,String passWord) {
		this.userID = userID;
		this.passWord = passWord;
	}
	
	//创建的setter和getter方法
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
