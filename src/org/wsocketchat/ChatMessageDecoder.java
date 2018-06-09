package org.wsocketchat;

import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.json.Json;
import javax.json.JsonObject;
import javax.websocket.DecodeException;
import javax.websocket.Decoder;
import javax.websocket.EndpointConfig;

public class ChatMessageDecoder implements Decoder.Text<ChatMessage> {
	@Override
	public void init(final EndpointConfig config) {
	}

	@Override
	public void destroy() {
	}

	@Override
	public ChatMessage decode(final String textMessage) throws DecodeException {
		ChatMessage chatMessage = new ChatMessage();
		JsonObject obj = Json.createReader(new StringReader(textMessage))
				.readObject();
		chatMessage.setMessage(obj.getString("message"));
		chatMessage.setSender(obj.getString("sender"));
		Date now = new Date(); 
		SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm");
		String nowtime = dateFormat.format(now); 
		chatMessage.setReceived(nowtime);
		chatMessage.setReceiver(obj.getString("receiver"));
		chatMessage.setFilename(obj.getString("filename"));
		chatMessage.setFiletype(obj.getString("filetype"));
		chatMessage.setIfNext(obj.getString("ifNext"));
		return chatMessage;
	}

	@Override
	public boolean willDecode(final String s) {
		return true;
	}
}
