package java142.todak.etc.utils;

import javax.mail.MessagingException;
import org.springframework.mail.javamail.JavaMailSender;

public abstract class AbstractMailSender {
	 protected JavaMailSender sender;
	 
	 public void setSender(JavaMailSender sender) {
	  this.sender = sender;
	 }
	 
	 public abstract void sendMail( String to, String from,
	      String subject, String text ) throws MessagingException;
	 
}
