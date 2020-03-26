package java142.todak.ework.controller;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import java142.todak.common.ChaebunUtils;
import java142.todak.common.FileUploadUtil;
import java142.todak.common.VOPrintUtil;
import java142.todak.ework.service.EworkFormService;
import java142.todak.ework.vo.ApprovalVO;
import java142.todak.ework.vo.AuthBoxVO;
import java142.todak.ework.vo.AuthPersonVO;
import java142.todak.ework.vo.AuthVO;
import java142.todak.ework.vo.AuthorizationVO;
import java142.todak.ework.vo.FileVO;
import java142.todak.ework.vo.HolidayVO;
import java142.todak.ework.vo.LineVO;
import java142.todak.ework.vo.ProposalVO;
import java142.todak.human.vo.MemberVO;
import java142.todak.ework.vo.SignStampVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/eworkForm")
public class EworkFormController {
	
	Logger logger = Logger.getLogger(EworkFormController.class);
	
	public final static String PROPOSAL_GUNBUN = "P";
	public final static String APPROVAL_GUNBUN = "D";
	public final static String HOLIDAY_GUNBUN = "H";
	public final static String LINE_GUNBUN = "L";
	public final static String AUTH_GUNBUN = "A";
	public final static String AUTHPERSON_GUNBUN = "S";
	public final static String AUTHBOX_GUNBUN = "B";
	
	private static final String UPLOAD_ABSTRACT_PATH = "C://Users//Nayoung//Desktop//todak//todakProject//WebContent//upload//ework//auth";
	private static final String UPLOAD_RELATIVE_PATH = "upload//ework//auth";
	
	private String el_num = "";
	
	private String line = "";
	private String first_applicant = "";
	private String second_applicant = "";
	private String third_applicant = "";
	

	@Autowired
	private EworkFormService eworkFormService;
	
	//트랜잭션
	@Autowired
	private PlatformTransactionManager ptm;
	DefaultTransactionDefinition dtd = null;
	TransactionStatus ts = null;
	
	@RequestMapping("/moveMainPage")
	public String moveMainPage() {
		return "ework/mainPage";
	}
	
	@RequestMapping("/moveInsertProposal") 
	public String moveInsertProposal(Model model) {
		//logger.info("(EworkFormController)public String moveInsertProposal(Model model) 시작 >>> ");
		
		String ep_num = "";
		List<ProposalVO> list = null;
		ProposalVO pvo_Ep_num = null;
		
		list = eworkFormService.chaebunProposal();
		pvo_Ep_num = list.get(0);
		ep_num = pvo_Ep_num.getEp_num();
		//logger.info("  ep_num : " + ep_num);
		ep_num = ChaebunUtils.cNum(ep_num, PROPOSAL_GUNBUN);
		//logger.info("  ep_num : " + ep_num);
		
		ProposalVO pvo = new ProposalVO();
		pvo.setEp_num(ep_num);
		
		model.addAttribute("pvo", pvo);
		
		//---------------------------------------
		
		List<AuthVO> list_auth = null;
		list_auth = eworkFormService.chaebunAuth();
		//logger.info("  list_auth : " + list_auth);
		
		AuthVO auvo_Ea_num = null;
		auvo_Ea_num = list_auth.get(0);
		//logger.info("  auvo_Ea_num : " + auvo_Ea_num);
		
		String ea_num = "";
		ea_num = auvo_Ea_num.getEa_num();
		//logger.info("  ea_num : " + ea_num);
		
		ea_num = ChaebunUtils.cNum(ea_num, AUTH_GUNBUN);
		//logger.info("  ea_num : " + ea_num);
		
		AuthVO auvo = new AuthVO();
		//logger.info("  auvo : " + auvo);
		auvo.setEa_num(ea_num);
		
		model.addAttribute("auvo", auvo);
		
		//logger.info("(EworkFormController)public String moveInsertProposal(Model model) 끝 >>> : " + model);
		return "ework/insertProposal";
	}
	
	@RequestMapping("/moveInsertApproval")
	public String moveInsertApproval(Model model) {
		//logger.info("(EworkFormController)public String moveInsertApproval(Model model) 시작 >>> ");
		
		List<ApprovalVO> list_approval = null;
		String eap_num = "";
		
		list_approval = eworkFormService.chaebunApproval();
		//logger.info("  list_approval : " + list_approval);
		
		ApprovalVO avo_Eap_num = null;
		avo_Eap_num = list_approval.get(0);
		//logger.info("  avo : " + avo_Eap_num);
		
		eap_num = avo_Eap_num.getEap_num();
		//logger.info("  eap_num : " + eap_num);
		
		eap_num = ChaebunUtils.cNum(eap_num, APPROVAL_GUNBUN);
		
		ApprovalVO avo = new ApprovalVO();
		avo.setEap_num(eap_num);
		
		model.addAttribute("avo", avo);
		
		//------------------------------------------
		
		List<AuthVO> list_auth = null;
		list_auth = eworkFormService.chaebunAuth();
		//logger.info("  list_auth : " + list_auth);
		
		AuthVO auvo_Ea_num = null;
		auvo_Ea_num = list_auth.get(0);
		//logger.info("  auvo_Ea_num : " + auvo_Ea_num);
		
		String ea_num = "";
		ea_num = auvo_Ea_num.getEa_num();
		//logger.info("  ea_num : " + ea_num);
		
		ea_num = ChaebunUtils.cNum(ea_num, AUTH_GUNBUN);
		//logger.info("  ea_num : " + ea_num);
		
		AuthVO auvo = new AuthVO();
		//logger.info("  auvo : " + auvo);
		auvo.setEa_num(ea_num);
		
		model.addAttribute("auvo", auvo);
		
		//logger.info("(EworkFormController)public String moveInsertApproval(Model model) 끝 >>> : " + model);
		return "ework/insertApproval";
	}
	
