package models;

public class clientUser implements User{
	
	/**
	 * 2018/6/14
	 * content: ���ע�͡����������޸ĺ��ʵı�����
	 */
	
	//����˽������
	private String userID;
	private String passWord;
	
	
	
	//������setter��getter����
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
