package java142.todak.ework.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java142.todak.common.VOPrintUtil;
import java142.todak.ework.dao.EworkFormDao;
import java142.todak.ework.vo.ApprovalVO;
import java142.todak.ework.vo.AuthBoxVO;
import java142.todak.ework.vo.AuthPersonVO;
import java142.todak.ework.vo.AuthVO;
import java142.todak.ework.vo.HolidayVO;
import java142.todak.ework.vo.LineVO;
import java142.todak.ework.vo.ProposalVO;
import java142.todak.human.vo.MemberVO;
import java142.todak.ework.vo.SignStampVO;

@Service
@Transactional
public class EworkFormServiceImpl implements EworkFormService {

	Logger logger = Logger.getLogger(EworkFormServiceImpl.class);
	
	@Autowired
	private EworkFormDao eworkFormDao;
	
	@Override
	public List<MemberVO> selectTeamMember(MemberVO mvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<MemberVO> selectTeamMember(MemberVO mvo) 시작 >>> ");
		//logger.info("  매개변수 mvo : " + mvo);
		
		List<MemberVO> list = eworkFormDao.selectTeamMember(mvo);
		
		//logger.info("(EworkFormServiceImpl)public List<MemberVO> selectTeamMember(MemberVO mvo) 끝 >>> : " + list);
		return list;
	}

	@Override
	public List<ApprovalVO> chaebunApproval() {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<ApprovalVO> chaebunApproval() 시작 >>> ");
		
		List<ApprovalVO> list = null;
		list = eworkFormDao.chaebunApproval();
		//logger.info("  list : " + list);
		
		//logger.info("(EworkFormServiceImpl)public List<ApprovalVO> chaebunApproval() 끝 >>> : " + list);
		return list;
	}

	@Override
	public boolean insertApproval(ApprovalVO avo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public int insertApproval(ApprovalVO avo) 시작 >>> ");
		//logger.info("  매개변수 avo : " + avo);
		VOPrintUtil.printVO(avo);
		
		boolean bFlag = false;
		bFlag = eworkFormDao.insertApproval(avo);
		//logger.info("  bFlag : " + bFlag);
		
		//logger.info("(EworkFormServiceImpl)public int insertApproval(ApprovalVO avo) 끝 >>> : " + bFlag);
		return bFlag;
	}

	@Override
	public List<ProposalVO> chaebunProposal() {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<ProposalVO> chaebunProposal() 시작 >>> ");
		
		List<ProposalVO> list = null;
		
		list = eworkFormDao.chaebunProposal();
		//logger.info("  list : " + list);
		
		//logger.info("(EworkFormServiceImpl)public List<ProposalVO> chaebunProposal() 끝 >>> : " + list);
		return list;
	}

	@Override
	public boolean insertProposal(ProposalVO pvo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public int insertProposal(ProposalVO pvo) 시작 >>> ");
		//logger.info("  매개변수 pvo : " + pvo);
		VOPrintUtil.printVO(pvo);
		
		boolean bFlag = false;
		bFlag = eworkFormDao.insertProposal(pvo);
		//logger.info("  bFlag : " + bFlag);
		
		//logger.info("(EworkFormServiceImpl)public int insertProposal(ProposalVO pvo) 끝 >>> : " + bFlag);
		return bFlag;
	}
	
	@Override
	public List<LineVO> chaebunLine() {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<LineVO> chaebunLine() 시작 >>> ");
		
		List<LineVO> list = null;
		
		list = eworkFormDao.chaebunLine();
		//logger.info("  list : " + list);
		
		//logger.info("(EworkFormServiceImpl)public List<LineVO> chaebunLine() 끝 >>> : " + list);
		return list;
	}

	@Override
	public boolean insertLine(LineVO alvo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public int insertLine(LineVO alvo) 시작 >>> ");
		//logger.info(" 매개변수 alvo : " + alvo);
		//logger.info("  getEl_num() : " + alvo.getEl_num());
		//logger.info("  getEl_line() : " + alvo.getEl_line());
		
		boolean bFlag = false;
		
		bFlag = eworkFormDao.insertLine(alvo);
		//logger.info(" bFlag : " + bFlag);
		
		//logger.info("(EworkFormServiceImpl)public int insertLine(LineVO alvo) 끝 >>> : " + bFlag);
		return bFlag;
	}

	@Override
	public List<MemberVO> selectPerson(MemberVO mvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<MemberVO> selectPerson(MemberVO mvo) 시작 >>> ");
		//logger.info("  매개변수 mvo : " + mvo);
		//logger.info("  mvo.getHm_empnum() : " + mvo.getHm_empnum());
		
		List<MemberVO> list = eworkFormDao.selectPerson(mvo);
		//logger.info("  list : " + list);
		
		//logger.info("(EworkFormServiceImpl)public List<MemberVO> selectPerson(MemberVO mvo) 끝 >>> : " + list);
		return list;
	}

	@Override
	public List<AuthVO> chaebunAuth() {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<LineVO> chaebunAuth() 시작 >>> ");
		
		List<AuthVO> list = null;
		list = eworkFormDao.chaebunAuth();
		//logger.info("  list : " + list);
		
		//logger.info("(EworkFormServiceImpl)public List<LineVO> chaebunAuth() 끝 >>> : " + list);
		return list;
	}

