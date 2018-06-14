package org.wsocketchat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.websocket.CloseReason;
import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

/*onOpen – when the connection has been successfully opened
onMessage – when a server sent message has been received
onClose – when the connection has been properly closed
onError – when a communication error has occured and the connection has been severed*/


@ServerEndpoint(value = "/live/{room}", encoders = ChatMessageEncoder.class, decoders = ChatMessageDecoder.class)
public class ChatEndpoint {
	private final Logger log = Logger.getLogger(getClass().getName());
	//notice:not thread-safe
    private static ArrayList<Session> sessionList = new ArrayList<Session>();

	@OnOpen
	public void open(Session session, @PathParam("room")String room) {
        session.getUserProperties().put("room", room);
		log.info("session openend and bound to room: " + room);
		sessionList.add(session);
		//asynchronous communication
		//session.getBasicRemote().sendText("Hello!");
    }
	

	@OnMessage
	public void onMessage(Session session, Message chatMessage) {
		String room = (String) session.getUserProperties().get("room");
        System.out.printf("current Room: " + room +"\n");
        
        System.out.printf(chatMessage.getSender()+"nnnnnnnnnn");
        session.getUserProperties().put("name", chatMessage.getSender());
        String names = "";
        try {
        	
        	int i=0;
	        for(Session s : sessionList){
	        	if(s.isOpen() && room.equals(s.getUserProperties().get("room"))) {
	        		names += (String) s.getUserProperties().get("name") + "|";
	        		i++;
	        	}
	        }
	        chatMessage.setSum(i);
	        chatMessage.setNames(names);
        	
			for (Session s :  sessionList) {
			
				if (s.isOpen() && room.equals(s.getUserProperties().get("room"))) {
				    System.out.printf("match Room: " + s.getUserProperties().get("room") +"\n");
					s.getBasicRemote().sendObject(chatMessage);
				} //session openend and
			}
		} catch (IOException | EncodeException e) {
			log.log(Level.WARNING, "onMessage failed", e);
		}
	}
	
	@OnClose
	public void onClose(Session session, CloseReason reason) { 
		int i = 0;
		String room = (String) session.getUserProperties().get("room");
		for (Session s :  sessionList) {
			if (s.isOpen() && s.equals(session)) {
			    System.out.printf("Close Room: " + s.getUserProperties().get("room") +"\n");
				sessionList.remove(s);
			} //session openend and
			i++;
		}	
		try {
			i=0;
			String names = "";
			wordMessage chatMessage = new wordMessage();
	        for(Session s : sessionList){
	        	if(s.isOpen() && room.equals(s.getUserProperties().get("room"))) {
	        		names += (String) s.getUserProperties().get("name") + "|";
	        		i++;
	        	}
	        }
	        chatMessage.setSum(i);
	        chatMessage.setNames(names);
	        chatMessage.setFilename("");
	        //chatMessage.setFiletype("");
	        chatMessage.setIfNext("");
	        chatMessage.setMessage("");
	        chatMessage.setReceived("");
	        chatMessage.setReceiver("");
	        chatMessage.setSender("");
	        for (Session s :  sessionList) {
				if (s.isOpen() && room.equals(s.getUserProperties().get("room"))) {//给同房间的其他端更新信息
					s.getBasicRemote().sendObject(chatMessage);
				} //session openend and
			}
		} catch (IOException | EncodeException e) {
			log.log(Level.WARNING, "onMessage failed", e);
		}
	}
}