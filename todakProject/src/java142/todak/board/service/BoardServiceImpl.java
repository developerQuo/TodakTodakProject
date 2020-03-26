package java142.todak.board.service;

import java.util.List;

import java142.todak.board.dao.BoardDao;
import java142.todak.board.vo.NoCheckVO;
import java142.todak.board.vo.NoticeVO;
import java142.todak.board.vo.SuLikeVO;
import java142.todak.board.vo.SuReplyVO;
import java142.todak.board.vo.SuggestionVO;
import java142.todak.human.vo.MemberVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BoardServiceImpl implements BoardService {

	Logger logger = Logger.getLogger(BoardServiceImpl.class);
	
	@Autowired
	BoardDao boardDao;

	@Override
	public List<NoticeVO> selectNotice(NoticeVO nvo) {
		//logger.info("(log)BoardServiceImpl.selectNotice ����");
		List<NoticeVO> sList = null;
		sList = boardDao.listNotice(nvo);
		//logger.info("(log)BoardServiceImpl.selectNotice ����");
		return sList;
	}
	
	@Override
	public List<NoticeVO> searchNotice(NoticeVO nvo){
		//logger.info("(log)BoardServiceImpl.searchNotice ����");
		List<NoticeVO> sList = null;
		sList = boardDao.searchNotice(nvo);
		//logger.info("(log)BoardServiceImpl.searchNotice ����");
		return sList;
	}

	@Override
	public int insertNotice(NoticeVO nvo) {
		//logger.info("(log)BoardServiceImpl.insertNotice ����");
		int iFlag = 0;
		iFlag = boardDao.insertNotice(nvo);
		//logger.info("(log)BoardServiceImpl.insertNotice ����");
		return iFlag;
	}

	@Override
	public List<NoticeVO> chaebunNotice() {
		//logger.info("(log)BoardServiceImpl.cheabunNotice ����");
		List<NoticeVO> aList =  null;
		aList = boardDao.chaebunNotice();
		//logger.info("aList >>>> : " + aList.get(0).getBn_num());
		//logger.info("(log)BoardServiceImpl.cheabunNotice ����");
		return aList;
	}

	@Override
	public int updateNotice(NoticeVO nvo) {
		//logger.info("(log)BoardServiceImpl.updateNotice ����");
		int iFlag = 0;
		iFlag =  boardDao.updateNotice(nvo);
		//logger.info("(log)BoardServiceImpl.updateNotice ����");
		return iFlag;
	}
	
	@Override
	public int updateNoticeHit(NoticeVO nvo){
		//logger.info("(log)BoardServiceImpl.updateNoticeHit ����");
		int iFlag = 0;
		iFlag =  boardDao.updateNoticeHit(nvo);
		//logger.info("(log)BoardServiceImpl.updateNoticeHit ����");
		return iFlag;
		
	}
	@Override
	public int deleteNotice(NoticeVO nvo) {
		//logger.info("(log)BoardServiceImpl.deleteNotice ����");
		int iFlag = 0;
		iFlag = boardDao.deleteNotice(nvo);
		//logger.info("(log)BoardServiceImpl.deleteNotice ����");
		return iFlag;
	}

	//�۾��� ���Ѻ���
	@Override
	public List<MemberVO> selectWrite(MemberVO mvo) {
		//logger.info("(log)BoardServiceImpl.selectWrite ����");
		List<MemberVO> sList = null;
		sList = boardDao.selectWrite(mvo);
		//logger.info("(log)BoardServiceImpl.selectWrite ����");
		
		return sList;
	}

	
	@Override
	public int checkNotice(NoCheckVO ncvo) {
		//logger.info("(log)BoardServiceImpl.checkNotice ����");
		int iFlag = 0;
		iFlag = boardDao.checkNotice(ncvo);
		//logger.info("(log)BoardServiceImpl.checkNotice ����");
		return iFlag;
	}

	@Override
	public List<NoCheckVO> chaebunNoCheck() {
		//logger.info("(log)BoardServiceImpl.chaebunNoCheck ����");
		List<NoCheckVO> cList = null;
		cList = boardDao.chaebunNoCheck();
		//logger.info("(log)BoardServiceImpl.chaebunNoCheck ����");
		return cList;
	}

	
	@Override
	public List<NoCheckVO> checkList(NoCheckVO ncvo) {
		//logger.info("(log)BoardServiceImpl.checkList ����");
		List<NoCheckVO>  cList = null;
		cList = boardDao.checkList(ncvo);
		//logger.info("(log)BoardServiceImpl.checkList ����");
		return cList;
	}


	 
	
	//---------------------------���ǻ��װԽ���------------------------------
	
	@Override
	public List<SuggestionVO> selectSuggestion(SuggestionVO svo) {
		//logger.info("(log)BoardServiceImpl.selectSuggestion ����");
		List<SuggestionVO> sList = null;
		sList = boardDao.selectSuggestion(svo);
		//logger.info("(log)BoardServiceImpl.selectSuggestion ����");
		return sList;
	}

	@Override
	public List<SuggestionVO> cheabunSuggestion() {
		//logger.info("(log)BoardServiceImpl.cheabunSuggestion ����");
		List<SuggestionVO> aList = null;
		aList = boardDao.chaebunSuggestion();
		//logger.info("(log)BoardServiceImpl.cheabunSuggestion ����");
		return aList;
	}

	@Override
	public int insertSuggestion(SuggestionVO svo) {
		//logger.info("(log)BoardServiceImpl.insertSuggestion ����");
		int iFlag = 0;
		iFlag = boardDao.insertSuggestion(svo);
		//logger.info("(log)BoardServiceImpl.insertSuggestion ����");
		return iFlag;
	}

	@Override
	public List<SuggestionVO> searchSuggestion(SuggestionVO svo) {
		//logger.info("(log)BoardServiceImpl.searchSuggestion ����");
		List<SuggestionVO> sList = null;
		sList = boardDao.searchSuggestion(svo);
		//logger.info("(log)BoardServiceImpl.searchSuggestion ����");
		return sList;
	}
	
	@Override
	public int updateSuggestionHit(SuggestionVO svo){
		//logger.info("(log)BoardServiceImpl.updateSuggestion ����");
		int iFlag = 0;
		iFlag = boardDao.updateSuggestionHit(svo);
		//logger.info("(log)BoardServiceImpl.updateSuggestion ����");
		return iFlag;
	}

	@Override
	public int updateSuggestion(SuggestionVO svo) {
		//logger.info("(log)BoardServiceImpl.updateSuggestion ����");
		int iFlag = 0;
		iFlag = boardDao.updateSuggestion(svo);
		//logger.info("(log)BoardServiceImpl.updateSuggestion ����");
		return iFlag;
	}

	@Override
	public int deleteSuggestion(SuggestionVO svo) {
		//logger.info("(log)BoardServiceImpl.deleteSuggestion ����");
		int iFlag = 0;
		iFlag = boardDao.deleteSuggestion(svo);
		//logger.info("(log)BoardServiceImpl.deleteSuggestion ����");
		return iFlag;
	}

	@Override
	public List<SuReplyVO> selectSuReply(SuReplyVO srvo) {
		//logger.info("(log)BoardServiceImpl.selectSuReply ����");
		List<SuReplyVO> sList = null;
		sList = boardDao.selectSuReply(srvo);
		//logger.info("(log)BoardServiceImpl.selectSuReply ����");
		return sList;
	}

	@Override
	public List<SuReplyVO> chaebunSuReply() {
		//logger.info("(log)BoardServiceImpl.chaebunSuReply ����");
		List<SuReplyVO> aList = null;
		aList = boardDao.chaebunSuReply();
		//logger.info("(log)BoardServiceImpl.chaebunSuReply ����");
		return aList;
	}

	@Override
	public int insertSuReply(SuReplyVO srvo) {
		//logger.info("(log)BoardServiceImpl.insertSuReply ����");
		int iFlag = 0;
		iFlag = boardDao.insertSuReply(srvo);
		//logger.info("(log)BoardServiceImpl.insertSuReply ����");
		return iFlag;
	}

	@Override
	public int updateSuReply(SuReplyVO srvo) {
		//logger.info("(log)BoardServiceImpl.updateSuReply ����");
		int iFlag = 0;
		iFlag = boardDao.updateSuReply(srvo);
		//logger.info("(log)BoardServiceImpl.updateSuReply ����");
		return iFlag;
	}

	@Override
	public int deleteSuReply(SuReplyVO srvo) {
		//logger.info("(log)BoardServiceImpl.deleteSuReply ����");
		int iFlag = 0;
		iFlag = boardDao.deleteSuReply(srvo);
		//logger.info("(log)BoardServiceImpl.deleteSuReply ����");
		return iFlag;
	}
	
	//------------------------���ǻ��� ���ƿ�------------------------
	
	@Override
	public List<SuLikeVO> chaebunSuLike() {
		//logger.info("(log)BoardServiceImpl.chaebunSuReply ����");
		List<SuLikeVO> aList = null;
		aList = boardDao.chaebunSuLike();
		//logger.info("(log)BoardServiceImpl.chaebunSuReply ����");
		return aList;
	}
	
	
	@Override
	public List<SuLikeVO> countSuLike(SuLikeVO slvo) {
		//logger.info("(log)BoardServiceImpl.countSuLike ����");
		List<SuLikeVO> sList = null;
		sList = boardDao.countSuLike(slvo);
		//logger.info("(log)BoardServiceImpl.countSuLike ����");
		return sList;
	}
	
	
	@Override
	public List<SuLikeVO> beforeSuLike(SuLikeVO slvo) {
		//logger.info("(log)BoardServiceImpl.beforeSuLike ����");
		List<SuLikeVO> sList = null;
		sList = boardDao.beforeSuLike(slvo);
		//logger.info("(log)BoardServiceImpl.beforeSuLike ����");
		return sList;
	}

	@Override
	public int checkSuLike(SuLikeVO slvo) {
		//logger.info("(log)BoardServiceImpl.checkSuLike ����");
		int iFlag = 0;
		iFlag = boardDao.checkSuLike(slvo);
		//logger.info("(log)BoardServiceImpl.checkSuLike ����");
		return iFlag;
	}

	@Override
	public int unCheckSuLike(SuLikeVO slvo) {
		//logger.info("(log)BoardServiceImpl.unCheckSuLike ����");
		int iFlag = 0;
		iFlag = boardDao.unCheckSuLike(slvo);
		//logger.info("(log)BoardServiceImpl.unCheckSuLike ����");
		return iFlag;
	}
	
	

	@Override
	public List<SuLikeVO> countSuDislike(SuLikeVO slvo) {
		//logger.info("(log)BoardServiceImpl.countSuDislike ����");
		List<SuLikeVO> sList = null;
		sList = boardDao.countSuDislike(slvo);
		//logger.info("(log)BoardServiceImpl.countSuDislike ����");
		return sList;
	}
	
	
	@Override
	public List<SuLikeVO> beforeSuDislike(SuLikeVO slvo) {
		//logger.info("(log)BoardServiceImpl.beforeSuDislike ����");
		List<SuLikeVO> sList = null;
		sList = boardDao.beforeSuDislike(slvo);
		//logger.info("(log)BoardServiceImpl.beforeSuDislike ����");
		return sList;
	}

	@Override
	public int checkSuDislike(SuLikeVO slvo) {
		//logger.info("(log)BoardServiceImpl.checkSuDislike ����");
		int iFlag = 0;
		iFlag = boardDao.checkSuDislike(slvo);
		//logger.info("(log)BoardServiceImpl.checkSuDislike ����");
		return iFlag;
	}

	@Override
	public int unCheckSuDislike(SuLikeVO slvo) {
		//logger.info("(log)BoardServiceImpl.unCheckSuDislike ����");
		int iFlag = 0;
		iFlag = boardDao.unCheckSuDislike(slvo);
		//logger.info("(log)BoardServiceImpl.unCheckSuDislike ����");
		return iFlag;
	}
	
}