	@RequestMapping("/saveApproval")
	public String saveApproval(HttpServletRequest request) {
		//logger.info("(EworkFormController)public String saveApproval(HttpServletRequest request) 시작 >>> ");
		
		boolean result = false;
		List<ApprovalVO> list_Eap_num = null;
		String eap_num = "";
		boolean bFlag = false;
		ApprovalVO _avo = null;
		
		//트랜잭션 세팅
		dtd = new DefaultTransactionDefinition();
		dtd.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		ts = ptm.getTransaction(dtd);
		
		list_Eap_num = eworkFormService.chaebunApproval();
		//logger.info("  list_Eap_num : " + list_Eap_num);
		ApprovalVO avo_Eap_num = list_Eap_num.get(0);
		//logger.info("  avo_Eap_num : " + avo_Eap_num);
		eap_num = avo_Eap_num.getEap_num();
		//logger.info("  eap_num : " + eap_num);
		eap_num = ChaebunUtils.cNum(eap_num, APPROVAL_GUNBUN);
		//logger.info("  eap_num : " + eap_num);
		
		//avo.setEap_num(eap_num);
		
		FileUploadUtil fuu = new FileUploadUtil();
		//logger.info("  fuu : " + fuu);
		
		bFlag = fuu.fileUpload(request, UPLOAD_ABSTRACT_PATH);
		//logger.info("  bFlag : " + bFlag);
		
		if(bFlag) {
			//logger.info("  if(bFlag) 진입 >>> " );
			
			//String eap_num = fuu.getParameter("eap_num");
			String ef_num = fuu.getParameter("ef_num");
			//logger.info("  ef_num : " + ef_num);
			String ea_num = fuu.getParameter("ea_num");
			//logger.info("  ea_num : " + ea_num);
			String eap_title = fuu.getParameter("eap_title");
			//logger.info("  eap_title : " + eap_title);
			String hm_empnum = fuu.getParameter("hm_empnum");
			//logger.info("  hm_empnum : " + hm_empnum);
			String eap_writer = fuu.getParameter("eap_writer");
			//logger.info("  eap_writer : " + eap_writer);
			String hm_position = fuu.getParameter("hm_position");
			//logger.info("  hm_position : " + hm_position);
			String eap_startdate = fuu.getParameter("eap_startdate");
			//logger.info("  eap_startdate : " + eap_startdate);
			String eap_enddate = fuu.getParameter("eap_enddate");
			//logger.info("  eap_enddate : " + eap_enddate);
			String eap_group = fuu.getParameter("eap_group");
			//logger.info("  eap_group : " + eap_group);
			
			Enumeration<String> files = fuu.getFileNames();
			//logger.info("  files : " + files);
			String file = files.nextElement();
			//logger.info("  file : " + file);
			
			String fileDirectory = UPLOAD_RELATIVE_PATH + "//" + file;
			//logger.info("  fileDirectory : " + fileDirectory);
			
			_avo = new ApprovalVO();
			//logger.info("  _avo : " + _avo);
			_avo.setEap_num(eap_num);
			_avo.setEf_num(ef_num);
			_avo.setEa_num(ea_num);
			_avo.setEap_title(eap_title);
			_avo.setHm_empnum(hm_empnum);
			_avo.setEap_writer(eap_writer);
			_avo.setHm_position(hm_position);
			_avo.setEap_startdate(eap_startdate);
			_avo.setEap_enddate(eap_enddate);
			_avo.setEap_group(eap_group);
			_avo.setEap_filedir(fileDirectory);
		}
			
			//url = "/ework/moveSelectProposal.td"; //성공
			//url = "/ework/insertApproval"; //실패
			
			try {
				
				result = eworkFormService.insertApproval(_avo);
				//logger.info("  result : " + result);
				
				if(!result) {
					//logger.info("  if(!result)  진입 >>> ");
					//logger.info("  실패");
				}
				ptm.commit(ts);
				
				if(result) {
					return "redirect:/ework/moveSelectProposal.td";
				}
				
			} catch(Exception e) {
				//logger.info("에러 : " + e);
				ptm.rollback(ts);
			}
		
		//logger.info("(EworkFormController)public String saveApproval(@ModelAttribute ApprovalVO avo) 끝 >>> ");
		return "#";
	}
	
	@RequestMapping("/moveInsertHoliday") 
	public String moveInsertHoliday(Model model) {
		//logger.info("(EworkFormController)public String moveInsertHoliday() 시작 >>> ");
		
		List<HolidayVO> list_Eh_num = null;
		list_Eh_num = eworkFormService.chaebunHoliday();
		//logger.info("  list_Eh_num : " + list_Eh_num);
		HolidayVO hvo_Eh_num = list_Eh_num.get(0);
		//logger.info("  hvo_Eh_num : " + hvo_Eh_num);
		String eh_num = hvo_Eh_num.getEh_num();
		//logger.info("  eh_num : " + eh_num);
		eh_num = ChaebunUtils.cNum(eh_num, HOLIDAY_GUNBUN);
		//logger.info("  eh_num : " + eh_num);
		
		HolidayVO hvo = new HolidayVO();
		//logger.info("  hvo : " + hvo);
		hvo.setEh_num(eh_num);
		
		model.addAttribute("hvo", hvo);
		
		//-------------------------------------------
		
		List<AuthVO> list_auth = null;
		list_auth = eworkFormService.chaebunAuth();
		//logger.info("  list_auth : " + list_auth);
		
		AuthVO auvo_Ea_num = null;
		auvo_Ea_num = list_auth.get(0);
		//logger.info("  auvo_Ea_num : " + auvo_Ea_num);
		
		String ea_num = "";
		ea_num = auvo_Ea_num.getEa_num();
		//logger.info("  ea_num : " + ea_num);
		
		ea_num = ChaebunUtils.cNum(ea_num, AUTH_GUNBUN);
		//logger.info("  ea_num : " + ea_num);
		
		AuthVO auvo = new AuthVO();
		//logger.info("  auvo : " + auvo);
		auvo.setEa_num(ea_num);
		
		model.addAttribute("auvo", auvo);
		
		//logger.info("(EworkFormController)public String moveInsertHoliday() 끝 >>> ");
		return "ework/insertHoliday";
	}
	
