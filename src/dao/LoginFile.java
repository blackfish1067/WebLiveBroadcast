package dao;

public class LoginFile extends ReadFile{

	public static boolean isLogin(String userName, String password){
		if(!flag){
			flag = readUsers();
		}
		//判断登陆是否成功，即相应的用户名密码是否正确
		for(int i = 0; i < usernames.size(); i++){
			if(userName.equals(usernames.get(i))&&password.equals(passwds.get(i))){
					return true;
			}	
		}
		return false;
    }
	
	public static boolean isUserExist(String userName){
		if(!flag){
			flag = readUsers();
		}
		//判断用户名是否已经存在
		for(int i = 0; i < usernames.size(); i++){
			if(userName.equals(usernames.get(i))){
				return true;
			}
		}
		return false;
    }
}
