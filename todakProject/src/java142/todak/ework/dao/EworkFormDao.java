package java142.todak.ework.dao;

import java.util.List;

import java142.todak.ework.vo.ApprovalVO;
import java142.todak.ework.vo.AuthBoxVO;
import java142.todak.ework.vo.AuthPersonVO;
import java142.todak.ework.vo.AuthVO;
import java142.todak.ework.vo.HolidayVO;
import java142.todak.ework.vo.LineVO;
import java142.todak.ework.vo.ProposalVO;
import java142.todak.human.vo.MemberVO;
import java142.todak.ework.vo.SignStampVO;

public interface EworkFormDao {
	
	List<LineVO> chaebunLine();
	boolean insertLine(LineVO alvo) throws Exception;
	
	List<ProposalVO> chaebunProposal();
	boolean insertProposal(ProposalVO pvo) throws Exception;
	
	List<ApprovalVO> chaebunApproval();
	boolean insertApproval(ApprovalVO avo) throws Exception;
	
	List<HolidayVO> chaebunHoliday();
	boolean insertHoliday(HolidayVO hvo) throws Exception;
	
	List<AuthVO> chaebunAuth();
	boolean insertAuth(AuthVO auvo) throws Exception;
	boolean updateLine(LineVO lvo) throws Exception;
	List<AuthPersonVO> chaebunAuthPerson();
	boolean insertAuthPerson(AuthPersonVO apvo) throws Exception;
	List<AuthBoxVO> chaebunAuthBox();
	boolean insertAuthBox(AuthBoxVO abvo);
	
	
	List<MemberVO> selectPerson(MemberVO mvo);
	List<MemberVO> selectTeamMember(MemberVO mvo);
	List<SignStampVO> chaebunSignStamp();
	List<SignStampVO> selectSignStamp(SignStampVO ssvo);
	
	
}
