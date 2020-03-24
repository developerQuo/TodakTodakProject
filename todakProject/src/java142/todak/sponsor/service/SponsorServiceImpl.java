package java142.todak.sponsor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionTemplate;

import java142.todak.etc.vo.PagingVO;
import java142.todak.sponsor.dao.SponsorDao;
import java142.todak.sponsor.vo.CharityVO;
import java142.todak.sponsor.vo.MemberAccountVO;
import java142.todak.sponsor.vo.MemberCardVO;
import java142.todak.sponsor.vo.MemberVO;
import java142.todak.sponsor.vo.SponsorshipVO;

@Service
@Transactional
public class SponsorServiceImpl implements SponsorService {
	
	@Autowired
	private SponsorDao sponsorDao;
	
	@Autowired
	private PlatformTransactionManager transactionManager;
	
	@Override
	public List<MemberVO>selectMember(MemberVO smvo, PagingVO pvo){
		return sponsorDao.selectMember(smvo, pvo);
	}
	
	@Override
	public int insertMember(final MemberVO smvo, final MemberCardVO smcvo, final MemberAccountVO smavo){
		TransactionTemplate transactionTemplate = new TransactionTemplate(transactionManager);
		return transactionTemplate.execute(new TransactionCallback<Integer>() {
            // the code in this method executes in a transactional context
            public Integer doInTransaction(TransactionStatus status) {
            	int nCnt = 0;
        		sponsorDao.insertMember(smvo);
        		sponsorDao.insertMemberCard(smcvo);
        		sponsorDao.insertMemberAccount(smavo);
        		nCnt = 1;
                return nCnt;
            }
        });
	}

	@Override
	public int updateMember(final MemberVO smvo, final MemberCardVO smcvo, final MemberAccountVO smavo){
		TransactionTemplate transactionTemplate = new TransactionTemplate(transactionManager);
		return transactionTemplate.execute(new TransactionCallback<Integer>() {
            // the code in this method executes in a transactional context
            public Integer doInTransaction(TransactionStatus status) {
            	int nCnt = 0;
        		sponsorDao.updateMember(smvo);
        		sponsorDao.updateMemberCard(smcvo);
        		sponsorDao.updateMemberAccount(smavo);
        		nCnt = 1;
                return nCnt;
            }
        });
	}

	@Override
	public int deleteMember(final MemberVO smvo){
		TransactionTemplate transactionTemplate = new TransactionTemplate(transactionManager);
		return transactionTemplate.execute(new TransactionCallback<Integer>() {
            // the code in this method executes in a transactional context
            public Integer doInTransaction(TransactionStatus status) {
            	int nCnt = 0;
        		sponsorDao.deleteMember(smvo);
        		sponsorDao.deleteMemberCard(smvo);
        		sponsorDao.deleteMemberAccount(smvo);
        		nCnt = 1;
                return nCnt;
            }
        });
	}
	
	@Override
	public List<MemberVO> chaebunMember(){
		return sponsorDao.chaebunMember();
	}

	
	@Override
	public List<MemberCardVO>selectMemberCard(MemberCardVO smcvo, PagingVO pvo){
		return sponsorDao.selectMemberCard(smcvo, pvo);
	}
	
	@Override
	public List<MemberCardVO> chaebunMemberCard(){
		return sponsorDao.chaebunMemberCard();
	}

	
	@Override
	public List<MemberAccountVO>selectMemberAccount(MemberAccountVO smavo, PagingVO pvo){
		return sponsorDao.selectMemberAccount(smavo, pvo);
	}
	
	@Override
	public List<MemberAccountVO> chaebunMemberAccount(){
		return sponsorDao.chaebunMemberAccount();
	}

	
	@Override
	public List<CharityVO> selectCharity(CharityVO scvo, PagingVO pvo) {
		// TODO Auto-generated method stub
		return sponsorDao.selectCharity(scvo, pvo);
	}
	
	@Override
	public int insertCharity(CharityVO scvo){
		return sponsorDao.insertCharity(scvo);
	}
	
	@Override
	public List<CharityVO> chaebunCharity(){
		return sponsorDao.chaebunCharity();
	}
	
	@Override
	public int updateCharity(CharityVO scvo){
		return sponsorDao.updateCharity(scvo);
	}
	
	@Override
	public int deleteCharity(CharityVO scvo){
		return sponsorDao.deleteCharity(scvo);
	}
	
	
	@Override
	public List<SponsorshipVO>selectSponsorship(MemberVO smvo, CharityVO scvo){
		return sponsorDao.selectSponsorship(smvo, scvo);
	}
}
