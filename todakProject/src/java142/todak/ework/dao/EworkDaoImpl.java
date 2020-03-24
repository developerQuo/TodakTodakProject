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

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EworkDaoImpl implements EworkDao {

	@Autowired
	private SqlSession session;

	@Override
	public List<SelectAuthBoxVO> selectAuthBox(SelectAuthBoxVO sabvo) {
		// TODO Auto-generated method stub
		return session.selectList("selectAuthBox", sabvo);
	}

	@Override
	public List<ProposalVO> searchProposal(SelectAuthBoxVO sabvo) {
		// TODO Auto-generated method stub
		return session.selectList("searchProposal", sabvo);
	}

	@Override
	public List<HolidayVO> searchHoliday(SelectAuthBoxVO sabvo) {
		// TODO Auto-generated method stub
		return session.selectList("searchHoliday", sabvo);
	}

	@Override
	public List<AuthPersonVO> searchAuthPerson(SelectAuthBoxVO sabvo) {
		// TODO Auto-generated method stub
		return session.selectList("searchAuthPerson", sabvo);
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
	public boolean updateAuth(AuthVO auvo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.update("updateAuth", auvo);
		
		if(nCnt == 1) return true;
		return false;
	}

	@Override
	public List<AuthPersonVO> plusSequence(EanumVO nvo) {
		// TODO Auto-generated method stub
		return session.selectList("plusSequence", nvo);
	}

	@Override
	public List<LineVO> searchLine(EanumVO nvo) {
		// TODO Auto-generated method stub
		return session.selectList("searchLine", nvo);
	}

	@Override
	public List<ApprovalVO> searchApproval(SelectAuthBoxVO sabvo) {
		// TODO Auto-generated method stub
		return session.selectList("searchApproval", sabvo);
	}

	@Override
	public List<LineHistoryVO> chaebunLineHistory() {
		// TODO Auto-generated method stub
		return session.selectList("chaebunLineHistory");
	}

	@Override
	public boolean insertLineHistory(LineHistoryVO lhvo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.update("insertLineHistory", lhvo);
		
		if(nCnt == 1) return true;
		return false;
	}

	@Override
	public List<MemberVO> selectLowerPositionPerson(MemberVO mvo) {
		// TODO Auto-generated method stub
		return session.selectList("selectLowerPositionPerson", mvo);
	}

	@Override
	public boolean updateLine(LineVO lvo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.update("updateLine", lvo);
		
		if(nCnt == 1) return true;
		return false;
	}

	@Override
	public boolean insertSignStamp(SignStampVO ssvo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.update("insertSignStamp", ssvo);
		
		if(nCnt == 1) return true;
		return false;
	}

	@Override
	public boolean updateSignStamp(SignStampVO ssvo) throws Exception {
		// TODO Auto-generated method stub
		int nCnt = 0;
		
		nCnt = session.update("updateSignStamp", ssvo);
		
		if(nCnt == 1) return true;
		return false;
	}
	
	
	
}
