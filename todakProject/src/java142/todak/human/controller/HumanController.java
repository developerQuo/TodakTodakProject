package java142.todak.human.controller;

import java.util.List;


import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java142.todak.common.ChaebunUtils;
import java142.todak.common.Paging;
import java142.todak.etc.utils.LoginSession;
import java142.todak.human.service.HumanService;
import java142.todak.human.vo.ApprVO;
import java142.todak.human.vo.ApptVO;
import java142.todak.human.vo.CommVO;
import java142.todak.human.vo.MemberVO;
import java142.todak.human.vo.StatusVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="/human")
	public class HumanController {
		Logger logger = Logger.getLogger(HumanController.class);
		
		@Autowired
		private HumanService humanService;
		
	@RequestMapping(value="/selectAppr")//회원 가입 대기자 명단 조회	
	public String  selectMemberAppr(@ModelAttribute ApprVO avo,Model model,HttpServletRequest request)	{
		//logger.info("selectApptr 진입");
		int totalCnt=0;
		////////////////////////////////////////////////////////////////////////////
		String cPage=request.getParameter("curPage");
		String pageCtrl=request.getParameter("pageCtrl");
		
		//System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"+cPage);
		//System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"+pageCtrl);
		
		
		Paging.setPage(avo,cPage,pageCtrl);
		
		//System.out.println("1"+avo.getCurPage());
		//System.out.println("2"+avo.getGroupSize());
		//System.out.println("3"+avo.getTotalCount());
		//System.out.println("4"+avo.getPageSize());
		
		
		List<ApprVO> apprList=humanService.selectAppr(avo);
		if(apprList.size()>0){
			totalCnt=apprList.get(0).getTotalCount();
			avo.setTotalCount(totalCnt);
		}
		model.addAttribute("apprList",apprList);
		model.addAttribute("avo",avo);
		return "/human/selectAppr";
	
	}
	@RequestMapping(value="/approval")//회원 가입 대기 목록중 승인할 대상 선택후 선택한 대상 조회해서 팝업으로 띄우기 처리
	public String confirmMemberAppr(@ModelAttribute ApprVO avo,Model model,HttpServletRequest request){
		
		avo=humanService.selectApprMem(avo);
		
		model.addAttribute("approvalMember",avo);
		return "/human/signupApproval";
	}
	@RequestMapping(value="/apprResult")//회원가입 승인,거부 처리
	public String resultMemberAppr(@ModelAttribute MemberVO mvo,Model model,HttpServletRequest request){
		boolean insertFlag=false;
		boolean apprFlag=false;
		String flag=request.getParameter("flag");
		String team=mvo.getHm_teamnum();
		String picture=request.getParameter("hm_picture");
		String hmp_empnum=request.getParameter("hmp_empnum");
		//System.out.println("선택한 사원의 사번 >>>>> "+hmp_empnum);
		ApprVO avo=new ApprVO();
		avo.setHmp_empnum(hmp_empnum);
		
		String Chaenum=null;
		mvo.setHm_picture(picture);
		String dept=mvo.getHm_deptnum();
		dept=dept+team;
		mvo.setHm_deptnum(dept);
		
		Chaenum=humanService.chaebunMember();
		Chaenum=ChaebunUtils.cNum(Chaenum, "H");
		mvo.setHm_empnum(Chaenum);
		if(flag.equals("Y")){
			insertFlag=humanService.insertMember(mvo);
		}
		if(insertFlag){
			apprFlag=humanService.acceptedMemberAppr(avo);
		}
		if(flag.equals("N")){
			apprFlag=humanService.refusedMemberAppr(avo);
		}
		
	
		
		return "/human/result";
	}
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/select")//사원 현황 조회
	public String selectMember(@ModelAttribute MemberVO mvo,Model model,HttpServletRequest request){
		int totalCnt=0;
		int curCnt=0;
		LoginSession sManager = LoginSession.getInstance();
		
		//logger.info("slelct 진입");
		String cPage=request.getParameter("curPage");
		String pageCtrl=request.getParameter("pageCtrl");

		//logger.info("views->controller"+cPage);
		
		//logger.info("search = "+mvo.getSearch());
		//logger.info("keyword= "+mvo.getKeyword());
		if(mvo.getSearch()==null){
			String key=request.getParameter("key");
			mvo.setKeyword(key);
		}
		if(mvo.getSearch()==null){
			String ser=request.getParameter("ser");
			mvo.setSearch(ser);
		}
		Paging.setPage(mvo,cPage,pageCtrl);
		
		
		//logger.info("total컬럼>>>>>"+mvo.getTotalCount());
		
		StatusVO svo=new StatusVO();
		svo=humanService.selectTotal();
		curCnt=sManager.getUserCount();
		svo.setHs_current(curCnt+"");
		
		List<MemberVO> memberList=humanService.selectMember(mvo);
		totalCnt=memberList.get(0).getTotalCount();
		mvo.setTotalCount(totalCnt);
		model.addAttribute("svo",svo);
		model.addAttribute("memberList",memberList);
		model.addAttribute("hvo",mvo);
		
		return "/human/personnelStatus";
	}
	@RequestMapping(value="/apptSelect")//인사발령 사원조횝
	public String selectPersonAppt(@ModelAttribute MemberVO mvo,Model model,HttpServletRequest request){
		//logger.info("apptSelect 진입");
		//페이징처리 시작
		String cPage=request.getParameter("curPage");
		String pageCtrl=request.getParameter("pageCtrl");
		int totalCnt=0;
		//logger.info("views->controller"+cPage);
		
		//logger.info("search = "+mvo.getSearch());
		//logger.info("keyword= "+mvo.getKeyword());
		if(mvo.getSearch()==null){
			String key=request.getParameter("key");
			mvo.setKeyword(key);
		}
		if(mvo.getSearch()==null){
			String ser=request.getParameter("ser");
			mvo.setSearch(ser);
		}
		Paging.setPage(mvo,cPage,pageCtrl);
		
		
		
		//logger.info("total컬럼>>>>>"+mvo.getTotalCount());
		//
		List<MemberVO> apptList=humanService.selectPersonAppt(mvo);
		totalCnt=apptList.get(0).getTotalCount();
		mvo.setTotalCount(totalCnt);
		model.addAttribute("apptList",apptList);
		model.addAttribute("mvo",mvo);
		return "/human/selectApptMem";
	}
	@RequestMapping(value="/apptRecord")
	public String apptRecordSelect(Model model,HttpSession session,HttpServletRequest request){
		LoginSession sManager = LoginSession.getInstance();
		//logger.info("/apptRecord 진입");
		
		String cPage=request.getParameter("curPage");
		String pageCtrl=request.getParameter("pageCtrl");
		
		ApptVO apvo=new ApptVO();
		
		Paging.setPage(apvo,cPage,pageCtrl);
		//logger.info("1"+apvo.getCurPage());
		//logger.info("1"+apvo.getGroupSize());
		//logger.info("1"+apvo.getPageSize());
		//logger.info("1"+apvo.getTotalCount());
		
		String hm_empnum=sManager.getUserID(session.getId());
		apvo.setHpa_empnum(hm_empnum);
		List<ApptVO> apptList=humanService.apptRecordSelect(apvo);
		if(apptList.size()!=0){
		int totalCnt=apptList.get(0).getTotalCount();
		apvo.setTotalCount(totalCnt);
		}
		//logger.info("2"+apvo.getCurPage());
		//logger.info("2"+apvo.getGroupSize());
		//logger.info("2"+apvo.getPageSize());
		//logger.info("2"+apvo.getTotalCount());
	
		model.addAttribute("apvo",apvo);
		model.addAttribute("apptList",apptList);
		
		return "/human/ApptRecord";
	}
	////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/apptAllselect")
	public String apptRecordSelectAll(@ModelAttribute ApptVO apvo, Model model,HttpSession session,HttpServletRequest request){
		
		//logger.info("/apptAllselect 진입");
		
		String cPage=request.getParameter("curPage");
		String pageCtrl=request.getParameter("pageCtrl");
		
		Paging.setPage(apvo,cPage,pageCtrl);
		if(apvo.getSearch()==null){
			String key=request.getParameter("key");
			apvo.setKeyword(key);
		}
		if(apvo.getSearch()==null){
			String ser=request.getParameter("ser");
			apvo.setSearch(ser);
		}
		//System.out.println("dddddd"+apvo.getKeyword());
		//System.out.println("dddddd"+apvo.getSearch());
		List<ApptVO> apptList=humanService.apptRecordAll(apvo);
		if(apptList.size()!=0){
		int totalCnt=apptList.get(0).getTotalCount();
		apvo.setTotalCount(totalCnt);
		}
	
		model.addAttribute("apvo",apvo);
		model.addAttribute("apptList",apptList);
		return "/human/apptRecordAll";
	}
	
	@RequestMapping(value="/appointment")
	public String apptMember(@ModelAttribute MemberVO mvo,Model model){
		mvo=humanService.memberInfo(mvo);
		model.addAttribute("mvo",mvo);
		return "/human/apptMember";
	}
	@RequestMapping(value="/updateAppt")
	public String updateMember(@ModelAttribute ApptVO apvo,Model model,HttpSession session){
		int totalCnt=0;
		LoginSession sManager = LoginSession.getInstance();
		//logger.info("/updateAppt 진입");
		//logger.info("ApptVO apvo로 넘어온 사원번호"+apvo.getHpa_empnum());
		String cPage=null;//이부분이 null로 되어있어서 승진 등록을 한상태에서 항상 현재페이지가 아니라 1페이로 돌아가게 되어있음 추후 수정 하자
		String pageCtrl=null;//
		String team=apvo.getHpa_ateam();
		String dept=apvo.getHpa_adept();
		String position=apvo.getHpa_aposition();
		String duty=apvo.getHpa_aduty();
		String ChaeNo=null;
		boolean flag=false;
		
		//logger.info("1"+team);
		//logger.info("1"+dept);
		//logger.info("1"+position);
		//logger.info("1"+duty);
		
		if(team.equals("67")){
			team=apvo.getHpa_bteam();
		}
		if(dept.equals("67")){
			dept=apvo.getHpa_bdept();
		}
		if(position.equals("67")){
			position=apvo.getHpa_bposition();
		}
		if(duty.equals("67")){
			duty=apvo.getHpa_bduty();
		}
		if(position.equals("74")){
			position=apvo.getHpa_bposition();
		}
		if(duty.equals("74")){
			duty=apvo.getHpa_bduty();
		}
		//logger.info("2"+team);
		//logger.info("2"+dept);
		//logger.info("2"+position);
		//logger.info("2"+duty);
		MemberVO mvo=new MemberVO();
		if(!apvo.getHpa_appointment().equals("74")){
			mvo.setHm_empnum(apvo.getHpa_empnum());
			mvo.setHm_position(position);
			mvo.setHm_duty(duty);
			mvo.setHm_teamnum(team);
			if(!team.equals("73")){
				mvo.setHm_deptnum(dept+team);
			}
			if(team.equals("73")){
				mvo.setHm_deptnum(dept);
			}
			flag=humanService.updateMember(mvo);
			if(flag){
				ChaeNo=humanService.chaebunApptRecord();
				ChaeNo=ChaebunUtils.cNum(ChaeNo, "T");
				apvo.setHpa_tablenum(ChaeNo);
				humanService.insertApptRecord(apvo);
			}
		}
		if(apvo.getHpa_appointment().equals("74")){
			mvo.setHm_empnum(apvo.getHpa_empnum());
			flag=humanService.updateResignation(mvo);
			if(flag){
				ChaeNo=humanService.chaebunApptRecord();
				ChaeNo=ChaebunUtils.cNum(ChaeNo, "T");
				apvo.setHpa_tablenum(ChaeNo);
				humanService.insertApptRecord(apvo);
			}
		}
		String hm_empnum=sManager.getUserID(session.getId());//세션 불러와서 로그인한 아이디의 사번 불러옴
		mvo.setHm_empnum(hm_empnum);
		Paging.setPage(mvo,cPage,pageCtrl);
		//logger.info("세션으로 불러온 ID의 사번>>>>>>"+hm_empnum);
		
		
		//logger.info("total컬럼>>>>>"+mvo.getTotalCount());
		//
		List<MemberVO> apptList=humanService.selectPersonAppt(mvo);
		totalCnt=apptList.get(0).getTotalCount();
		mvo.setTotalCount(totalCnt);
		model.addAttribute("apptList",apptList);
		model.addAttribute("mvo",mvo);
		return "/human/result";
	}
	@RequestMapping(value="/reference")//인사 정보조회
	public String referenceMember(@ModelAttribute MemberVO mvo,Model model,HttpServletRequest request,HttpSession session){
		//logger.info("/reference 진입");
		LoginSession sManager = LoginSession.getInstance();
		
		
		if(mvo.getHm_empnum()==null){
		String hm_empnum=sManager.getUserID(session.getId());//세션 불러와서 로그인한 아이디의 사번 불러옴
		//logger.info("세션으로 불러온 ID의 사번>>>>>>"+hm_empnum);
		mvo.setHm_empnum(hm_empnum);
		}
		mvo=humanService.memberInfo(mvo);
		model.addAttribute("Info",mvo);
		
		return "/human/memberInfo";
	}
	@ResponseBody
	@RequestMapping(value="/deptAuthority")//부서 조회 권한 확인
	public boolean authorityCheck(@ModelAttribute MemberVO mvo,HttpSession session){
		//logger.info("/deptAuthority 진입");
		boolean result=false;
	
		LoginSession sManager = LoginSession.getInstance();
		String hm_empnum=sManager.getUserID(session.getId());//세션 불러와서 로그인한 아이디의 사번 불러옴
		//logger.info("세션으로 불러온 ID의 사번>>>>>>"+hm_empnum);
		mvo.setHm_empnum(hm_empnum);	
		mvo=humanService.selectPosition(mvo);
		if(mvo.getHm_duty()==null){
			mvo.setHm_duty("");
		}
		if(mvo.getHm_duty().equals("19")||mvo.getHm_duty().equals("98")){
			result=true;
		}
		//System.out.println("duty"+mvo.getHm_duty());
		//logger.info("result>>>>>>>"+result);
		return result;
	}
	@ResponseBody
	@RequestMapping(value="idCheckCtr")
	public boolean idCheck(@ModelAttribute MemberVO mvo,HttpServletRequest request){
		boolean result=false;
		String hmp_id=request.getParameter("id");
			//System.out.println("아이디 확인"+hmp_id);
			mvo.setHm_id(hmp_id);
		result=humanService.idCheck(mvo);	
		return result;
	}
	@ResponseBody
	@RequestMapping(value="/Authority")//회원가입 승인,인사발령  권한 조회
	public boolean ApprMemAuthority(@ModelAttribute MemberVO mvo,HttpSession session){
		//logger.info("/Authority 진입");
		boolean result=false;
		LoginSession sManager = LoginSession.getInstance();
		String hm_empnum=sManager.getUserID(session.getId());//세션 불러와서 로그인한 아이디의 사번 불러옴
		//logger.info("세션으로 불러온 ID의 사번>>>>>>"+hm_empnum);
		mvo.setHm_empnum(hm_empnum);	
		mvo=humanService.selectPosition(mvo);
		if(mvo.getHm_deptnum().equals("0004")){
			result=true;
		}
		//System.out.println("결과값"+result);
		return result;
	}
	///////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/deptReference")//부서 인사정보 조회
	public String deptReference(@ModelAttribute MemberVO mvo,Model model,HttpServletRequest request,HttpSession session){
		//logger.info("/deptReference 진입");
		
		int totalCnt=0;
		String keyW=mvo.getKeyword();
		String serC=mvo.getSearch();
		
		LoginSession sManager = LoginSession.getInstance();
		String hm_empnum=sManager.getUserID(session.getId());//세션 불러와서 로그인한 아이디의 사번 불러옴
		//logger.info("세션으로 불러온 ID의 사번>>>>>>"+hm_empnum);
		List<MemberVO> memberList=null;
		mvo.setHm_empnum(hm_empnum);
		mvo=humanService.selectPosition(mvo);//VO에 부서번호 담음.
		mvo.setKeyword(keyW);
		mvo.setSearch(serC);
		String cPage=request.getParameter("curPage");
		String pageCtrl=request.getParameter("pageCtrl");
		
		
		//logger.info("search = "+mvo.getSearch());
		//logger.info("keyword= "+mvo.getKeyword());
		if(mvo.getSearch()==null){
			String key=request.getParameter("key");
			mvo.setKeyword(key);
		}
		if(mvo.getSearch()==null){
			String ser=request.getParameter("ser");
			mvo.setSearch(ser);
		}
		Paging.setPage(mvo,cPage,pageCtrl);
		//System.out.println(mvo.getCurPage()+"++++++++++++++++++++++++++++++++");
		
		//logger.info("total컬럼>>>>>"+mvo.getTotalCount());



		
		
		
		if(mvo.getHm_duty().equals("19")){
			memberList=humanService.selectDeptMem(mvo);//VO에 부서번호 담음.
			totalCnt=memberList.get(0).getTotalCount();
		}
		if(mvo.getHm_duty().equals("98")){
			memberList=humanService.selectAllMem(mvo);//VO에 부서번호 담음.
			totalCnt=memberList.get(0).getTotalCount();
		}
		mvo.setTotalCount(totalCnt);
		model.addAttribute("mvo",mvo);
		model.addAttribute("memberList",memberList);
		return "/human/deptMemInfo";
	}
	
	
	@RequestMapping(value="/commuteRecord")//개인 출퇴근 시간 기록 조회
	public String selectCommute(@ModelAttribute CommVO cvo,Model model,HttpSession session,HttpServletRequest request){
		//logger.info("/commuteRecord 진입");
		
		String cPage=request.getParameter("curPage");
		String pageCtrl=request.getParameter("pageCtrl");
		//logger.info("curPage"+cPage);
		//logger.info("pageCtrl"+pageCtrl);
		
		LoginSession sManager = LoginSession.getInstance();
		String hm_empnum=sManager.getUserID(session.getId());//세션 불러와서 로그인한 아이디의 사번 불러옴
		//logger.info("세션으로 불러온 ID의 사번>>>>>>"+hm_empnum);
		
	
		String startDate=request.getParameter("startday");
		String endDate=request.getParameter("endday");

		
		if(startDate!=null&&startDate.length()>0){
			cvo.setStartdate(startDate);
			cvo.setEnddate(endDate);
		}
		
		
		//logger.info("조회 시작일 >>>>"+startDate);
		//logger.info("조회 종료일>>>"+endDate);

	
		
		Paging.setPage(cvo,cPage,pageCtrl);
		cvo.setHm_empnum(hm_empnum);
	
		List<CommVO> comList=humanService.selectCommute(cvo);
		if(comList.size()!=0){
			cvo.setTotalCount(comList.get(0).getTotalCount());
		}
		
		model.addAttribute("comList",comList);
		model.addAttribute("cvo",cvo);
		return "/human/comRecord";
	}
	@RequestMapping(value="/selectAllcommRecord")
	public String selectAllcommRecord(@ModelAttribute MemberVO mvo,Model model,HttpServletRequest request){
		
		int totalCnt=0;
		
		//logger.info("selectAllcommRecord 진입");
		String cPage=request.getParameter("curPage");
		String pageCtrl=request.getParameter("pageCtrl");
		
		//logger.info("views->controller"+cPage);
		
		//logger.info("search = "+mvo.getSearch());
		//logger.info("keyword= "+mvo.getKeyword());
		if(mvo.getSearch()==null){
			String key=request.getParameter("key");
			mvo.setKeyword(key);
		}
		if(mvo.getSearch()==null){
			String ser=request.getParameter("ser");
			mvo.setSearch(ser);
		}
		Paging.setPage(mvo,cPage,pageCtrl);
		
		
		//logger.info("total컬럼>>>>>"+mvo.getTotalCount());
		
	
		
		List<MemberVO> memberList=humanService.selectMember(mvo);
		totalCnt=memberList.get(0).getTotalCount();
		mvo.setTotalCount(totalCnt);
		model.addAttribute("memberList",memberList);
		model.addAttribute("hvo",mvo);
	
		
		return "/human/comRecordAll";
	}
	@RequestMapping(value="/commuteALlRecord")
	public String selectAllCommute(@ModelAttribute CommVO cvo,Model model,HttpSession session,HttpServletRequest request){
		String empnum=request.getParameter("hm_empnum");
		String cPage=request.getParameter("curPage");
		String pageCtrl=request.getParameter("pageCtrl");
		
		
	
		//logger.info("curPage"+cPage);
		//logger.info("pageCtrl"+pageCtrl);
		
		String startDate=request.getParameter("startday");
		String endDate=request.getParameter("endday");
		
		if(startDate!=null&&startDate.length()>0){
			cvo.setStartdate(startDate);
			cvo.setEnddate(endDate);
		}
		
		
		//logger.info("조회 시작일 >>>>"+startDate);
		//logger.info("조회 종료일>>>"+endDate);

	
		
		Paging.setPage(cvo,cPage,pageCtrl);
		cvo.setHm_empnum(empnum);
		if(cvo.getHm_empnum()==null){
			String empnum_page=request.getParameter("ser");
			cvo.setHm_empnum(empnum_page);
			
		}
		
		
		List<CommVO> comList=humanService.selectCommute(cvo);
		
		//System.out.println("값확인"+comList.get(0).getHc_comnum());
		
		if(comList.size()!=0){
			cvo.setTotalCount(comList.get(0).getTotalCount());
		}
		
		model.addAttribute("comList",comList);
		model.addAttribute("cvo",cvo);
		return "/human/selectRecordAll";
	}
	@RequestMapping(value="/changeComm")
	public String changeCommute(@ModelAttribute CommVO cvo,Model model,HttpSession session,HttpServletRequest request){
		//logger.info("넘겨밭은 getHc_comnum 값 확인"+cvo.getHc_comnum());
		String hm_empnum = request.getParameter("hm_empnum");
		
		model.addAttribute("hm_empnum",hm_empnum);
		model.addAttribute("comnum",cvo.getHc_comnum());
		return "/human/chageCommType";
	}
	
	@RequestMapping(value="/changeCommUpdate")
	public String changeCommuteUpdate(@ModelAttribute CommVO cvo,Model model,HttpSession session,HttpServletRequest request){
		//logger.info("/changeCommUpdate 진입 ");
		//logger.info("cvo.getHc_comnum() >>>> "+cvo.getHc_comnum());
		//logger.info("cvo.getHc_tanda("+cvo.getHc_tanda());
		String hm_empnum = request.getParameter("hm_empnum");
		cvo.setHm_empnum(hm_empnum);
		
		List<CommVO> selectLastHour = humanService.selectLastHour(cvo);
		
		String lasthour = selectLastHour.get(0).getHc_lasthour();
		String totalhour = selectLastHour.get(0).getHc_totalhour();
		String extraworking = selectLastHour.get(0).getHc_extraworking();
		cvo.setHc_lasthour(lasthour);
		cvo.setHc_totalhour(totalhour);
		cvo.setHc_extraworking(extraworking);
		
		boolean bFlag = false;
		
		bFlag = humanService.insertExtrawork(cvo);
			
		boolean flag=false;
		boolean updateFlag=false;
		flag=humanService.changeCommuteUpdate(cvo);
		
		int iLasthour = (int)Double.parseDouble(lasthour);
		int iExtraworking = (int)Double.parseDouble(extraworking);
		int iTotalHour = (int)Double.parseDouble(totalhour);
		int useVacation  = 0;
	
		if(cvo.getHc_tanda().equals("72")){ //휴가
			useVacation = iLasthour - 480;
			//logger.info(">>>>>>>>>>>>>>>>" + iLasthour + " : " + iExtraworking + " : " + useVacation );
			if(iLasthour > 0 ){
				//logger.info("111111111111111111111111111");
				if(useVacation >= 0){ 
					//logger.info("2222222222222222222222222222222");
					iLasthour = useVacation;
					iExtraworking = 0;
				}else if(useVacation < 0){ 
					//logger.info("3333333333333333333333333333333");
					iLasthour = 0;
					iExtraworking = (useVacation * (-1)) + iExtraworking;
				}
			}else if(iLasthour <= 0){
				//logger.info("4444444444444444444444444444");
				iExtraworking =(useVacation * (-1)) + iExtraworking;
				iLasthour = 0;
			}
		}
			

			
		if(cvo.getHc_tanda().equals("49")){ //반차
			
			useVacation = iLasthour - 240;
			
			//logger.info(">>>>>>>>>>>>>>>>" + iLasthour + " : " + iExtraworking + " : " + useVacation );
			if(iLasthour > 0 ){
				//logger.info("111111111111111111111111111");
				if(useVacation >= 0){ 
					//logger.info("2222222222222222222222222222222");
					iLasthour = useVacation;
					iExtraworking = 0;
				}
				else if(useVacation < 0){ 
					//logger.info("3333333333333333333333333333333");
					iLasthour = 0;
					iExtraworking = useVacation * (-1);
				}
			}else if(iLasthour <= 0){
				//logger.info("4444444444444444444444444444");
				iExtraworking = (useVacation * (-1)) + iExtraworking;
				iLasthour = 0;
			}
		}
			
		//logger.info("결과?!?!?>>>>>>>>>>>>>>>>" + iLasthour + " : " + iExtraworking + " : " + useVacation );
		
		if(iExtraworking >= 720) iExtraworking = 720;
		
		int iWeekhour = (iTotalHour - iLasthour ) + iExtraworking ;
		cvo.setHc_lasthour(Integer.toString(iLasthour));
		cvo.setHc_extraworking(Integer.toString(iExtraworking));
		cvo.setHc_weekhour(Integer.toString(iWeekhour));
	
		updateFlag=humanService.halfUpdate(cvo);
		
		return "/human/result";
	}
	
	//로그인 후 첫 화면에서 쓰임
	@RequestMapping("/selectUserInfo")
	public String selectUserInfo(@ModelAttribute MemberVO mvo, Model model) {
		//logger.info("/selectUserInfo 진입 ");
		//logger.info("mvo.getHm_empnum() >>>> "+mvo.getHm_empnum());
		
		List<MemberVO> selectUserInfo = humanService.selectUserInfo(mvo);
		
		String picture = selectUserInfo.get(0).getHm_picture();
		String name = selectUserInfo.get(0).getHm_name();
		//logger.info("picture >>>>" + picture);
		//logger.info("name >>>> " + name);
		
		model.addAttribute("selectUserInfo", selectUserInfo);
		
		return "human/selectUserInfo";
	}
}
