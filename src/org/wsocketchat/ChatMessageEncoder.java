package org.wsocketchat;

import javax.json.Json;
import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;


public class ChatMessageEncoder implements Encoder.Text<Message> {
	@Override
	public void init(final EndpointConfig config) {
	}

	@Override
	public void destroy() {
	}

	@Override
	public String encode(final Message chatMessage) throws EncodeException {
		return Json.createObjectBuilder()
				.add("message", chatMessage.getMessage())
				.add("sender", chatMessage.getSender())
				.add("received", chatMessage.getReceived().toString())
				.add("sum", chatMessage.getSum())
				.add("names", chatMessage.getNames())
				.add("receiver", chatMessage.getReceiver())
				.add("filename", chatMessage.getFilename())
				.add("filetype", chatMessage.getFiletype())
				.add("ifNext", chatMessage.getIfNext())
				.build()
				.toString();
	}
}