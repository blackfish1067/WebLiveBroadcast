package org.wsocketchat;

public class audioMessage implements Message{
	private String message;
	private String sender;
	private String received;
	private int sum;
	private String names;
	private String receiver;
	private String filetype;
	private String filename;
	private String ifNext;

	public final String getMessage() {
		return message;
	}

	public final void setMessage(final String message) {
		this.message = message;
	}

	public final String getSender() {
		return sender;
	}

	public final void setSender(final String sender) {
		this.sender = sender;
	}

	public final String getReceived() {
		return received;
	}

	public final void setReceived(final String received) {
		this.received = received;
	}

	@Override
	public String toString() {
		return "ChatMessage [message=" + message + ", sender=" + sender
				+ ", received=" + received + "sum=" + sum + "names=" + names + ",receiver=" + receiver + "]";
	}

	public int getSum() {
		return sum;
	}

	public void setSum(int sum) {
		this.sum = sum;
	}

	public String getNames() {
		return names;
	}

	public void setNames(String names) {
		this.names = names;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getFiletype() {
		return "audio";
	}

	public void setFiletype() {
		this.filetype = "audio";
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getIfNext() {
		return ifNext;
	}

	public void setIfNext(String ifNext) {
		this.ifNext = ifNext;
	}

}
