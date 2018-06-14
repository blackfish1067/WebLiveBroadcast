package org.wsocketchat;

public class MessageFactory {
	 public Message getMessage(String fileType){
	      if(fileType.equalsIgnoreCase("1")){
	    	  System.out.printf("aaaa");
	         return new wordMessage();
	      } else if(fileType.equalsIgnoreCase("picture")){
	         return new pictureMessage();
	      } else if(fileType.equalsIgnoreCase("audio")){
	         return new audioMessage();
	      } else if(fileType.equalsIgnoreCase("audio2")){
		         return new audio2Message();
		  }else if(fileType.equalsIgnoreCase("video")){
		         return new videoMessage();
		  }
	      return null;
	   }
}
