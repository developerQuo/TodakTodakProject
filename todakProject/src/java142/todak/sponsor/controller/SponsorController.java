package java142.todak.sponsor.controller;

import java.util.ArrayList;
import java.util.List;

import java142.todak.common.ChaebunUtils;
import java142.todak.etc.controller.EtcController;
import java142.todak.sponsor.service.SponsorService;
import java142.todak.sponsor.vo.CharityVO;
import java142.todak.sponsor.vo.MemberAccountVO;
import java142.todak.sponsor.vo.MemberCardVO;
import java142.todak.sponsor.vo.MemberVO;
import java142.todak.sponsor.vo.SponsorshipVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value="sponsor")
public class SponsorController {

	public static final String GUBUN_MEMBER = "M";
	public static final String GUBUN_MEMBERCARD = "C";
	public static final String GUBUN_MEMBERACCOUNT = "A";
	public static final String GUBUN_CHARITY = "N";
	Logger logger = Logger.getLogger(EtcController.class);
	
	@Autowired
	private SponsorService sponsorService;
	
	@RequestMapping(value="moveIUCharity")
	public String moveIUCharity(@ModelAttribute CharityVO scvo,
						 Model model){
		List<CharityVO> charityList = null;
		if(!scvo.getSc_num().equals("")){
			charityList = sponsorService.selectCharity(scvo);
		}else{
			charityList = new ArrayList<CharityVO>();
		}
		model.addAttribute("charityList", charityList);
		return "sponsor/iuCharity";
	}

	@RequestMapping(value="moveIUMember")
	public String moveIUCharity(@ModelAttribute MemberVO smvo,
								@ModelAttribute MemberCardVO smcvo,
								@ModelAttribute MemberAccountVO smavo,
						 		Model model){
		List<MemberVO> memberList = null;
		List<MemberCardVO> cardList = null;
		List<MemberAccountVO> accountList = null;
		if(!smvo.getSm_num().equals("")){
			memberList = sponsorService.selectMember(smvo);
			cardList = sponsorService.selectMemberCard(smcvo);
			accountList = sponsorService.selectMemberAccount(smavo);
		}else{
			memberList = new ArrayList<MemberVO>();
			cardList = new ArrayList<MemberCardVO>();
			accountList = new ArrayList<MemberAccountVO>();
		}
		model.addAttribute("memberList", memberList);
		model.addAttribute("cardList", cardList);
		model.addAttribute("accountList", accountList);
		return "sponsor/iuMember";
	}
	
//--------------------------------------------------------------------------------------------------------------------------------------------------		
	@RequestMapping(value="selectMember")
	public String selectMember(@ModelAttribute MemberVO smvo,
						   	   @ModelAttribute MemberCardVO smcvo,
							   @ModelAttribute MemberAccountVO smavo,
							   @ModelAttribute SponsorshipVO ssvo,
							   Model model, 
	 						   @RequestParam("message") String message,
	 						   @RequestParam("selectFunc") String selectFunc){
		logger.info("(log) SponsorController.selectMember entered");
		String url = "sponsor/selectMember";
		String sm_num = smvo.getSm_num();
		smcvo.setSm_num(sm_num);
		smavo.setSm_num(sm_num);
		ssvo.setSm_num(sm_num);
		logger.info(" message >>> " + message);
		logger.info(" sm_num >>> " + smvo.getSm_num());
		logger.info(" smc_num >>> " + smcvo.getSmc_num());
		logger.info(" sma_num >>> " + smavo.getSma_num());
		logger.info(" ss_num >>> " + ssvo.getSs_num());
		List<MemberVO> memberList = sponsorService.selectMember(smvo);
		List<MemberCardVO> cardList = sponsorService.selectMemberCard(smcvo);
		List<MemberAccountVO> accountList = sponsorService.selectMemberAccount(smavo);
//		List<SponsorshipVO> sponsorshipList = sponsorService.selectSponsorship(smvo);
		model.addAttribute("memberList", memberList);
		model.addAttribute("cardList", cardList);
		model.addAttribute("accountList", accountList);
//		model.addAttribute("sponsorshipList", sponsorshipList);
		model.addAttribute("message", message);
		logger.info("memberList >>> " + memberList.size());
		logger.info("cardList >>> " + cardList.size());
		logger.info("accountList >>> " + accountList.size());
//		logger.info("sponsorshipList >>> " + sponsorshipList.size());
		
		if(!smvo.getSm_num().equals("")){
			logger.info(" search!!!!!!!");
			url = "sponsor/searchMember";
		}
		
		logger.info("(log) SponsorController.selectMember left");
		return url;
	}

