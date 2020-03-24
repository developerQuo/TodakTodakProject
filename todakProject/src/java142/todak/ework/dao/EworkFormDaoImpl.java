package java142.todak.ework.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java142.todak.ework.vo.ApprovalVO;
import java142.todak.ework.vo.AuthBoxVO;
import java142.todak.ework.vo.AuthPersonVO;
import java142.todak.ework.vo.AuthVO;
import java142.todak.ework.vo.HolidayVO;
import java142.todak.ework.vo.LineVO;
import java142.todak.ework.vo.ProposalVO;
import java142.todak.human.vo.MemberVO;
import java142.todak.ework.vo.SignStampVO;

@Repository
public class EworkFormDaoImpl implements EworkFormDao {
	
	@Autowired
	private SqlSession session;
	
	
	
	@Override
	public List<MemberVO> selectTeamMember(MemberVO mvo) {
		// TODO Auto-generated method stub
		return session.selectList("selectTeamMember" ,mvo);
	}

	@Override
	public List<ApprovalVO> chaebunApproval() {
		// TODO Auto-generated method stub
		return session.selectList("chaebunApproval");
	}

	@Override
	public boolean insertApproval(ApprovalVO avo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.insert("insertApproval", avo);
		
		if(nCnt == 1) return true;
		else return false;
	}

	@Override
	public List<ProposalVO> chaebunProposal() {
		// TODO Auto-generated method stub
		return session.selectList("chaebunProposal");
	}

	@Override
	public boolean insertProposal(ProposalVO pvo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.insert("insertProposal", pvo);
		
		if(nCnt == 1) return true;
		else return false;
	}

	@Override
	public List<LineVO> chaebunLine() {
		// TODO Auto-generated method stub
		return session.selectList("chaebunLine");
	}

	@Override
	public boolean insertLine(LineVO alvo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.insert("insertLine", alvo);
		
		if(nCnt == 1) return true;
		else return false;
	}

	@Override
	public List<MemberVO> selectPerson(MemberVO mvo) {
		// TODO Auto-generated method stub
		return session.selectList("selectPerson", mvo);
	}

	@Override
	public List<AuthVO> chaebunAuth() {
		// TODO Auto-generated method stub
		return session.selectList("chaebunAuth");
	}

	@Override
	public boolean insertAuth(AuthVO auvo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.insert("insertAuth", auvo);
		
		if(nCnt == 1) return true;
		else return false;
	}

	@Override
	public boolean updateLine(LineVO lvo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.update("updateLine", lvo);
		
		if(nCnt == 1) return true;
		else return false;
	}

	
	
	@Override
	public List<SignStampVO> chaebunSignStamp() {
		// TODO Auto-generated method stub
		return session.selectList("chaebunSignStamp");
	}

	@Override
	public List<SignStampVO> selectSignStamp(SignStampVO ssvo) {
		// TODO Auto-generated method stub
		return session.selectList("selectSignStamp", ssvo);
	}

	@Override
	public List<AuthPersonVO> chaebunAuthPerson() {
		// TODO Auto-generated method stub
		return session.selectList("chaebunAuthPerson");
	}

	@Override
	public boolean insertAuthPerson(AuthPersonVO apvo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.insert("insertAuthPerson", apvo);
		
		if(nCnt == 1) return true;
		else return false;
	}

	@Override
	public List<AuthBoxVO> chaebunAuthBox() {
		// TODO Auto-generated method stub
		return session.selectList("chaebunAuthBox");
	}

	@Override
	public boolean insertAuthBox(AuthBoxVO abvo) {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.insert("insertAuthBox", abvo);
		
		if(nCnt == 1) return true;
		else return false;
	}

	@Override
	public List<HolidayVO> chaebunHoliday() {
		// TODO Auto-generated method stub
		return session.selectList("chaebunHoliday");
	}

	@Override
	public boolean insertHoliday(HolidayVO hvo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.insert("insertHoliday", hvo);
		if(nCnt ==1) return true;
		else return false;
	}
	
	
}
