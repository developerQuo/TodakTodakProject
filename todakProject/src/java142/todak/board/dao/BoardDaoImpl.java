package java142.todak.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java142.todak.board.vo.NoCheckVO;
import java142.todak.board.vo.NoticeVO;
import java142.todak.board.vo.SuLikeVO;
import java142.todak.board.vo.SuReplyVO;
import java142.todak.board.vo.SuggestionVO;
import java142.todak.human.vo.MemberVO;

@Repository
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	private SqlSession session;

	@Override
	public List<NoticeVO> listNotice(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return  session.selectList("listNotice");
	}
	
	@Override
	public List<NoticeVO> searchNotice(NoticeVO nvo){
		return  session.selectList("searchNotice");
	}
	
	@Override
	public int updateNoticeHit(NoticeVO nvo){
		
		return (int)session.insert("updateNoticeHit");
		
	}
	@Override
	public int insertNotice(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return (int)session.insert("insertNotice");
	}

	@Override
	public List<NoticeVO> chaebunNotice() {
		// TODO Auto-generated method stub
		return session.selectList("chaebunNotice");
	}

	@Override
	public int updateNotice(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return (int)session.update("updateNotice");
	}

	@Override
	public int deleteNotice(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return (int)session.update("selectNotice");
	}

	@Override
	public List<MemberVO> selectWrite(MemberVO mvo) {
		// TODO Auto-generated method stub
		return session.selectOne("selectWrite", mvo);
	}

	@Override
	public int checkNotice(NoCheckVO ncvo){
		// TODO Auto-generated method stub
		return (int)session.insert("checkNotice", ncvo);
	}

	@Override
	public List<NoCheckVO> chaebunNoCheck() {
		return session.selectOne("chaebunNoCheck");
	}

	@Override
	public List<NoCheckVO> checkList(NoCheckVO ncvo) {
		// TODO Auto-generated method stub
		return session.selectList("checkList", ncvo);
	}

	/******************���⼭���� ���ǻ����Ѵٳ�**************************/
	
	@Override
	public List<SuggestionVO> selectSuggestion(SuggestionVO svo) {
		// TODO Auto-generated method stub
		return session.selectList("selectSuggestion");
	}

	@Override
	public List<SuggestionVO> searchSuggestion(SuggestionVO svo) {
		// TODO Auto-generated method stub
		return session.selectList("searchSuggestion");
	}
	@Override
	public int updateSuggestionHit(SuggestionVO svo){
		return (int)session.update("updateSuggestionHit");
	}
	
	@Override
	public List<SuggestionVO> chaebunSuggestion() {
		// TODO Auto-generated method stub
		return session.selectList("chaebunSuggestion");
	}

	@Override
	public int insertSuggestion(SuggestionVO svo) {
		// TODO Auto-generated method stub
		return(int)session.insert("insertSuggestion");
	}

	@Override
	public int updateSuggestion(SuggestionVO svo) {
		// TODO Auto-generated method stub
		return (int)session.update("updateSuggestion");
	}

	@Override
	public int deleteSuggestion(SuggestionVO svo) {
		// TODO Auto-generated method stub
		return (int)session.update("deleteSuggestion");
	}

	
	/******************���⼭���� ���ǻ��״��**************************/
	
	@Override
	public List<SuReplyVO> selectSuReply(SuReplyVO srvo) {
		// TODO Auto-generated method stub
		return session.selectList("selectSuReply", srvo);
	}

	@Override
	public List<SuReplyVO> chaebunSuReply() {
		// TODO Auto-generated method stub
		return session.selectOne("chaebunSuReply");
	}

	@Override
	public int insertSuReply(SuReplyVO srvo) {
		// TODO Auto-generated method stub
		return (int)session.insert("insertSuReply", srvo);
	}

	@Override
	public int updateSuReply(SuReplyVO srvo) {
		// TODO Auto-generated method stub
		return (int)session.update("updateSuReply", srvo);
	}

	@Override
	public int deleteSuReply(SuReplyVO srvo) {
		// TODO Auto-generated method stub
		return (int)session.delete("deleteSuReply", srvo);
	}

	
	/******************���⼭���� ���ǻ��� ���ƿ�**************************/
	
	@Override
	public List<SuLikeVO> chaebunSuLike() {
		return session.selectOne("chaebunSuLike");
	}

	
	@Override
	public List<SuLikeVO> countSuLike(SuLikeVO slvo) {
		return session.selectList("countSuLike");
	}
	
	@Override
	public List<SuLikeVO> beforeSuLike(SuLikeVO slvo) {
		return session.selectList("beforeSuLike");
	}
	
	@Override
	public int checkSuLike(SuLikeVO slvo) {
		return (int)session.insert("checkSuLike",slvo);
	}

	@Override
	public int unCheckSuLike(SuLikeVO slvo) {
		return (int)session.delete("unCheckSuLike",slvo);
	}
	
	
	
	@Override
	public List<SuLikeVO> countSuDislike(SuLikeVO slvo) {
		return session.selectList("countSuDislike");
	}
	
	@Override
	public List<SuLikeVO> beforeSuDislike(SuLikeVO slvo) {
		return session.selectList("beforeSuDislike");
	}
	
	@Override
	public int checkSuDislike(SuLikeVO slvo) {
		return (int)session.insert("checkSuDislike",slvo);
	}

	@Override
	public int unCheckSuDislike(SuLikeVO slvo) {
		return (int)session.delete("unCheckSuDislike",slvo);
	}


	
}
