package java142.todak.human.dao;

import java.util.List;








import java142.todak.human.vo.ApprVO;
import java142.todak.human.vo.ApptVO;
import java142.todak.human.vo.CommVO;
import java142.todak.human.vo.MemberVO;
import java142.todak.human.vo.StatusVO;

public interface HumanDao {
	public ApprVO chaebunMemberAppr();
	public String chaebunMember();
	public String chaebunApptRecord();
	public int insertMemberAppr(ApprVO avo);
	public int insertMember(MemberVO mvo);
	public int refusedMemberAppr(ApprVO avo);
	public int acceptedMemberAppr(ApprVO avo);
	public int updateMember(MemberVO mvo);
	public int updateResignation(MemberVO mvo);
	public int changeCommuteUpdate(CommVO cvo);
	public int vacationUpdate(CommVO cvo);
	public int halfUpdate(CommVO cvo);
	public int insertApptRecord(ApptVO apvo);
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
	public String idCheck(MemberVO mvo);
	
	public List<CommVO> selectLastHour(CommVO cvo);
	public int insertExtrawork(CommVO cvo);
	
	//로그인 후 첫 화면에서 쓰임
	public List<MemberVO> selectUserInfo(MemberVO mvo);
}

