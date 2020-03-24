package java142.todak.human.service;

import java.util.List;







import java142.todak.human.vo.ApprVO;
import java142.todak.human.vo.ApptVO;
import java142.todak.human.vo.CommVO;
import java142.todak.human.vo.MemberVO;
import java142.todak.human.vo.StatusVO;

public interface HumanService {
	public ApprVO chaebunMemberAppr();
	public String chaebunMember();
	public String chaebunApptRecord();
	public boolean insertMemberAppr(ApprVO avo);
	public boolean insertMember(MemberVO mvo);
	public boolean refusedMemberAppr(ApprVO avo);
	public boolean acceptedMemberAppr(ApprVO avo);
	public boolean updateMember(MemberVO mvo);
	public boolean updateResignation(MemberVO mvo);
	public boolean changeCommuteUpdate(CommVO cvo);
	public boolean vacationUpdate(CommVO cvo);
	public boolean halfUpdate(CommVO cvo);
	public boolean insertApptRecord(ApptVO apvo);
	public List<ApptVO> apptRecordSelect(ApptVO apvo);
	public List<ApptVO> apptRecordAll(ApptVO apvo);
	public List<MemberVO> selectMember(MemberVO mvo);
	public List<MemberVO> selectPersonAppt(MemberVO mvo);
	public List<CommVO> selectCommute(CommVO cvo);
	public StatusVO selectTotal();
	public MemberVO memberInfo(MemberVO mvo);
	public MemberVO selectPosition(MemberVO mvo);
	public List<MemberVO> selectDeptMem(MemberVO mvo);
	public List<MemberVO> selectAllMem(MemberVO mvo);
	public List<ApprVO> selectAppr(ApprVO avo);
	public ApprVO selectApprMem(ApprVO avo);
	public boolean idCheck(MemberVO mvo);
	
	public List<CommVO> selectLastHour(CommVO cvo);
	public boolean insertExtrawork(CommVO cvo);
	
	////로그인 후 첫 화면에서 쓰임
	public List<MemberVO> selectUserInfo(MemberVO mvo);
}