	@RequestMapping("/moveDraftResult") 
	public String moveDraftResult() {
		//logger.info("(EworkFormController)public String moveSelectAuthorization() 시작 >>> ");
		//logger.info("(EworkFormController)public String moveSelectAuthorization() 끝 >>> ");
		return "ework/draftResult";
	}
	
	@RequestMapping("/moveDownloadApprovalForm")
	public String moveDownloadApprovalForm() {
		//logger.info("(EworkFormController)public String moveDownloadApprovalForm() 시작 >>> ");
		//logger.info("(EworkFormController)public String moveDownloadApprovalForm() 끝 >>> ");
		return "ework/downloadApprovalForm";
	} //end of moveDownloadApprovalForm method
	
	@RequestMapping("/saveProposal")
	public String saveProposal(@ModelAttribute ProposalVO pvo) {
		//logger.info("(EworkFormController)public String saveProposal(@ModelAttribute ProposalVO pvo) 시작 >>> ");
		//logger.info("  매개변수 pvo : " + pvo);
		VOPrintUtil.printVO(pvo);
		
		//트랜잭션 세팅
		dtd = new DefaultTransactionDefinition();
		dtd.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		ts = ptm.getTransaction(dtd);
		
		//url = "/ework/moveSelectProposal.td";
		boolean result = false;
		
		try {
		result = eworkFormService.insertProposal(pvo);
		//logger.info("  result : " + result);
		
		if(!result) {
			//logger.info("  if(!result) 진입 >>> ");
			//logger.info("실패");		
		}
		ptm.commit(ts);
		
		if(result) {
			return "redirect:/ework/moveSelectProposal.td";
		}
		} catch(Exception e) {
			//logger.info("에러 : " + e);
			ptm.rollback(ts);
		}
		
		
		//logger.info("(EworkFormController)public String saveProposal(@ModelAttribute ProposalVO pvo) 끝 >>> ");
		return "#";
	} 
	
	@RequestMapping("/downloadDocument")
	public String downloadDocument(@ModelAttribute FileVO fvo, Model model) throws Exception{
		//logger.info("(EworkFormController)public String downloadDocument(@ModelAttribute FileVO fvo, Model model) 시작 >>> ");
		//logger.info("  매개변수 fvo : " + fvo);
		//logger.info("  getFile() : " + fvo.getFile());
		
		String file = fvo.getFile();
		//logger.info("  file : " + file);
		
		model.addAttribute("fileName", file);
		model.addAttribute("FilePath", UPLOAD_ABSTRACT_PATH);
		
		//logger.info("(EworkFormController)public String downloadDocument(@ModelAttribute FileVO fvo, Model model) 끝 >>> ");
		return "ework/downloadForm";
	}
	
