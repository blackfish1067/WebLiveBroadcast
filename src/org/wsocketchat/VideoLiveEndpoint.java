package org.wsocketchat;  
  
import javax.websocket.OnClose;  
import javax.websocket.OnMessage;  
import javax.websocket.OnOpen;  
import javax.websocket.Session;  
import javax.websocket.server.ServerEndpoint;  
import java.io.IOException;  
import java.util.Vector;  
  
/** 
 * Created by Taoyongpan on 2017/10/13. 
 */  
//ָ��һ��URI�ͻ��˿���ͨ�����URI�����ӵ����ǵ�webSocket ����servletmapping  
@ServerEndpoint(value = "/liveServer/{room}")  
public class VideoLiveEndpoint {  
    //��һ���ͻ��˷���onlineServer���ӵ�ʱ�򣬴���һ��OnlineServer��ʵ��  
    private Session session;//��ǰ�ĻỰ���� ͨ��session ������������ͻ�������������Ϣ  
  
    //����һ����̬�ļ������洢���пͻ��˵�ʵ��  
    public static Vector<VideoLiveEndpoint> clients = new Vector<VideoLiveEndpoint>();  
    /** 
     * 
     * @Title: onOpen 
     * @Description: ���ͻ�����������������ӵ�ʱ�򴥷����� 
     * @param session    �趨�ļ� 
     * @return void    �������� 
     * @throws 
     */  
    @OnOpen  
    public void onOpen(Session session){  
        this.session = session;  
        clients.add(this);//����ǰ�ͻ��˼���ͻ����б�  
        System.out.println("���������ӣ���");  
    }  
    @OnClose  
    public void onClose(){  
        clients.remove(this);  
        System.out.println("��һ�����ӣ���");  
    }  
    //���ͻ����������������Ϣ��ʱ�򴥷����¼�  
    @OnMessage  
    public void onMessage(String message,Session session){  
        //Ⱥ����Ϣ �㲥��Ϣ  
        for(VideoLiveEndpoint client : clients){  
            try {  
                //�������ͻ��˷�����Ϣ 
                client.session.getBasicRemote().sendText(message);  
            } catch (IOException e) {  
                // TODO Auto-generated catch block  
                //e.printStackTrace();  
            }  
        }  
    }  
  
}  