	@RequestMapping(value="insertMember")
	public String insertMember(@ModelAttribute MemberVO smvo,
						   	   @ModelAttribute MemberCardVO smcvo,
							   @ModelAttribute MemberAccountVO smavo,
						 	   Model model){
		logger.info("(log) SponsorController.insertMember entered");
		String url = "redirect:/sponsor/selectMember.td";
		String message = "등록에 실패했습니다.";
		
		List<MemberVO> memberList = sponsorService.chaebunMember();
		List<MemberCardVO> cardList = sponsorService.chaebunMemberCard();
		List<MemberAccountVO> accountList = sponsorService.chaebunMemberAccount();
		String sm_num = ChaebunUtils.cNum(memberList.get(0).getSm_num(), GUBUN_MEMBER);
		smvo.setSm_num(sm_num);
		smcvo.setSm_num(sm_num);
		smavo.setSm_num(sm_num);
		smcvo.setSmc_num(ChaebunUtils.cNum(cardList.get(0).getSmc_num(), GUBUN_MEMBERCARD));
		smavo.setSma_num(ChaebunUtils.cNum(accountList.get(0).getSma_num(), GUBUN_MEMBERACCOUNT));
		logger.info("smvo.getSm_num() >>> " + smvo.getSm_num());
		logger.info("smcvo.getSmc_num() >>> " + smcvo.getSmc_num());
		logger.info("smcvo.getSm_num() >>> " + smcvo.getSm_num());
		logger.info("smavo.getSma_num() >>> " + smavo.getSma_num());
		logger.info("smavo.getSm_num() >>> " + smavo.getSm_num());
		int memberCnt = sponsorService.insertMember(smvo, smcvo, smavo);
//		int cardCnt = sponsorService.insertMemberCard(smcvo);
//		int accountCnt = sponsorService.insertMemberAccount(smavo);
		logger.info(" memberCnt >>> " + memberCnt);
//		logger.info(" cardCnt >>> " + cardCnt);
//		logger.info(" accountCnt >>> " + accountCnt);
		

		if (memberCnt == 1 ){
			message = "등록되었습니다.";
		}
		model.addAttribute("message", message);
		model.addAttribute("selectFunc", "");
		logger.info("(log) SponsorController.insertMember left");
		return url;
	}

	@RequestMapping(value="updateMember")
	public String updateMember(@ModelAttribute MemberVO smvo,
						   	   @ModelAttribute MemberCardVO smcvo,
							   @ModelAttribute MemberAccountVO smavo,
						 	   Model model){
		logger.info("(log) SponsorController.updateMember entered");
		String url = "redirect:/sponsor/selectMember.td";
		String message = "수정에 실패했습니다.";
		
		int memberCnt = sponsorService.updateMember(smvo, smcvo, smavo);
		logger.info(" memberCnt >>> " + memberCnt);
		
		// 트랜잭션 처리 필요
		if (memberCnt == 1){
			message = "수정되었습니다.";
		}
		model.addAttribute("message", message);
		model.addAttribute("selectFunc", "");
		logger.info("(log) SponsorController.updateMember left");
		return url;
	}
	
	@RequestMapping(value="deleteMember")
	public String deleteMember(@ModelAttribute MemberVO smvo,
						 	   Model model){
		logger.info("(log) SponsorController.deleteMember entered");
		String url = "redirect:/sponsor/selectMember.td";
		String message = "삭제에 실패했습니다.";
		
		int memberCnt = sponsorService.deleteMember(smvo);
		logger.info(" memberCnt >>> " + memberCnt);
		
		// 트랜잭션 처리 필요
		if (memberCnt == 1){
			message = "삭제되었습니다.";
		}
		model.addAttribute("message", message);
		model.addAttribute("selectFunc", "");
		logger.info("(log) SponsorController.deleteMember left");
		return url;
	}
//--------------------------------------------------------------------------------------------------------------------------------------------------	
	@RequestMapping(value="selectCharity")
	public String selectCharity(@ModelAttribute CharityVO scvo,
	 							Model model, 
	 							@RequestParam("message") String message,
	 							@RequestParam("selectFunc") String selectFunc){
		logger.info("(log) SponsorController.selectCharity entered");
		String url = "sponsor/selectCharity";
		logger.info(" message >>> " + message);
		logger.info(" sc_num >>> " + scvo.getSc_num());
		List<CharityVO> charityList = sponsorService.selectCharity(scvo);
		model.addAttribute("charityList", charityList);
		model.addAttribute("message", message);
		logger.info("charityList >>> " + charityList.size());
		
		if(!scvo.getSc_num().equals("")){
			logger.info(" search!!!!!!!");
			url = "sponsor/searchCharity";
		}
		
		logger.info("(log) SponsorController.selectCharity left");
		return url;
	}
	