	@RequestMapping(value="/insertApproval", method=RequestMethod.POST)
	public String insertApproval(HttpServletRequest request, Model model) {
		//logger.info("(EworkFormController)public String insertApproval(@ModelAttribute ApprovalVO avo) 시작 >>> ");
		
		List<ApprovalVO> list_Eap_num = null;
		String eap_num = "";
		boolean file_flag = false;
		boolean bFlag = false;
		ApprovalVO _avo = null;
		
		String ef_num = "";
		String ea_num = "";
		String eap_title = "";
		String hm_empnum = "";
		String eap_writer = "";
		String hm_position = "";
		String eap_startdate = "";
		String eap_enddate = "";
		String eap_group = "";
		String fileDirectory = "";
		
		try {
			
			//트랜잭션 세팅
			dtd = new DefaultTransactionDefinition();
			dtd.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
			ts = ptm.getTransaction(dtd);
			
			list_Eap_num = eworkFormService.chaebunApproval();
			//logger.info("  list_Eap_num : " + list_Eap_num);
			ApprovalVO avo_Eap_num = list_Eap_num.get(0);
			//logger.info("  avo_Eap_num : " + avo_Eap_num);
			eap_num = avo_Eap_num.getEap_num();
			//logger.info("  eap_num : " + eap_num);
			eap_num = ChaebunUtils.cNum(eap_num, APPROVAL_GUNBUN);
			//logger.info("  eap_num : " + eap_num);
			
			//avo.setEap_num(eap_num);
			
			FileUploadUtil fuu = new FileUploadUtil();
			//logger.info("  fuu : " + fuu);
			
			file_flag = fuu.fileUpload(request, UPLOAD_ABSTRACT_PATH);
			//logger.info("  file_flag : " + file_flag);
			
			if(file_flag) {
				//logger.info("  if(file_flag) 진입 >>> " );
				
				//String eap_num = fuu.getParameter("eap_num");
				ef_num = fuu.getParameter("ef_num");
				//logger.info("  ef_num : " + ef_num);
				ea_num = fuu.getParameter("ea_num");
				//logger.info("  ea_num : " + ea_num);
				eap_title = fuu.getParameter("eap_title");
				//logger.info("  eap_title : " + eap_title);
				hm_empnum = fuu.getParameter("hm_empnum");
				//logger.info("  hm_empnum : " + hm_empnum);
				eap_writer = fuu.getParameter("eap_writer");
				//logger.info("  eap_writer : " + eap_writer);
				hm_position = fuu.getParameter("hm_position");
				//logger.info("  hm_position : " + hm_position);
				eap_startdate = fuu.getParameter("eap_startdate");
				//logger.info("  eap_startdate : " + eap_startdate);
				eap_enddate = fuu.getParameter("eap_enddate");
				//logger.info("  eap_enddate : " + eap_enddate);
				eap_group = fuu.getParameter("eap_group");
				//logger.info("  eap_group : " + eap_group);
				
				Enumeration<String> files = fuu.getFileNames();
				//logger.info("  files : " + files);
				String file = files.nextElement();
				//logger.info("  file : " + file);
				
				fileDirectory = UPLOAD_RELATIVE_PATH + "//"+ file;
				//logger.info("  fileDirectory : " + fileDirectory);
			}
			
				// 1)
				MemberVO _mvo = null;
				_mvo = new MemberVO();
				//logger.info("  _mvo : " + _mvo);
				_mvo.setHm_empnum(first_applicant);
				List<MemberVO> list_person = null;
				list_person = eworkFormService.selectPerson(_mvo);
				
				MemberVO mvo_person = list_person.get(0);
				//logger.info("  mvo_person : " + mvo_person);
				
				AuthVO _auvo = null;
				_auvo = new AuthVO();
				//logger.info("  _auvo : " + _auvo);
				
				_auvo.setEa_num(ea_num);
				_auvo.setHm_empnum(hm_empnum);
				_auvo.setEa_position(mvo_person.getHm_position());
				_auvo.setEa_presentnum(first_applicant);
				
				bFlag = eworkFormService.insertAuth(_auvo);
				//logger.info("  (insertAuth)bFlag : " + bFlag);
				
				if(!bFlag) {
					//logger.info("  if(!bFlag) 진입 >>> ");
					//logger.info("  실패");
				}
				
				// 2)
				_avo = new ApprovalVO();
				//logger.info("  _avo : " + _avo);
				_avo.setEap_num(eap_num);
				_avo.setEf_num(ef_num);
				_avo.setEa_num(ea_num);
				_avo.setEap_title(eap_title);
				_avo.setHm_empnum(hm_empnum);
				_avo.setEap_writer(eap_writer);
				_avo.setHm_position(hm_position);
				_avo.setEap_startdate(eap_startdate);
				_avo.setEap_enddate(eap_enddate);
				_avo.setEap_group(eap_group);
				_avo.setEap_filedir(fileDirectory);
				
				//url = "/ework/moveSelectProposal.td"; //성공
				//url = "/ework/insertApproval"; //실패
				
				bFlag = eworkFormService.insertApproval(_avo);
				//logger.info("  (insertApproval)bFlag : " + bFlag);
				
				if(!bFlag) {
					//logger.info("  if(!result)  진입 >>> ");
					//logger.info("  실패");
				}
				
				// 3)
				LineVO _lvo = null;
				_lvo = new LineVO();
				//logger.info("  _lvo : " + _lvo);
				_lvo.setEa_num(ea_num);
				_lvo.setEl_num(el_num);
				
				bFlag = eworkFormService.updateLine(_lvo);
				//logger.info("  (updateLine)bFlag : " + bFlag);
				
				if(!bFlag) {
					//logger.info("  if(!bFlag) 진입 >>> ");
					//logger.info("  실패");
				}
				
				// 4)
				//채번
				List<AuthPersonVO> list_authperson = eworkFormService.chaebunAuthPerson();
				//logger.info("  list_authperson : " + list_authperson);
				AuthPersonVO apvo_Eai_num = list_authperson.get(0);
				//logger.info("  apvo_Eai_num : " + apvo_Eai_num);
				String eai_num = apvo_Eai_num.getEai_num();
				//logger.info("  eai_num : " + eai_num);
				eai_num = ChaebunUtils.cNum(eai_num, AUTHPERSON_GUNBUN);
				//logger.info("  eai_num : " + eai_num);
						
				//싸인스탬프 이미지 갖고오기
				SignStampVO _ssvo = null;
				_ssvo = new SignStampVO();
				//logger.info("  _ssvo : " + _ssvo);
				_ssvo.setHm_empnum(hm_empnum);
				
				List<SignStampVO> list_signstamp = eworkFormService.selectSignStamp(_ssvo);
				//logger.info("  list_signstamp : " + list_signstamp);
				
				SignStampVO ssvo = list_signstamp.get(0);
				//logger.info("  ssvo : " + ssvo);
				String es_filedir = ssvo.getEs_filedir();
				
				//
				AuthPersonVO _apvo = new AuthPersonVO();
				//logger.info("  _apvo : " + _apvo);
				_apvo.setEai_num(eai_num); // 채번
				_apvo.setEa_num(ea_num);
				_apvo.setEai_recentnum(hm_empnum);
				_apvo.setEai_position(hm_position);
				_apvo.setEai_auth(null);
				_apvo.setEai_filedir(es_filedir); //서명도장
				_apvo.setEai_substituteYN("N"); //기안할 때는 대결자가 생기지 않음
				_apvo.setEai_substitutenum(null); //기안할 때는 대결자가 생기지 않음
				_apvo.setEai_sequence("0"); //기안자니까 첫번쨰
				
				bFlag = eworkFormService.insertAuthPerson(_apvo);
				//logger.info("  (insertAuthPerson)bFlag : " + bFlag);
				
				if(!bFlag) {
					//logger.info("  if(!bFlag) 진입 >>> ");
					//logger.info("  실패");
				}
				
				// 5)AuthBox
				//채번
				List<AuthBoxVO> list_authbox = eworkFormService.chaebunAuthBox();
				//logger.info("  list_authbox : " + list_authbox);
				AuthBoxVO abvo_Eab_num = list_authbox.get(0);
				//logger.info("  abvo_Eab_num : " + abvo_Eab_num);
				String eab_num = abvo_Eab_num.getEab_num();
				//logger.info("  eab_num : " + eab_num);
				eab_num = ChaebunUtils.cNum(eab_num, AUTHBOX_GUNBUN);
				//logger.info("  eab_num : " + eab_num);
				
				AuthBoxVO _abvo = new AuthBoxVO();
				//logger.info("  _abvo : " + _abvo);
				_abvo.setEab_num(eab_num);
				_abvo.setEa_num(ea_num);
				_abvo.setEab_writer(eap_writer);
				_abvo.setEab_title(eap_title);
				_abvo.setEab_startdate(eap_startdate);
				_abvo.setEab_enddate(eap_enddate);
				_abvo.setEab_group(eap_group);
				
				//쿼리
				bFlag = eworkFormService.insertAuthBox(_abvo);
				//logger.info("  (insertAuthBox)bFlag : " + bFlag);
				
				if(!bFlag) {
					//logger.info("  if(!bFlag) 진입 >>> ");
					//logger.info("  실패");
				}
				
				ptm.commit(ts);
				
				if(bFlag) {
					//logger.info("  if(bFlag) 진입 >>> ");
					
					model.addAttribute("bFlag", bFlag);
					return "ework/draftResult";
				}
				
			} catch(Exception e) {
				//logger.info("에러 : " + e);
				ptm.rollback(ts);
			}
		
		//logger.info("(EworkFormController)public String insertApproval(@ModelAttribute ApprovalVO avo) 끝 >>> ");
		return "#";
	}
	
