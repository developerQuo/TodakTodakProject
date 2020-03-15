package java142.todak.sponsor.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import java142.todak.etc.vo.PagingVO;
import java142.todak.sponsor.vo.CharityVO;
import java142.todak.sponsor.vo.MemberAccountVO;
import java142.todak.sponsor.vo.MemberCardVO;
import java142.todak.sponsor.vo.MemberVO;
import java142.todak.sponsor.vo.SponsorshipVO;

@Repository
public class SponsorDaoImpl implements SponsorDao {

	Logger logger = Logger.getLogger(SponsorDao.class);
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<MemberVO>selectMember(MemberVO smvo, PagingVO pvo){
		return session.selectList("selectMember");
	}
	
	@Override
	public int insertMember(MemberVO smvo){
		return session.insert("insertMember", smvo);
	}
	
	@Override
	public int updateMember(MemberVO smvo){
		return session.update("updateMember", smvo);
	}

	@Override
	public int deleteMember(MemberVO smvo){
		return session.update("deleteMember", smvo);
	}
	
	@Override
	public List<MemberVO> chaebunMember(){
		return session.selectList("chaebunMember");
	}

	
	@Override
	public List<MemberCardVO>selectMemberCard(MemberCardVO smcvo, PagingVO pvo){
		return session.selectList("selectMemberCard");
	}
	
	@Override
	public int insertMemberCard(MemberCardVO smcvo){
		return session.insert("insertMemberCard", smcvo);
	}

	@Override
	public int updateMemberCard(MemberCardVO smcvo){
		return session.update("updateMemberCard", smcvo);
	}

	@Override
	public int deleteMemberCard(MemberVO smvo){
		return session.update("deleteMemberCard", smvo);
	}
	
	@Override
	public List<MemberCardVO> chaebunMemberCard(){
		return session.selectList("chaebunMemberCard");
	}

	
	@Override
	public List<MemberAccountVO>selectMemberAccount(MemberAccountVO smavo, PagingVO pvo){
		return session.selectList("selectMemberAccount");
	}
	
	@Override
	public int insertMemberAccount(MemberAccountVO smavo){
		return session.insert("insertMemberAccount", smavo);
	}

	@Override
	public int updateMemberAccount(MemberAccountVO smavo){
		return session.update("updateMemberAccount", smavo);
	}

	@Override
	public int deleteMemberAccount(MemberVO smvo){
		return session.update("deleteMemberAccount", smvo);
	}
	
	@Override
	public List<MemberAccountVO> chaebunMemberAccount(){
		return session.selectList("chaebunMemberAccount");
	}

	
	@Override
	public List<CharityVO> selectCharity(CharityVO scvo, PagingVO pvo) {
		// TODO Auto-generated method stub
		return session.selectList("selectCharity");
	}
	
	@Override
	public int insertCharity(CharityVO scvo){
		return session.insert("insertCharity", scvo);
	}

	@Override
	public List<CharityVO> chaebunCharity(){
		return session.selectList("chaebunCharity");
	}
	
	@Override
	public int updateCharity(CharityVO scvo){
		return session.update("updateCharity", scvo);
	}
	
	@Override
	public int deleteCharity(CharityVO scvo){
		return session.update("deleteCharity", scvo);
	}

	
	@Override
	public List<SponsorshipVO>selectSponsorship(MemberVO smvo, CharityVO scvo){
		return session.selectList("selectSponsorship");
	}
	
}