	@RequestMapping(value="insertCharity")
	public String insertCharity(@ModelAttribute CharityVO scvo,
						 		Model model){
		logger.info("(log) SponsorController.insertCharity entered");
		String url = "redirect:/sponsor/selectCharity.td";
		String message = "등록에 실패했습니다.";
		
		List<CharityVO> charityList = sponsorService.chaebunCharity();
		scvo.setSc_num(ChaebunUtils.cNum(charityList.get(0).getSc_num(), GUBUN_CHARITY));
		int nCnt = sponsorService.insertCharity(scvo);
		logger.info(" nCnt >>> " + nCnt);
		
		if (nCnt == 1){
			message = "등록되었습니다.";
		}
		model.addAttribute("message", message);
		model.addAttribute("selectFunc", "");
		logger.info("(log) SponsorController.insertCharity left");
		return url;
	}
	
	@RequestMapping(value="updateCharity")
	public String updateCharity(@ModelAttribute CharityVO scvo,
								Model model){
		logger.info("(log) SponsorController.updateCharity entered");
		String url = "redirect:/sponsor/selectCharity.td";
		String message = "수정에 실패했습니다.";
		
		logger.info(" sc_num >>> " + scvo.getSc_num());
		int nCnt = sponsorService.updateCharity(scvo);
		logger.info(" nCnt >>> " + nCnt);

		if (nCnt == 1){
			message = "수정되었습니다.";
		}
		model.addAttribute("message", message);
		model.addAttribute("selectFunc", "");
		logger.info("(log) SponsorController.updateCharity left");
		return url;
	}
	
	@RequestMapping(value="deleteCharity")
	public String deleteCharity(@ModelAttribute CharityVO scvo,
								Model model){
		logger.info("(log) SponsorController.deleteCharity entered");
		String url = "redirect:/sponsor/selectCharity.td";
		String message = "삭제에 실패했습니다.";
		
		int nCnt = sponsorService.deleteCharity(scvo);
		logger.info(" nCnt >>> " + nCnt);

		if (nCnt == 1){
			message = "삭제되었습니다.";
		}
		model.addAttribute("message", message);
		model.addAttribute("selectFunc", "");
		logger.info("(log) SponsorController.deleteCharity left");
		return url;
	}
	
	@RequestMapping(value="selectSponsorship")
	public String selectSponsorship(@ModelAttribute MemberVO smvo,
									@ModelAttribute CharityVO scvo,
									Model model, 
		 							@RequestParam("message") String message,
		 							@RequestParam("selectFunc") String selectFunc){
		logger.info("(log) SponsorController.selectSponsorship entered");
		String url = "sponsor/selectSponsorship";
		logger.info(" message >>> " + message);
		logger.info(" sm_num >>> " + smvo.getSm_num());
		logger.info(" sc_num >>> " + scvo.getSc_num());
		List<SponsorshipVO> sponsorshipList = sponsorService.selectSponsorship(smvo, scvo);
		model.addAttribute("sponsorshipList", sponsorshipList);
		model.addAttribute("message", message);
		logger.info("sponsorshipList >>> " + sponsorshipList.size());
		SponsorshipVO ssvo = sponsorshipList.get(0);
		logger.info(" >>> " + ssvo.getSs_num());
		logger.info(" >>> " + ssvo.getSc_num());
		logger.info(" >>> " + ssvo.getSm_num());
		logger.info(" >>> " + ssvo.getSs_amount());
		logger.info(" >>> " + ssvo.getSs_message());
		logger.info(" >>> " + ssvo.getSs_receiptYN());
		logger.info(" >>> " + ssvo.getSs_sponsoreddate());
		
		logger.info("(log) SponsorController.selectSponsorship left");
		return url;
	}
}