	@RequestMapping(value="/moveSetLine")
	public String moveSetLine() {
		return "ework/setLine";
	}
	
	@RequestMapping(value="/moveSetHolidayLine")
	public String moveSetHolidayLine() {
		return "ework/setHolidayLine";
	}
	
	@RequestMapping(value="/moveSetApprovalLine")
	public String moveSetApprovalLine() {
		return "ework/setApprovalLine";
	}
	
	@RequestMapping(value="/moveSetProposalLine")
	public String moveSetProposalLine() {
		return "ework/setProposalLine";
	}
	
	@RequestMapping("/selectTeamMember")
	public String selectTeamMember(@ModelAttribute MemberVO mvo, Model model) {
		//logger.info("(EworkFormController)public String selectTeamMember(@ModelAttribute MemberVO mvo, Model model) 시작 >>> ");
		//logger.info("  매개변수 mvo : " + mvo);
		//logger.info("  mvo.getHm_deptnum() : " + mvo.getHm_deptnum());
		
		List<MemberVO> list = null;
		
		list = eworkFormService.selectTeamMember(mvo);
		//logger.info("  list : " + list);
		
		model.addAttribute("list", list);
		//logger.info("  model : " + model);
		
		//logger.info("(EworkFormController)public String selectTeamMember(@ModelAttribute MemberVO mvo, Model model) 끝 >>> ");
		return "ework/selectTeamMember";
	}
	
	@RequestMapping(value="/insertLine", method=RequestMethod.POST)
	public String insertLine(@ModelAttribute LineVO lvo, Model model) {
		//logger.info("(EworkFormController)public String insertLine(@ModelAttribute LineVO lvo) 시작 >>> ");
		//logger.info("  매개변수 lvo : " + lvo);
		
		String result = "";
		
		//트랜잭션 세팅
		dtd = new DefaultTransactionDefinition();
		dtd.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		ts = ptm.getTransaction(dtd);
		
		List<LineVO> list_chaebun = null;
		list_chaebun = eworkFormService.chaebunLine();
		//logger.info("  list_chaebun : " + list_chaebun);
		
		LineVO lvo_chaebun = null;
		lvo_chaebun = list_chaebun.get(0);
		//logger.info("  lvo_chaebun : " + lvo_chaebun);
		
		el_num = lvo_chaebun.getEl_num();
		//logger.info("  lvo_chaebun : " + lvo_chaebun);
		el_num = ChaebunUtils.cNum(el_num, LINE_GUNBUN);
		//logger.info("  el_num : " + el_num);
		
		lvo.setEl_num(el_num);
		
		line = lvo.getEl_line();
		//logger.info("  line : " + line);
		String[] array_line = null;
		array_line = line.split("-");
		
		if(array_line.length == 2) {
			//logger.info("  if(array_line.length == 2) 진입 >>> ");
			
			first_applicant = array_line[1];
			//logger.info("  first_applicant : " + first_applicant);
			
		} else if(array_line.length == 4) {
			//logger.info("  else if(array_line.length == 4) 진입 >>> ");
			
			first_applicant = array_line[1];
			second_applicant = array_line[2];
			third_applicant = array_line[3];
			//logger.info("  first_applicant : " + first_applicant);
			//logger.info("  second_applicant : " + second_applicant);
			//logger.info("  third_applicant : " + third_applicant);
		}
		
		//url = "/ework/setLineResult.td";
		
		try{
			boolean bFlag = false;
			bFlag = eworkFormService.insertLine(lvo);
			//logger.info("  bFlag : " + bFlag);
			
			if(!bFlag) {
				//logger.info("  if(!bFlag) 진입 >>> ");
				
				result = "등록에 문제가 있어 완료하지 못하였습니다.";
				
			} else {
				//logger.info("  if(!bFlag)-else 진입 >>> ");
				
				result = "등록이 완료되었습니다.";
				model.addAttribute("list_chaebun", list_chaebun);	
			}
			ptm.commit(ts);
			
			model.addAttribute("result", result);
			//logger.info("  model : " + model);
			
			if(bFlag) {
				//logger.info("  if(bFlag) 진입 >>> ");
				
				model.addAttribute("bFlag", bFlag);
				return "ework/setLineResult";
			}
		} catch(Exception e) {
			//logger.info("  에러 : " + e);
			ptm.rollback(ts);
		}
		
		//logger.info("(EworkFormController)public String insertLine(@ModelAttribute LineVO lvo) 끝 >>> ");
		return "#";
	}
	
