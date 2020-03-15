package java142.todak.etc.utils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MimeMailSender extends AbstractMailSender {

	@Override
	public void sendMail(String to, String from, String subject, String text)
			throws MessagingException {
		// TODO Auto-generated method stub
		 MimeMessage msg = sender.createMimeMessage();
		 
		  // true를 세팅함으로써 메일 포맷의 다양화를 지원하겠다는것을 명시적으로 세팅해준다.
		  MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");
		  
		  helper.setTo(to);
		  helper.setFrom(from);
		  helper.setSubject(subject);
		  helper.setText(text);
		 
		  sender.send(msg);
	}

}
