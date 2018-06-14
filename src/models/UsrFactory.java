package models;

public class UsrFactory {
	public User getUser(String usrType) {
		if(usrType.equalsIgnoreCase("client"))
			return new clientUser();
		else if(usrType.equalsIgnoreCase("anchor"))
			return new AnchorUser();
		return null;
	}
}