	@RequestMapping("/selectPerson")
	public String selectPerson(@ModelAttribute MemberVO mvo, Model model) {
		//logger.info("(EworkFormController)public String selectPerson(@ModelAttribute MemberVO mvo, Model model) 시작 >>> ");
		//logger.info("  매개변수 mvo : " + mvo);
		//logger.info("  mvo.getHm_empnum() : " + mvo.getHm_empnum());
		
		List<MemberVO> list = null;
		list = eworkFormService.selectPerson(mvo);
		//logger.info("  list : " + list);
		
		if(list!=null) {
			//logger.info("  if(list!=null) 진입 >>> ");
			
			model.addAttribute("list", list);
			//logger.info("  model : " + model);
			
		}
		
		//logger.info("(EworkFormController)public String selectPerson(@ModelAttribute MemberVO mvo, Model model) 끝 >>> ");
		return "ework/selectUserInfo";
	}
	
	@RequestMapping(value="/insertProposal", method=RequestMethod.POST)
	public String insertProposal(@ModelAttribute ProposalVO pvo, Model model) {
		//logger.info("(EworkFormController)public String insertProposal(@ModelAttribute ProposalVO pvo) 시작 >>> ");
		//logger.info("  매개변수 pvo : " + pvo);
		VOPrintUtil.printVO(pvo);
		
		//리턴 플래그
		boolean bFlag = false;
		
		//트랜잭션 세팅
		dtd = new DefaultTransactionDefinition();
		dtd.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		ts = ptm.getTransaction(dtd);
		//url = "/ework/moveSelectProposal.td";
		try {
			
			// 1) 
			MemberVO _mvo = null;
			_mvo = new MemberVO();
			//logger.info("  _mvo : " + _mvo);
			_mvo.setHm_empnum(first_applicant);
			List<MemberVO> list_person = null;
			list_person = eworkFormService.selectPerson(_mvo);
			
			MemberVO mvo_person = list_person.get(0);
			//logger.info("  mvo_person : " + mvo_person);
			
			AuthVO _auvo = null;
			_auvo = new AuthVO();
			//logger.info("  _auvo : " + _auvo);
			
			_auvo.setEa_num(pvo.getEa_num());
			_auvo.setHm_empnum(pvo.getHm_empnum());
			_auvo.setEa_position(mvo_person.getHm_position());
			_auvo.setEa_presentnum(first_applicant);
			
			bFlag = eworkFormService.insertAuth(_auvo);
			//logger.info("  (insertAuth)bFlag : " + bFlag);
			
			if(!bFlag) {
				//logger.info("  if(!bFlag) 진입 >>> ");
				//logger.info("  실패");
			}
			
			// 2)
			bFlag = eworkFormService.insertProposal(pvo);
			//logger.info("  (insertProposal)bFlag : " + bFlag);
			
			if(!bFlag) {
				//logger.info("  if(!bFlag) 진입 >>> ");
				//logger.info("  실패");
			}
			
			// 3)
			LineVO _lvo = null;
			_lvo = new LineVO();
			//logger.info("  _lvo : " + _lvo);
			_lvo.setEa_num(pvo.getEa_num());
			_lvo.setEl_num(el_num);
			
			bFlag = eworkFormService.updateLine(_lvo);
			//logger.info("  (updateLine)bFlag : " + bFlag);
			
			if(!bFlag) {
				//logger.info("  if(!bFlag) 진입 >>> ");
				//logger.info("  실패");
			}
			
			// 4)
			//채번
			List<AuthPersonVO> list_authperson = eworkFormService.chaebunAuthPerson();
			//logger.info("  list_authperson : " + list_authperson);
			AuthPersonVO apvo_Eai_num = list_authperson.get(0);
			//logger.info("  apvo_Eai_num : " + apvo_Eai_num);
			String eai_num = apvo_Eai_num.getEai_num();
			//logger.info("  eai_num : " + eai_num);
			eai_num = ChaebunUtils.cNum(eai_num, AUTHPERSON_GUNBUN);
			//logger.info("  eai_num : " + eai_num);
					
			//싸인스탬프 이미지 갖고오기
			SignStampVO _ssvo = null;
			_ssvo = new SignStampVO();
			//logger.info("  _ssvo : " + _ssvo);
			_ssvo.setHm_empnum(pvo.getHm_empnum());
			
			List<SignStampVO> list_signstamp = eworkFormService.selectSignStamp(_ssvo);
			//logger.info("  list_signstamp : " + list_signstamp);
			
			SignStampVO ssvo = list_signstamp.get(0);
			//logger.info("  ssvo : " + ssvo);
			String es_filedir = ssvo.getEs_filedir();
			
			//
			AuthPersonVO _apvo = new AuthPersonVO();
			//logger.info("  _apvo : " + _apvo);
			_apvo.setEai_num(eai_num); // 채번
			_apvo.setEa_num(pvo.getEa_num());
			_apvo.setEai_recentnum(pvo.getHm_empnum());
			_apvo.setEai_position(pvo.getHm_position());
			_apvo.setEai_auth(null);
			_apvo.setEai_filedir(es_filedir); //서명도장
			_apvo.setEai_substituteYN("N"); //기안할 때는 대결자가 생기지 않음
			_apvo.setEai_substitutenum(null); //기안할 때는 대결자가 생기지 않음
			_apvo.setEai_sequence("0"); //기안자니까 첫번쨰
			
			bFlag = eworkFormService.insertAuthPerson(_apvo);
			//logger.info("  (insertAuthPerson)bFlag : " + bFlag);
			
			if(!bFlag) {
				//logger.info("  if(!bFlag) 진입 >>> ");
				//logger.info("  실패");
			}
		
			// 5)AuthBox
			//채번
			List<AuthBoxVO> list_authbox = eworkFormService.chaebunAuthBox();
			//logger.info("  list_authbox : " + list_authbox);
			AuthBoxVO abvo_Eab_num = list_authbox.get(0);
			//logger.info("  abvo_Eab_num : " + abvo_Eab_num);
			String eab_num = abvo_Eab_num.getEab_num();
			//logger.info("  eab_num : " + eab_num);
			eab_num = ChaebunUtils.cNum(eab_num, AUTHBOX_GUNBUN);
			//logger.info("  eab_num : " + eab_num);
			
			AuthBoxVO _abvo = new AuthBoxVO();
			//logger.info("  _abvo : " + _abvo);
			_abvo.setEab_num(eab_num);
			_abvo.setEa_num(pvo.getEa_num());
			_abvo.setEab_writer(pvo.getEp_writer());
			_abvo.setEab_title(pvo.getEp_title());
			_abvo.setEab_startdate(pvo.getEp_startdate());
			_abvo.setEab_enddate(pvo.getEp_enddate());
			_abvo.setEab_group(pvo.getEp_group());
			
			//쿼리
			bFlag = eworkFormService.insertAuthBox(_abvo);
			//logger.info("  (insertAuthBox)bFlag : " + bFlag);
			
			if(!bFlag) {
				//logger.info("  if(!bFlag) 진입 >>> ");
				//logger.info("  실패");
			}
		
			ptm.commit(ts);
			
			if(bFlag) {
				//logger.info("  if(bFlag) 진입 >>> ");
				
				model.addAttribute("bFlag", bFlag);
				return "ework/draftResult";
			}
			
		} catch(Exception e) {
			//logger.info("  에러 : " + e);
			ptm.rollback(ts);
		}
		
		//logger.info("(EworkFormController)public String insertProposal(@ModelAttribute ProposalVO pvo) 끝 >>> ");
		return "#";
	}
	
