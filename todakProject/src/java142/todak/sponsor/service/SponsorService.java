package java142.todak.sponsor.service;

import java.util.List;

import org.springframework.web.bind.annotation.ModelAttribute;

import java142.todak.etc.vo.PagingVO;
import java142.todak.sponsor.vo.CharityVO;
import java142.todak.sponsor.vo.MemberAccountVO;
import java142.todak.sponsor.vo.MemberCardVO;
import java142.todak.sponsor.vo.MemberVO;
import java142.todak.sponsor.vo.SponsorshipVO;

public interface SponsorService {
	public List<MemberVO>selectMember(MemberVO smvo, PagingVO pvo);
	public int insertMember(MemberVO smvo, MemberCardVO smcvo, MemberAccountVO smavo);
	public int updateMember(MemberVO smvo, MemberCardVO smcvo, MemberAccountVO smavo);
	public int deleteMember(MemberVO smvo);
	public List<MemberVO> chaebunMember();
	
	public List<MemberCardVO>selectMemberCard(MemberCardVO smcvo, PagingVO pvo);
	public List<MemberCardVO> chaebunMemberCard();
	
	public List<MemberAccountVO>selectMemberAccount(MemberAccountVO smavo, PagingVO pvo);
	public List<MemberAccountVO> chaebunMemberAccount();

	public List<CharityVO>selectCharity(CharityVO scvo, PagingVO pvo);
	public int insertCharity(CharityVO scvo);
	public List<CharityVO> chaebunCharity();
	public int updateCharity(CharityVO scvo);
	public int deleteCharity(CharityVO scvo);
	
	public List<SponsorshipVO>selectSponsorship(MemberVO smvo, CharityVO scvo);
}
