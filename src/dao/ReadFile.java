package dao;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

public abstract class ReadFile {
	protected static ArrayList<String> usernames = new ArrayList<String>();
	protected static ArrayList<String> passwds = new ArrayList<String>();
	protected static boolean flag = false;
	protected static String filePath = LoginFile.class.getResource("/").getPath().substring(1)+"userprofile.txt";
	
	protected static boolean readUsers(){
		try {
            File file=new File(filePath);
            if(!file.exists()){
            	file.createNewFile();
            }
            if(file.isFile() && file.exists()){
                InputStreamReader read = new InputStreamReader(new FileInputStream(file));
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                //循环读取数据进行处理
                while((lineTxt = bufferedReader.readLine()) != null){
                	String[] datas = lineTxt.split("\t");
                	usernames.add(datas[0]);
                	passwds.add(datas[1]);
                }
                read.close();
                return true;
            }else{
            	System.out.println("找不到指定的文件");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
	
	//将新添加的用户加入到文件中
	public static void addUser(String userName, String passwd) throws IOException{
		if(!flag){
			flag = readUsers();
		}
		usernames.add(userName);
		passwds.add(passwd);
	
		try {
	        File file=new File(filePath);
	        if(file.isFile() && file.exists()){ //判断文件是否存在
	       	//输出数据到文件
	        FileOutputStream fos = new FileOutputStream(file);
	        	for(int i = 1; i < usernames.size(); i++){
	               	String auser = usernames.get(i) + "\t" + passwds.get(i) + "\r\n";
	               	fos.write(auser.getBytes());
                }
	                fos.close();
            }else{
            	System.out.println("文件查找失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