	@RequestMapping(value="/insertHoliday", method=RequestMethod.POST)
	public String insertHoliday(@ModelAttribute HolidayVO hvo, Model model) {
		//logger.info("(EworkFormController)public String insertHoliday(@ModelAttribute HolidayVO hvo) 시작 >>> ");
		//logger.info("  매개변수 hvo : " + hvo);
		//logger.info("  " + hvo.getEa_num());
		
		//리턴 플래그
		boolean bFlag = false;
				
		//트랜잭션 세팅
		dtd = new DefaultTransactionDefinition();
		dtd.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		ts = ptm.getTransaction(dtd);
		
		try {
			
			//1) 결재 테이블 INSERT
			//채번
			MemberVO _mvo = null;
			_mvo = new MemberVO();
			//logger.info("  _mvo : " + _mvo);
			_mvo.setHm_empnum(first_applicant);
			List<MemberVO> list_person = null;
			list_person = eworkFormService.selectPerson(_mvo); //다음 결재자의 정보를 가져옴
			
			MemberVO mvo_person = list_person.get(0);
			//logger.info("  mvo_person : " + mvo_person);
			
			AuthVO _auvo = null;
			_auvo = new AuthVO();
			//logger.info("  _auvo : " + _auvo);
			
			_auvo.setEa_num(hvo.getEa_num());
			_auvo.setHm_empnum(hvo.getHm_empnum());
			_auvo.setEa_position(mvo_person.getHm_position());
			_auvo.setEa_presentnum(first_applicant);
			
			bFlag = eworkFormService.insertAuth(_auvo);
			//logger.info("  (insertAuth)bFlag : " + bFlag);
			
			if(!bFlag) {
				//logger.info("  if(!bFlag) 진입 >>> ");
				//logger.info("  실패");
			}
			
			// 2) 폼에서 입력한 내용 INSERT
			bFlag = eworkFormService.insertHoliday(hvo);
			//logger.info("  (insertHoliday)bFlag : " + bFlag);
			
			if(!bFlag) {
				//logger.info("  if(!bFlag) 진입 >>> ");
				//logger.info("  실패");
			}
			
			// 3) 라인 테이블 업데이트
			LineVO _lvo = null;
			_lvo = new LineVO();
			//logger.info("  _lvo : " + _lvo);
			_lvo.setEa_num(hvo.getEa_num());
			_lvo.setEl_num(el_num);
			
			bFlag = eworkFormService.updateLine(_lvo);
			//logger.info("  (updateLine)bFlag : " + bFlag);
			
			if(!bFlag) {
				//logger.info("  if(!bFlag) 진입 >>> ");
				//logger.info("  실패");
			}
			
			// 4) 결재자정보 테이블 INSERT
			//결재자정보 테이블 채번
			List<AuthPersonVO> list_authperson = eworkFormService.chaebunAuthPerson();
			//logger.info("  list_authperson : " + list_authperson);
			AuthPersonVO apvo_Eai_num = list_authperson.get(0);
			//logger.info("  apvo_Eai_num : " + apvo_Eai_num);
			String eai_num = apvo_Eai_num.getEai_num();
			//logger.info("  eai_num : " + eai_num);
			eai_num = ChaebunUtils.cNum(eai_num, AUTHPERSON_GUNBUN);
			//logger.info("  eai_num : " + eai_num);
					
			//싸인스탬프 이미지 갖고오기
			SignStampVO _ssvo = null;
			_ssvo = new SignStampVO();
			//logger.info("  _ssvo : " + _ssvo);
			_ssvo.setHm_empnum(hvo.getHm_empnum());
			
			List<SignStampVO> list_signstamp = eworkFormService.selectSignStamp(_ssvo);
			//logger.info("  list_signstamp : " + list_signstamp);
			
			SignStampVO ssvo = list_signstamp.get(0);
			//logger.info("  ssvo : " + ssvo);
			String es_filedir = ssvo.getEs_filedir();
			
			//결재자정보 테이블 insert
			AuthPersonVO _apvo = new AuthPersonVO();
			//logger.info("  _apvo : " + _apvo);
			_apvo.setEai_num(eai_num); // 채번
			_apvo.setEa_num(hvo.getEa_num());
			_apvo.setEai_recentnum(hvo.getHm_empnum());
			_apvo.setEai_position(hvo.getHm_position());
			_apvo.setEai_auth(null);
			_apvo.setEai_filedir(es_filedir); //서명도장 이미지
			_apvo.setEai_substituteYN("N"); //기안할 때는 대결자가 생기지 않음
			_apvo.setEai_substitutenum(null); //기안할 때는 대결자가 생기지 않음
			_apvo.setEai_sequence("0"); //기안자니까 첫번쨰
			
			bFlag = eworkFormService.insertAuthPerson(_apvo);
			//logger.info("  (insertAuthPerson)bFlag : " + bFlag);
			
			if(!bFlag) {
				//logger.info("  if(!bFlag) 진입 >>> ");
				//logger.info("  실패");
			}
			
			// 5)결재함 테이블 INSERT
			//채번
			List<AuthBoxVO> list_authbox = eworkFormService.chaebunAuthBox();
			//logger.info("  list_authbox : " + list_authbox);
			AuthBoxVO abvo_Eab_num = list_authbox.get(0);
			//logger.info("  abvo_Eab_num : " + abvo_Eab_num);
			String eab_num = abvo_Eab_num.getEab_num();
			//logger.info("  eab_num : " + eab_num);
			eab_num = ChaebunUtils.cNum(eab_num, AUTHBOX_GUNBUN);
			//logger.info("  eab_num : " + eab_num);
			
			AuthBoxVO _abvo = new AuthBoxVO();
			//logger.info("  _abvo : " + _abvo);
			_abvo.setEab_num(eab_num);
			_abvo.setEa_num(hvo.getEa_num());
			_abvo.setEab_writer(hvo.getEh_writer());
			_abvo.setEab_title(hvo.getEh_title());
			_abvo.setEab_startdate(hvo.getEh_startdate());
			_abvo.setEab_enddate(hvo.getEh_enddate());
			_abvo.setEab_group(hvo.getEh_group());
						
			//쿼리
			bFlag = eworkFormService.insertAuthBox(_abvo);
			//logger.info("  (insertAuthBox)bFlag : " + bFlag);
			
			if(!bFlag) {
				//logger.info("  if(!bFlag) 진입 >>> ");
				//logger.info("  실패");
			}
					
			ptm.commit(ts);
			
			if(bFlag) {
				//logger.info("  if(bFlag) 진입 >>> ");
				
				model.addAttribute("bFlag", bFlag);
				return "ework/draftResult";
			}
			
			
		} catch(Exception e) {
			//logger.info("  에러 : " + e);
			ptm.rollback(ts);
		}
		
		//logger.info("(EworkFormController)public String insertHoliday(@ModelAttribute HolidayVO hvo) 끝 >>> ");
		return "#";
	}
	
	@RequestMapping(value="/selectSignStamp", method=RequestMethod.POST)
	public String selectSignStamp(AuthorizationVO authvo, Model model) {
		//logger.info("public String selectSignStamp(AuthorizationVO authvo) 시작 >>> ");
		//logger.info("  매개변수 authvo : " + authvo.getHm_empnum());
		
		SignStampVO _ssvo = null;
		_ssvo = new SignStampVO();
		_ssvo.setHm_empnum(authvo.getHm_empnum());
		
		List<SignStampVO> list_sign = null;
		list_sign = eworkFormService.selectSignStamp(_ssvo);
		//logger.info("  list_sign : " + list_sign);
		
		model.addAttribute("list_sign", list_sign);
		
		//logger.info("public String selectSignStamp(AuthorizationVO authvo) 끝 >>> ");
		return "ework/selectSignStamp";
	} //end of selectSignStamp method
	
} //end of class
