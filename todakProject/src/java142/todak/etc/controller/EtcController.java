package java142.todak.etc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import java142.todak.etc.service.EtcService;
import java142.todak.etc.utils.LoginSession;
import java142.todak.human.vo.MemberVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