	@Override
	public boolean insertAuth(AuthVO auvo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public int insertAuth(AuthVO auvo) 시작 >>> ");
		//logger.info("  매개변수 auvo : " + auvo);
		//logger.info("  auvo.getEa_num() : " + auvo.getEa_num());
		//logger.info("  auvo.getHm_empnum() : " + auvo.getHm_empnum());
		//logger.info("  auvo.getEa_position() : " + auvo.getEa_position());
		//logger.info("  auvo.getEa_presentnum() : " + auvo.getEa_presentnum());
		
		boolean bFlag = false;
		bFlag = eworkFormDao.insertAuth(auvo);
		//logger.info("  bFlag : " + bFlag);
		
		//logger.info("(EworkFormServiceImpl)public int insertAuth(AuthVO auvo) 끝 >>> : " + bFlag);
		return bFlag;
	}

	@Override
	public boolean updateLine(LineVO lvo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public int insertAuth(AuthVO auvo) 시작 >>> ");
		//logger.info("  매개변수 lvo : " + lvo);
		
		boolean bFlag = false;
		
		bFlag = eworkFormDao.updateLine(lvo); 
		
		//logger.info("(EworkFormServiceImpl)public int insertAuth(AuthVO auvo) 끝 >>> : " + bFlag);
		return bFlag;
	}
	
	

	@Override
	public List<SignStampVO> chaebunSignStamp() {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<SignStampVO> chaebunSignStamp() 시작 >>> ");
		
		List<SignStampVO> list = null;
		list = eworkFormDao.chaebunSignStamp();
		//logger.info("  list : " + list);
		
		//logger.info("(EworkFormServiceImpl)public List<SignStampVO> chaebunSignStamp() 끝 >>> : " + list);
		return list;
	}

	@Override
	public List<SignStampVO> selectSignStamp(SignStampVO ssvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<SignStampVO> selectSignStamp(SignStampVO ssvo) 시작 >>> ");
		//logger.info("  매개변수 ssvo : " + ssvo);
		//logger.info("  ssvo.getHm_empnum() : " + ssvo.getHm_empnum());
		
		List<SignStampVO> list = eworkFormDao.selectSignStamp(ssvo);
		
		if(list.size() == 0) { //회원이 서명 이미지를 등록하지 않았을 때(file directory 컬럼의 데이터가 null일 때 조회되지 않아서 list에 담기는게 없음) 억지로 빈 VO를 list에 넣는다
			//logger.info("if(list.size() == 0) 진입 >>> ");
			
			SignStampVO no_data = null;
			no_data = new SignStampVO();
			no_data.setEs_filedir("");
			
			list.add(no_data);
			
		}
		
		//logger.info("(EworkFormServiceImpl)public List<SignStampVO> selectSignStamp(SignStampVO ssvo) 끝 >>> : " + list);
		return list;
	}

	@Override
	public List<AuthPersonVO> chaebunAuthPerson() {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<AuthPersonVO> chaebunAuthPerson() 시작 >>> ");
		
		List<AuthPersonVO> list = eworkFormDao.chaebunAuthPerson();
		//logger.info(" list : " + list);
		
		//logger.info("(EworkFormServiceImpl)public List<AuthPersonVO> chaebunAuthPerson() 끝 >>> : " + list);
		return list;
	}

	@Override
	public boolean insertAuthPerson(AuthPersonVO apvo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public int insertAuthPerson(AuthPersonVO apvo) 시작 >>> ");
		//logger.info("  매개변수 apvo : " + apvo);
		VOPrintUtil.printVO(apvo);
		
		boolean bFlag = false;
		
		bFlag = eworkFormDao.insertAuthPerson(apvo);
		//logger.info("  bFlag : " + bFlag);
		
		//logger.info("(EworkFormServiceImpl)public int insertAuthPerson(AuthPersonVO apvo) 끝 >>> : " + bFlag);
		return bFlag;
	}

	@Override
	public List<AuthBoxVO> chaebunAuthBox() {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<AuthBoxVO> chaebunAuthBox() 시작 >>> ");
		
		List<AuthBoxVO> list = null;
		list = eworkFormDao.chaebunAuthBox();
		//logger.info("  list : " + list);
		
		//logger.info("(EworkFormServiceImpl)public List<AuthBoxVO> chaebunAuthBox() 끝 >>> : " + list);
		return list;
	}

	@Override
	public boolean insertAuthBox(AuthBoxVO abvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public boolean insertAuthBox(AuthBoxVO abvo) 시작 >>> ");
		
		boolean bFlag = false;
		bFlag = eworkFormDao.insertAuthBox(abvo);
		//logger.info("  bFlag : " + bFlag);
		
		//logger.info("(EworkFormServiceImpl)public boolean insertAuthBox(AuthBoxVO abvo) 끝 >>> : " + bFlag);
		return bFlag;
	}

	@Override
	public List<HolidayVO> chaebunHoliday() {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<HolidayVO> chaebunHoliday() 시작 >>> ");
		
		List<HolidayVO> list = null;
		list = eworkFormDao.chaebunHoliday();
		//logger.info("  list : " + list);
		
		//logger.info("(EworkFormServiceImpl)public List<HolidayVO> chaebunHoliday() 끝 >>> : " + list);
		return list;
	}

	@Override
	public boolean insertHoliday(HolidayVO hvo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public boolean insertHoliday(HolidayVO hvo) 시작 >>> ");
		//logger.info("  매개변수 hvo : " + hvo);
		VOPrintUtil.printVO(hvo);
		
		boolean bFlag = false;
		bFlag = eworkFormDao.insertHoliday(hvo);
		//logger.info("  bFlag : " + bFlag);
		
		//logger.info("(EworkFormServiceImpl)public boolean insertHoliday(HolidayVO hvo) 끝 >>> : " + bFlag);
		return bFlag;
	}
	
	

}
