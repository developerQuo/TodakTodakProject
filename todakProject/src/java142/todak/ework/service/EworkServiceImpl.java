package java142.todak.ework.service;

import java.util.List;

import java142.todak.common.VOPrintUtil;
import java142.todak.ework.dao.EworkDao;
import java142.todak.ework.vo.ApprovalVO;
import java142.todak.ework.vo.AuthPersonVO;
import java142.todak.ework.vo.AuthVO;
import java142.todak.ework.vo.EanumVO;
import java142.todak.ework.vo.HolidayVO;
import java142.todak.ework.vo.LineHistoryVO;
import java142.todak.ework.vo.LineVO;
import java142.todak.human.vo.MemberVO;
import java142.todak.ework.vo.ProposalVO;
import java142.todak.ework.vo.SelectAuthBoxVO;
import java142.todak.ework.vo.SignStampVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class EworkServiceImpl implements EworkService {

	Logger logger = Logger.getLogger(EworkServiceImpl.class);
	
	@Autowired
	private EworkDao eworkDao;

	@Override
	public List<SelectAuthBoxVO> selectAuthBox(SelectAuthBoxVO sabvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkServiceImpl)public List<AuthBoxVO> selectAuthBox() 시작 >>> ");
		//logger.info("  매개변수 sabvo : " + sabvo);
		VOPrintUtil.printVO(sabvo);
		
		List<SelectAuthBoxVO> list = null;
		list = eworkDao.selectAuthBox(sabvo);
		//logger.info("  list : " + list);
		
		//logger.info("(EworkServiceImpl)public List<AuthBoxVO> selectAuthBox() 끝 >>> ");
		return list;
	}

	@Override
	public List<ProposalVO> searchProposal(SelectAuthBoxVO sabvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkServiceImpl)public List<ProposalVO> searchProposal(SelectAuthBoxVO sabvo) 시작 >>> ");
		//logger.info("  매개변수 sabvo : " + sabvo);
		VOPrintUtil.printVO(sabvo);
		
		List<ProposalVO> list = null;
		list = eworkDao.searchProposal(sabvo);
		//logger.info("  list : " + list);
		
		//logger.info("(EworkServiceImpl)public List<ProposalVO> searchProposal(SelectAuthBoxVO sabvo) 끝 >>> : " + list);
		return list;
	}

	@Override
	public List<HolidayVO> searchHoliday(SelectAuthBoxVO sabvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkServiceImpl)public List<HolidayVO> searchHoliday(SelectAuthBoxVO sabvo) 시작 >>> ");
		//logger.info("  매개변수 sabvo : " + sabvo);
		VOPrintUtil.printVO(sabvo);
		
		List<HolidayVO> list = null;
		list = eworkDao.searchHoliday(sabvo);
		//logger.info("  list : " + list);
		
		//logger.info("(EworkServiceImpl)public List<HolidayVO> searchHoliday(SelectAuthBoxVO sabvo) 끝 >>> : " + list);
		return list;
	}

	@Override
	public List<AuthPersonVO> searchAuthPerson(SelectAuthBoxVO sabvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkServiceImpl)public List<AuthPersonVO> searchAuthPerson(SelectAuthBoxVO sabvo) 시작 >>> ");
		//logger.info("  매개변수 sabvo : " + sabvo);
		VOPrintUtil.printVO(sabvo);
		
		List<AuthPersonVO> list = null;
		list = eworkDao.searchAuthPerson(sabvo);
		//logger.info("  list : " + list);
		
		//logger.info("(EworkServiceImpl)public List<AuthPersonVO> searchAuthPerson(SelectAuthBoxVO sabvo) 끝 >>> : " + list);
		return list;
	}
	
	@Override
	public List<AuthPersonVO> chaebunAuthPerson() {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<AuthPersonVO> chaebunAuthPerson() 시작 >>> ");
		
		List<AuthPersonVO> list = null;
		list = eworkDao.chaebunAuthPerson();
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
		
		bFlag = eworkDao.insertAuthPerson(apvo);
		//logger.info("  bFlag : " + bFlag);
		
		//logger.info("(EworkFormServiceImpl)public int insertAuthPerson(AuthPersonVO apvo) 끝 >>> : " + bFlag);
		return bFlag;
	}

	@Override
	public boolean updateAuth(AuthVO auvo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public boolean updateAuth(AuthVO auvo) 시작 >>> ");
		//logger.info("  매개변수 auvo : " + auvo);
		//logger.info("  getEa_presentnum() : " + auvo.getEa_presentnum());
		//logger.info("  getEa_position() : " + auvo.getEa_position());
		//logger.info("  getEa_num() : " + auvo.getEa_num());
		
		boolean bFlag = false;
		
		bFlag = eworkDao.updateAuth(auvo);
		//logger.info("  bFlag : " + bFlag);
		
		//logger.info("(EworkFormServiceImpl)public boolean updateAuth(AuthVO auvo) 끝 >>> : " + bFlag);
		return bFlag;
	}

	@Override
	public List<AuthPersonVO> plusSequence(EanumVO nvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<AuthPersonVO> plusSequence() 시작 >>> ");
		//logger.info("  매개변수 nvo : " + nvo);
		//logger.info("  getEa_num : " + nvo.getEa_num());
		
		List<AuthPersonVO> list = null;
		list = eworkDao.plusSequence(nvo);
		//logger.info("  list : " + list);
		
		//logger.info("(EworkFormServiceImpl)public List<AuthPersonVO> plusSequence() 끝 >>> : " + list);
		return list;
	}

	@Override
	public List<LineVO> searchLine(EanumVO nvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkFormServiceImpl)public List<LineVO> searchLine() 시작 >>> ");
		//logger.info("  매개변수 nvo : " + nvo);
		//logger.info("  getEa_num : " + nvo.getEa_num());
		
		List<LineVO> list = eworkDao.searchLine(nvo);
		//logger.info("  list : " + list);
		
		//logger.info("(EworkFormServiceImpl)public List<LineVO> searchLine() 끝 >>> : " + list);
		return list;
	}

	@Override
	public List<ApprovalVO> searchApproval(SelectAuthBoxVO sabvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkServiceImpl)public List<ApprovalVO> searchApproval(SelectAuthBoxVO sabvo) 시작 >>> ");
		//logger.info("  매개변수 sabvo : " + sabvo);
		VOPrintUtil.printVO(sabvo);
		
		List<ApprovalVO> list = null;
		list = eworkDao.searchApproval(sabvo);
		//logger.info("  list : " + list);
		
		//logger.info("(EworkServiceImpl)public List<ApprovalVO> searchApproval(SelectAuthBoxVO sabvo) 끝 >>> : " + list);
		return list;
	}

	@Override
	public List<LineHistoryVO> chaebunLineHistory() {
		// TODO Auto-generated method stub
		//logger.info("(EworkServiceImpl)public List<AuthPersonVO> chaebunLineHistory() 시작 >>> ");
		
		List<LineHistoryVO> list = null;
		
		list = eworkDao.chaebunLineHistory();
		//logger.info("  list : " + list);
		
		//logger.info("(EworkServiceImpl)public List<AuthPersonVO> chaebunLineHistory() 끝 >>> : " + list);
		return list;
	}

	@Override
	public boolean insertLineHistory(LineHistoryVO lhvo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkServiceImpl)public boolean insertLineHistory(LineHistoryVO lhvo) 시작 >>> ");
		//logger.info("  매개변수 lhvo : " + lhvo);
		//logger.info("  getElh_num() : " + lhvo.getElh_num());
		//logger.info("  getEa_num() : " + lhvo.getEa_num());
		//logger.info("  getElh_line() : " + lhvo.getEl_line());
		//logger.info("  getElh_insertdate() : " + lhvo.getElh_insertdate());
		
		boolean bFlag = false;
		
		bFlag = eworkDao.insertLineHistory(lhvo);
		//logger.info("  bFlag : " + bFlag);
		
		//logger.info("(EworkServiceImpl)public List<AuthPersonVO> chaebunLineHistory() 끝 >>> : " + bFlag);
		return bFlag;
	}

	@Override
	public List<MemberVO> selectLowerPositionPerson(MemberVO mvo) {
		// TODO Auto-generated method stub
		//logger.info("(EworkServiceImpl)public List<MemberVO> selectLowerPositionPerson(AuthorizationVO authvo) 시작 >>> ");
		//logger.info("  매개변수 mvo : " + mvo);
		//logger.info("  getEa_num() : " + mvo.getHm_deptnum());
		//logger.info("  getHm_empnum() : " + mvo.getHm_position());
		
		List<MemberVO> list = eworkDao.selectLowerPositionPerson(mvo);
		//logger.info("  list : " + list);
		
		//logger.info("(EworkServiceImpl)public List<MemberVO> selectLowerPositionPerson(AuthorizationVO authvo) 끝 >>> : " + list);
		return list;
	}

	@Override
	public boolean updateLine(LineVO lvo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkServiceImpl)public boolean updateLine(LineVO lvo) 시작 >>> ");
		//logger.info("  매개변수 lvo : " + lvo);
		//logger.info("  getEl_line() : " + lvo.getEl_line());
		//logger.info("  getEa_num() : " + lvo.getEa_num());
		
		boolean bFlag = false;
		bFlag = eworkDao.updateLine(lvo);
		//logger.info("  bFlag : " + bFlag);
		
		//logger.info("(EworkServiceImpl)public boolean updateLine(LineVO lvo) 끝 >>> : " + bFlag);
		return bFlag;
	}

	@Override
	public boolean insertSignStamp(SignStampVO ssvo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkServiceImpl)public boolean insertSignStamp(SignStampVO ssvo) 시작 >>> ");
		//logger.info("  매개변수 ssvo : " + ssvo);
		//logger.info("  getEs_num() : " + ssvo.getEs_num());
		//logger.info("  getHm_empnum() : " + ssvo.getHm_empnum());
		//logger.info("  getHm_empnum() : " + ssvo.getEs_filedir());
		//logger.info("  getHm_empnum() : " + ssvo.getEs_insertdate());
		//logger.info("  getHm_empnum() : " + ssvo.getEs_updatedate());
		
		boolean bFlag = false;
		
		bFlag = eworkDao.insertSignStamp(ssvo);
		
		//logger.info("(EworkServiceImpl)public boolean insertSignStamp(SignStampVO ssvo) 끝 >>> : " + bFlag);
		return bFlag;
	}

	@Override
	public boolean updateSignStamp(SignStampVO ssvo) throws Exception {
		// TODO Auto-generated method stub
		//logger.info("(EworkServiceImpl)public boolean updateSignStamp(SignStampVO ssvo) 시작 >>> ");
		//logger.info("  매개변수 ssvo : " + ssvo);
		//logger.info("  getEs_num() : " + ssvo.getEs_num());
		//logger.info("  getHm_empnum() : " + ssvo.getHm_empnum());
		//logger.info("  getHm_empnum() : " + ssvo.getEs_filedir());
		//logger.info("  getHm_empnum() : " + ssvo.getEs_insertdate());
		//logger.info("  getHm_empnum() : " + ssvo.getEs_updatedate());
		
		boolean bFlag = false;
		
		bFlag = eworkDao.updateSignStamp(ssvo);
		
		//logger.info("(EworkServiceImpl)public boolean updateSignStamp(SignStampVO ssvo) 끝 >>> : " + bFlag);
		return bFlag;
	}
	
	
	
	
}
