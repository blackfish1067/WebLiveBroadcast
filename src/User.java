package models;

public class User {
	/**
	 * 2018/6/14
	 * content: ���ע�͡����������޸ĺ��ʵı�����
	 */
	
	//����˽������
	private String userID;
	private String passWord;
	
	//�޲����Ĺ�����
	public User() {
		
	}
	
	//�в����Ĺ�����
	public User(String userID,String passWord) {
		this.userID = userID;
		this.passWord = passWord;
	}
	
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
