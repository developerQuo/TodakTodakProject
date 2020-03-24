package java142.todak.ework.dao;

import java.util.List;

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

public interface EworkDao {

	List<SelectAuthBoxVO> selectAuthBox(SelectAuthBoxVO sabvo);
	List<ApprovalVO> searchApproval(SelectAuthBoxVO sabvo);
	List<ProposalVO> searchProposal(SelectAuthBoxVO sabvo);
	List<HolidayVO> searchHoliday(SelectAuthBoxVO sabvo);
	List<AuthPersonVO> searchAuthPerson(SelectAuthBoxVO sabvo);
	
	List<AuthPersonVO> chaebunAuthPerson();
	boolean insertAuthPerson(AuthPersonVO apvo) throws Exception;
	boolean updateAuth(AuthVO auvo) throws Exception;
	
	List<LineHistoryVO> chaebunLineHistory();
	boolean insertLineHistory(LineHistoryVO lhvo) throws Exception;
	
	boolean updateLine(LineVO lvo) throws Exception;
	
	List<AuthPersonVO> plusSequence(EanumVO nvo);
	List<LineVO> searchLine(EanumVO nvo);
	List<MemberVO> selectLowerPositionPerson(MemberVO mvo);
	
	boolean insertSignStamp(SignStampVO ssvo) throws Exception;
	boolean updateSignStamp(SignStampVO ssvo) throws Exception;
	
}
