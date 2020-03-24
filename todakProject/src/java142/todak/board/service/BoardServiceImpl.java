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
		logger.info("(log)BoardServiceImpl.selectNotice 진입");
		List<NoticeVO> sList = null;
		sList = boardDao.listNotice(nvo);
		logger.info("(log)BoardServiceImpl.selectNotice 종료");
		return sList;
	}
	
	@Override
	public List<NoticeVO> searchNotice(NoticeVO nvo){
		logger.info("(log)BoardServiceImpl.searchNotice 진입");
		List<NoticeVO> sList = null;
		sList = boardDao.searchNotice(nvo);
		logger.info("(log)BoardServiceImpl.searchNotice 종료");
		return sList;
	}

	@Override
	public int insertNotice(NoticeVO nvo) {
		logger.info("(log)BoardServiceImpl.insertNotice 진입");
		int iFlag = 0;
		iFlag = boardDao.insertNotice(nvo);
		logger.info("(log)BoardServiceImpl.insertNotice 종료");
		return iFlag;
	}

	@Override
	public List<NoticeVO> chaebunNotice() {
		logger.info("(log)BoardServiceImpl.cheabunNotice 진입");
		List<NoticeVO> aList =  null;
		aList = boardDao.chaebunNotice();
		logger.info("aList >>>> : " + aList.get(0).getBn_num());
		logger.info("(log)BoardServiceImpl.cheabunNotice 종료");
		return aList;
	}

	@Override
	public int updateNotice(NoticeVO nvo) {
		logger.info("(log)BoardServiceImpl.updateNotice 진입");
		int iFlag = 0;
		iFlag =  boardDao.updateNotice(nvo);
		logger.info("(log)BoardServiceImpl.updateNotice 종료");
		return iFlag;
	}

	@Override
	public int deleteNotice(NoticeVO nvo) {
		logger.info("(log)BoardServiceImpl.deleteNotice 진입");
		int iFlag = 0;
		iFlag = boardDao.deleteNotice(nvo);
		logger.info("(log)BoardServiceImpl.deleteNotice 종료");
		return iFlag;
	}

	//글쓰기 권한보기
	@Override
	public List<MemberVO> selectWrite(MemberVO mvo) {
		logger.info("(log)BoardServiceImpl.selectWrite 진입");
		List<MemberVO> sList = null;
		sList = boardDao.selectWrite(mvo);
		logger.info("(log)BoardServiceImpl.selectWrite 종료");
		
		return sList;
	}

	
	@Override
	public int checkNotice(NoCheckVO ncvo) {
		logger.info("(log)BoardServiceImpl.checkNotice 진입");
		int iFlag = 0;
		iFlag = boardDao.checkNotice(ncvo);
		logger.info("(log)BoardServiceImpl.checkNotice 종료");
		return iFlag;
	}

	@Override
	public List<NoCheckVO> chaebunNoCheck() {
		logger.info("(log)BoardServiceImpl.chaebunNoCheck 진입");
		List<NoCheckVO> cList = null;
		cList = boardDao.chaebunNoCheck();
		logger.info("(log)BoardServiceImpl.chaebunNoCheck 종료");
		return cList;
	}

	
	@Override
	public List<NoCheckVO> checkList(NoCheckVO ncvo) {
		logger.info("(log)BoardServiceImpl.checkList 진입");
		List<NoCheckVO>  cList = null;
		cList = boardDao.checkList(ncvo);
		logger.info("(log)BoardServiceImpl.checkList 종료");
		return cList;
	}


	 
	
	//---------------------------건의사항게시판------------------------------
	
	@Override
	public List<SuggestionVO> selectSuggestion(SuggestionVO svo) {
		logger.info("(log)BoardServiceImpl.selectSuggestion 진입");
		List<SuggestionVO> sList = null;
		sList = boardDao.selectSuggestion(svo);
		logger.info("(log)BoardServiceImpl.selectSuggestion 종료");
		return sList;
	}

	@Override
	public List<SuggestionVO> cheabunSuggestion() {
		logger.info("(log)BoardServiceImpl.cheabunSuggestion 진입");
		List<SuggestionVO> aList = null;
		aList = boardDao.chaebunSuggestion();
		logger.info("(log)BoardServiceImpl.cheabunSuggestion 종료");
		return aList;
	}

	@Override
	public int insertSuggestion(SuggestionVO svo) {
		logger.info("(log)BoardServiceImpl.insertSuggestion 진입");
		int iFlag = 0;
		iFlag = boardDao.insertSuggestion(svo);
		logger.info("(log)BoardServiceImpl.insertSuggestion 종료");
		return iFlag;
	}

	@Override
	public List<SuggestionVO> searchSuggestion(SuggestionVO svo) {
		logger.info("(log)BoardServiceImpl.searchSuggestion 진입");
		List<SuggestionVO> sList = null;
		sList = boardDao.searchSuggestion(svo);
		logger.info("(log)BoardServiceImpl.searchSuggestion 종료");
		return sList;
	}

	@Override
	public int updateSuggestion(SuggestionVO svo) {
		logger.info("(log)BoardServiceImpl.updateSuggestion 진입");
		int iFlag = 0;
		iFlag = boardDao.updateSuggestion(svo);
		logger.info("(log)BoardServiceImpl.updateSuggestion 종료");
		return iFlag;
	}

	@Override
	public int deleteSuggestion(SuggestionVO svo) {
		logger.info("(log)BoardServiceImpl.deleteSuggestion 진입");
		int iFlag = 0;
		iFlag = boardDao.deleteSuggestion(svo);
		logger.info("(log)BoardServiceImpl.deleteSuggestion 종료");
		return iFlag;
	}

	@Override
	public List<SuReplyVO> selectSuReply(SuReplyVO srvo) {
		logger.info("(log)BoardServiceImpl.selectSuReply 진입");
		List<SuReplyVO> sList = null;
		sList = boardDao.selectSuReply(srvo);
		logger.info("(log)BoardServiceImpl.selectSuReply 종료");
		return sList;
	}

	@Override
	public List<SuReplyVO> chaebunSuReply() {
		logger.info("(log)BoardServiceImpl.chaebunSuReply 진입");
		List<SuReplyVO> aList = null;
		aList = boardDao.chaebunSuReply();
		logger.info("(log)BoardServiceImpl.chaebunSuReply 종료");
		return aList;
	}

	@Override
	public int insertSuReply(SuReplyVO srvo) {
		logger.info("(log)BoardServiceImpl.insertSuReply 진입");
		int iFlag = 0;
		iFlag = boardDao.insertSuReply(srvo);
		logger.info("(log)BoardServiceImpl.insertSuReply 종료");
		return iFlag;
	}

	@Override
	public int updateSuReply(SuReplyVO srvo) {
		logger.info("(log)BoardServiceImpl.updateSuReply 진입");
		int iFlag = 0;
		iFlag = boardDao.updateSuReply(srvo);
		logger.info("(log)BoardServiceImpl.updateSuReply 종료");
		return iFlag;
	}

	@Override
	public int deleteSuReply(SuReplyVO srvo) {
		logger.info("(log)BoardServiceImpl.deleteSuReply 진입");
		int iFlag = 0;
		iFlag = boardDao.deleteSuReply(srvo);
		logger.info("(log)BoardServiceImpl.deleteSuReply 종료");
		return iFlag;
	}
	
	//------------------------건의사항 좋아요------------------------
	
	@Override
	public List<SuLikeVO> chaebunSuLike() {
		logger.info("(log)BoardServiceImpl.chaebunSuReply 진입");
		List<SuLikeVO> aList = null;
		aList = boardDao.chaebunSuLike();
		logger.info("(log)BoardServiceImpl.chaebunSuReply 종료");
		return aList;
	}
	
	
	@Override
	public List<SuLikeVO> countSuLike(SuLikeVO slvo) {
		logger.info("(log)BoardServiceImpl.countSuLike 진입");
		List<SuLikeVO> sList = null;
		sList = boardDao.countSuLike(slvo);
		logger.info("(log)BoardServiceImpl.countSuLike 종료");
		return sList;
	}
	
	
	@Override
	public List<SuLikeVO> beforeSuLike(SuLikeVO slvo) {
		logger.info("(log)BoardServiceImpl.beforeSuLike 진입");
		List<SuLikeVO> sList = null;
		sList = boardDao.beforeSuLike(slvo);
		logger.info("(log)BoardServiceImpl.beforeSuLike 종료");
		return sList;
	}

	@Override
	public int checkSuLike(SuLikeVO slvo) {
		logger.info("(log)BoardServiceImpl.checkSuLike 진입");
		int iFlag = 0;
		iFlag = boardDao.checkSuLike(slvo);
		logger.info("(log)BoardServiceImpl.checkSuLike 종료");
		return iFlag;
	}

	@Override
	public int unCheckSuLike(SuLikeVO slvo) {
		logger.info("(log)BoardServiceImpl.unCheckSuLike 진입");
		int iFlag = 0;
		iFlag = boardDao.unCheckSuLike(slvo);
		logger.info("(log)BoardServiceImpl.unCheckSuLike 종료");
		return iFlag;
	}
	
	

	@Override
	public List<SuLikeVO> countSuDislike(SuLikeVO slvo) {
		logger.info("(log)BoardServiceImpl.countSuDislike 진입");
		List<SuLikeVO> sList = null;
		sList = boardDao.countSuDislike(slvo);
		logger.info("(log)BoardServiceImpl.countSuDislike 종료");
		return sList;
	}
	
	
	@Override
	public List<SuLikeVO> beforeSuDislike(SuLikeVO slvo) {
		logger.info("(log)BoardServiceImpl.beforeSuDislike 진입");
		List<SuLikeVO> sList = null;
		sList = boardDao.beforeSuDislike(slvo);
		logger.info("(log)BoardServiceImpl.beforeSuDislike 종료");
		return sList;
	}

	@Override
	public int checkSuDislike(SuLikeVO slvo) {
		logger.info("(log)BoardServiceImpl.checkSuDislike 진입");
		int iFlag = 0;
		iFlag = boardDao.checkSuDislike(slvo);
		logger.info("(log)BoardServiceImpl.checkSuDislike 종료");
		return iFlag;
	}

	@Override
	public int unCheckSuDislike(SuLikeVO slvo) {
		logger.info("(log)BoardServiceImpl.unCheckSuDislike 진입");
		int iFlag = 0;
		iFlag = boardDao.unCheckSuDislike(slvo);
		logger.info("(log)BoardServiceImpl.unCheckSuDislike 종료");
		return iFlag;
	}
	
}
