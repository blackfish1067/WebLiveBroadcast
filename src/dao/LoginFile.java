package dao;

public class LoginFile extends ReadFile{

	public static boolean isLogin(String userName, String password){
		if(!flag){
			flag = readUsers();
		}
		//�жϵ�½�Ƿ�ɹ�������Ӧ���û��������Ƿ���ȷ
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
		//�ж��û����Ƿ��Ѿ�����
		for(int i = 0; i < usernames.size(); i++){
			if(userName.equals(usernames.get(i))){
				return true;
			}
		}
		return false;
    }
}
