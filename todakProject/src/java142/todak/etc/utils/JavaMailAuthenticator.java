package java142.todak.etc.utils;

import java.util.Properties;
import org.springframework.mail.javamail.JavaMailSenderImpl;

public class JavaMailAuthenticator extends JavaMailSenderImpl {
	public JavaMailAuthenticator()
	 {
	  super();
	  Properties props = new Properties();
	  props.put("mail.smtp.starttls.enable", "true");
	  props.put("mail.smtp.auth", "true");
	  this.setJavaMailProperties(props);
	 }
}
