package java142.todak.sponsor.dao;

import java.util.List;

import java142.todak.etc.vo.PagingVO;
import java142.todak.sponsor.vo.CharityVO;
import java142.todak.sponsor.vo.MemberAccountVO;
import java142.todak.sponsor.vo.MemberCardVO;
import java142.todak.sponsor.vo.MemberVO;
import java142.todak.sponsor.vo.SponsorshipVO;

public interface SponsorDao {
	
	public List<MemberVO>selectMember(MemberVO smvo, PagingVO pvo);
	public int insertMember(MemberVO smvo);
	public int updateMember(MemberVO smvo);
	public int deleteMember(MemberVO smvo);
	public List<MemberVO> chaebunMember();
	
	public List<MemberCardVO>selectMemberCard(MemberCardVO smcvo, PagingVO pvo);
	public int insertMemberCard(MemberCardVO smcvo);
	public int updateMemberCard(MemberCardVO smcvo);
	public int deleteMemberCard(MemberVO smvo);
	public List<MemberCardVO> chaebunMemberCard();
	
	public List<MemberAccountVO>selectMemberAccount(MemberAccountVO smavo, PagingVO pvo);
	public int insertMemberAccount(MemberAccountVO smavo);
	public int updateMemberAccount(MemberAccountVO smavo);
	public int deleteMemberAccount(MemberVO smvo);
	public List<MemberAccountVO> chaebunMemberAccount();

	public List<CharityVO>selectCharity(CharityVO scvo, PagingVO pvo);
	public int insertCharity(CharityVO scvo);
	public List<CharityVO> chaebunCharity();
	public int updateCharity(CharityVO scvo);
	public int deleteCharity(CharityVO scvo);
	
	public List<SponsorshipVO>selectSponsorship(MemberVO smvo, CharityVO scvo);

}
