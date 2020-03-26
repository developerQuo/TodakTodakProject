package java142.todak.etc.controller;

import java.util.Enumeration;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import java142.todak.common.ChaebunUtils;
import java142.todak.common.FileUploadUtil;
import java142.todak.etc.service.EtcService;
import java142.todak.etc.utils.LoginSession;
import java142.todak.etc.utils.MimeMailSender;
import java142.todak.human.service.HumanService;
import java142.todak.human.vo.ApprVO;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value="/etc")
public class EtcController {
	
	Logger logger = Logger.getLogger(EtcController.class);
	
	@Autowired
	private HumanService humanService;
	
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
				model.addAttribute("hm_empnum",hm_empnum);
				url = "scheduler/selectSchedule";
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
		String url = "../../index";
		
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
	@RequestMapping(value="/insertMember", method = RequestMethod.POST)
	public String registerMember(@ModelAttribute ApprVO param, HttpServletRequest request){
		logger.info("/c 컨트롤러 >>>>>>>>>>");
		String filePath=request.getSession().getServletContext().getRealPath("/upload/human");
	
		boolean flag=false;
		param=humanService.chaebunMemberAppr();
		System.out.println("+++++++"+param.getHmp_empnum());
		String cnum=param.getHmp_empnum();
		cnum=ChaebunUtils.cNum(cnum, "H");
		
		try{
			FileUploadUtil fuu = new FileUploadUtil();
			boolean bFlag = false;
			bFlag = fuu.fileUpload(request, filePath);
			logger.info("bFlag 사진 인서트 :  >>> : " + bFlag );
			
				Enumeration<String> en = fuu.getFileNames();
//				dbFileName="../"+"upload"+"/"+fileName;
				String hmp_picture =  en.nextElement();
				logger.info("picture >>> : " + hmp_picture);
				String test=fuu.getParameter("hmp_picture");
				System.out.println("test>>>>>>>>>>>"+test);
				
				
				String hmp_name=fuu.getParameter("hmp_name");
				String hmp_birth=fuu.getParameter("hmp_birth");
				String hmp_residentnum=fuu.getParameter("hmp_residentnum");
				String hmp_hpnum=fuu.getParameter("hmp_hpnum");
				String hmp_email=fuu.getParameter("hmp_email");
				String detailAddr=fuu.getParameter("cadress");
				String hmp_addr=fuu.getParameter("hmp_addr")+" "+detailAddr;
				String hmp_postcode=fuu.getParameter("hmp_postcode");
				String hmp_depositors=fuu.getParameter("hmp_depositors");
				String hmp_accountnum=fuu.getParameter("hmp_accountnum");
				String hmp_education=fuu.getParameter("hmp_education");
				String hmp_educontents=fuu.getParameter("hmp_educontents");
				String hmp_workexperience=fuu.getParameter("hmp_workexperience");
				String hmp_workcontents=fuu.getParameter("hmp_workcontents");
				String hmp_id=fuu.getParameter("hmp_id");
				String hmp_pw=fuu.getParameter("hmp_pw");

				BCryptPasswordEncoder bcpe = new BCryptPasswordEncoder();
				logger.info(" encoded pass >>> " + bcpe.encode(hmp_pw));
				String encodedPass = bcpe.encode(hmp_pw);
				
				
				param.setHmp_empnum(cnum);
				param.setHmp_name(hmp_name);
				param.setHmp_birth(hmp_birth);
				param.setHmp_residentnum(hmp_residentnum);
				param.setHmp_hpnum(hmp_hpnum);
				param.setHmp_email(hmp_email);
				param.setHmp_addr(hmp_addr);
				param.setHmp_postcode(hmp_postcode);
				param.setHmp_picture(hmp_picture);
				param.setHmp_bank("38");
				param.setHmp_depositors(hmp_depositors);
				param.setHmp_accountnum(hmp_accountnum);
				param.setHmp_education(hmp_education);
				param.setHmp_educontents(hmp_educontents);
				param.setHmp_workexperience(hmp_workexperience);
				param.setHmp_workcontents(hmp_workcontents);
				param.setHmp_id(hmp_id);
				param.setHmp_pw(encodedPass);
				
			
				System.out.println("Hmp_empnum()"+param.getHmp_name());
				System.out.println("Hmp_empnum()"+param.getHmp_birth());
				System.out.println("Hmp_empnum()"+param.getHmp_residentnum());
				System.out.println("Hmp_empnum()"+param.getHmp_hpnum());
				System.out.println("Hmp_empnum()"+param.getHmp_email());
				System.out.println("Hmp_empnum()"+param.getHmp_addr());
				System.out.println("Hmp_empnum()"+param.getHmp_postcode());
				System.out.println("Hmp_empnum()"+param.getHmp_picture());
				System.out.println("Hmp_empnum()"+param.getHmp_bank());
				System.out.println("Hmp_empnum()"+param.getHmp_depositors());
				System.out.println("Hmp_empnum()"+param.getHmp_accountnum());
				System.out.println("Hmp_empnum()"+param.getHmp_education());
				System.out.println("Hmp_empnum()"+param.getHmp_educontents());
				System.out.println("Hmp_empnum()"+param.getHmp_workexperience());
				System.out.println("Hmp_empnum()"+param.getHmp_workcontents());
				
				
				
				
				flag=humanService.insertMemberAppr(param);
			}catch(Exception e){
			System.out.println("에러발생!"+e);
		}
		return "/human/result";
	}
	
	@RequestMapping(value = "/moveSignup", method = RequestMethod.GET)
	public String movePage(){
		logger.info("moveSignup 페이지 이동>>>>>>>>>>");
		
		return "/human/signup";
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
			logger.info("이름: "+hmvo.getHm_name());
			logger.info("이메일 주소:"+hmvo.getHm_email());
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
  			
  			toEmail=hmvo.getHm_email();
  			titleEmail ="토닥토닥 회원가입 인증 메일 입니다.";
  			contentEmail="안녕하세요. 반갑습니다.<br> "+hmvo.getHm_name()+"사원님의 메일 인증 코드는 <br><p><font size='14' color='#ED6B5E'>'<strong>"+AuthenticationKey+"</strong>'</font></p>입니다.<br><br>감사합니다. 행복한 하루 되세요!";
  			
  			String result=AuthenticationKey;
  			model.addAttribute("result",result);
  			
  			emailConfirm = true;
  			url= "/human/emailCheck";
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
				contentEmail += "당신의 아이디는 '" + hmvo2.getHm_id() + "'입니다.";
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
				
				//���� ��ȣ ���
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
//                logger.info(" 사번>>> " + hmvo2.getHm_empnum());
                //새로운 비밀번호 저장
                boolean bool = etcService.setNewPw(hmvo2);

        		logger.info(" bool >>> " + bool);
                if(bool){
    				toEmail = hmvo.getHm_email();
    				titleEmail = "비밀번호 찾기 결과" + titleEmail;
    				contentEmail += "당신의 새로운 비밀번호는'" + AuthenticationKey + "'입니다.";
    				message = "새로운 비밀번호가 전송되었습니다.";
    				checker = "0";
    				emailConfirm = true;
                }else{
    				message = "오류가 발생했습니다. 잠시후 다시 시도하세요";
                }
                
			}else{
				message = "사원번호 또는 비밀번호가 틀렸습니다.";
			}
			
		}

		logger.info(" emailConfirm >>> " + emailConfirm);
		// 메일 보내기
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