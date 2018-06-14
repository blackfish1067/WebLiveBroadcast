package org.wsocketchat;

public interface Message {
	public String getMessage();

	public void setMessage(final String message);

	public String getSender();

	public void setSender(final String sender);

	public String getReceived();

	public void setReceived(final String received);

	@Override
	public String toString();

	public int getSum();

	public void setSum(int sum);

	public String getNames();

	public void setNames(String names);

	public String getReceiver();

	public void setReceiver(String receiver);

	public String getFiletype();
	

	public void setFiletype();

	public String getFilename();

	public void setFilename(String filename);

	public String getIfNext();

	public void setIfNext(String ifNext);
}
