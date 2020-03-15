package java142.todak.etc.controller;

import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import java142.todak.etc.service.EtcService;
import java142.todak.etc.utils.LoginSession;
import java142.todak.etc.utils.MimeMailSender;
import java142.todak.human.vo.MemberVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value="/etc")
public class EtcController {
	
	Logger logger = Logger.getLogger(EtcController.class);
	
	@Autowired
	private EtcService etcService;
	
	@RequestMapping(value="/login")
	public String login(@ModelAttribute MemberVO hmvo,
						HttpServletRequest request,
						Model model){
		logger.info("(log) login entered");
		logger.info(" id >>> " + hmvo.getHm_id());
		logger.info(" pass >>> " + hmvo.getHm_pw());
		
		// 암호화
//		BCryptPasswordEncoder bcpe = new BCryptPasswordEncoder();
//		logger.info(" encoded pass >>> " + bcpe.encode(hmvo.getHm_pw()));
//		String encodedPass = bcpe.encode(hmvo.getHm_pw());
//		hmvo.setHm_pw(encodedPass);
		
		List<MemberVO> aList = etcService.login(hmvo);
		int nCnt = aList.size();
		logger.info(" nCnt >>> " + nCnt);
		
		String message = "";
		String url = "../../index";
		LoginSession sManager = LoginSession.getInstance();
		
		if (nCnt == 1){
			MemberVO hmvo2 = aList.get(0);
			String hm_empnum = hmvo2.getHm_empnum();
			if (!sManager.isUsing(hm_empnum)){
				sManager.setSession(request.getSession(), hm_empnum);
				//url = "redirect:/sponsor/selectCharity.td";
				url = "redirect:/sponsor/selectSponsorship.td";
				model.addAttribute("selectFunc", "login");
			}else{
				message = "이미 사용중인 아이디입니다.";
			}
		}else{ 
			message = "아이디 또는 패스워드가 잘못 되었습니다.";
		}

		model.addAttribute("message", message);
		logger.info("(log) login left");
		return url;
	}
	
	@RequestMapping(value="logout")
	public String logout(HttpServletRequest request,
						 Model model){
		logger.info("(log) logout entered");
		
		request.getSession().invalidate();
		String message = "로그아웃 했습니다.";
		model.addAttribute("message", message);
		String url = "redirect:/etc/moveSession.td";
		
		logger.info("(log) logout left");
		return url;
	}
	
	@RequestMapping(value="moveSession")
	public String moveSession(){
		return "commons/bindSession";
	}

	@RequestMapping(value="setMainSession")
	public void setMainSession(HttpServletRequest request, @RequestParam("main") String main){
//		System.out.println(" main IN ETC CONTROLLER >>> " + main);
		LoginSession sManager = (LoginSession)request.getSession().getAttribute("login");
		
		sManager.setMain(main, request.getSession().getId());
	}
	
	@RequestMapping(value="moveId")
	public String moveId(){
		return "etc/idPopup";
	}

	@RequestMapping(value="movePw")
	public String movePw(){
		return "etc/pwPopup";
	}
	

	@RequestMapping(value="emailAuth")
	public String emailAuth(@RequestParam("selectFunc") String selectFunc,
							@ModelAttribute MemberVO hmvo,
							Model model){
		logger.info("(log) emailAuth entered");
		
		logger.info(" selectFunc >>> " + selectFunc);
		boolean emailConfirm = false;
		String url = "etc/popupOK";

		ApplicationContext ctx = new ClassPathXmlApplicationContext( new String[] {"config/applicationContext.xml"});
		MimeMailSender sender = (MimeMailSender) ctx.getBean("mimeMailSender");
		String toEmail = "";
		String fromEmail = "developerQuo@gmail.com";
		String titleEmail = "입니다.";
		String contentEmail = "안녕하세요. \n ";
		String message = "";
		String checker = "1";
		
		// 회원가입
		if(selectFunc.equals("0")){
			
		}
		
		// 아이디
		if(selectFunc.equals("1")){
			logger.info(" id 진입 ");
			
			List<MemberVO> hList = etcService.idEmailAuth(hmvo);
			logger.info(" 길이>>>>>>>>>>" + hList.size());
			if (hList.size() > 0){
				MemberVO hmvo2 = hList.get(0);
				
				toEmail = hmvo2.getHm_email();
				titleEmail = "아이디 찾기 결과" + titleEmail;
				contentEmail += "당신의 아이디는 '" + hmvo2.getHm_id() + "' 입니다.";
				message = "아이디가 전송되었습니다.";
				checker = "0";
				emailConfirm = true;
			}else{
				message = "사원번호가 존재하지 않습니다.";
			}
		}
		
		// 비번찾기
		if(selectFunc.equals("2")){
			
			List<MemberVO> hList = etcService.pwEmailAuth(hmvo);
			logger.info(" 길이>>>>>>>>>>" + hList.size());
			if (hList.size() > 0){
				MemberVO hmvo2 = hList.get(0);
				
				//인증 번호 생성기
                StringBuffer temp =new StringBuffer();
                Random rnd = new Random();
                for(int i=0;i<10;i++)
                {
                    int rIndex = rnd.nextInt(3);
                    switch (rIndex) {
                    case 0:
                        // a-z
                        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
                        break;
                    case 1:
                        // A-Z
                        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
                        break;
                    case 2:
                        // 0-9
                        temp.append((rnd.nextInt(10)));
                        break;
                    }
                }
                String AuthenticationKey = temp.toString();
                hmvo2.setHm_pw(AuthenticationKey);
//                logger.info(" 새 비번 >>> " + hmvo2.getHm_pw());
//                logger.info(" 사번 >>> " + hmvo2.getHm_empnum());
                //새로운 비밀번호 저장
                boolean bool = etcService.setNewPw(hmvo2);

        		logger.info(" bool >>> " + bool);
                if(bool){
    				toEmail = hmvo.getHm_email();
    				titleEmail = "비밀번호 찾기 결과" + titleEmail;
    				contentEmail += "당신의 새로운 비밀번호는 '" + AuthenticationKey + "' 입니다.";
    				message = "새로운 비밀번호가 전송되었습니다.";
    				checker = "0";
    				emailConfirm = true;
                }else{
    				message = "오류가 발생했습니다. 잠시후 다시 시도하세요.";
                }
                
			}else{
				message = "사원번호 또는 비밀번호가 틀렸습니다.";
			}
			
		}

		logger.info(" emailConfirm >>> " + emailConfirm);
		// 메일보내기
		if (emailConfirm){
			try {
				sender.sendMail(toEmail, fromEmail, titleEmail, contentEmail);
			} catch (MessagingException e) {
			 // TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		model.addAttribute("message", message);
		model.addAttribute("checker", checker);
		
		logger.info("(log) emailAuth left");
		return url;
	}
}
