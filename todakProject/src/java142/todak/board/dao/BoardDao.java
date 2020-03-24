package java142.todak.board.dao;

import java.util.List;
import java142.todak.board.vo.NoCheckVO;
import java142.todak.board.vo.NoticeVO;
import java142.todak.board.vo.SuLikeVO;
import java142.todak.board.vo.SuReplyVO;
import java142.todak.board.vo.SuggestionVO;
import java142.todak.human.vo.MemberVO;

public interface BoardDao {
	
	public List<NoticeVO> listNotice(NoticeVO nvo);
	public List<NoticeVO> searchNotice(NoticeVO nvo);
	public int insertNotice(NoticeVO nvo);
	public int updateNotice(NoticeVO nvo);	
	public int deleteNotice(NoticeVO nvo);
	
	//사용자 정보조회용 쿼리
	public List<MemberVO> selectWrite(MemberVO hvo);
	
	//공지사항 작성 채번
	public List<NoticeVO> chaebunNotice();

	//공지사항 확인 채번
	public List<NoCheckVO> chaebunNoCheck();
	//공지사항 확인 유무
	public int checkNotice(NoCheckVO ncvo);
	public List<NoCheckVO> checkList(NoCheckVO ncvo);

	
	public List<SuggestionVO> selectSuggestion(SuggestionVO svo);
	public List<SuggestionVO> searchSuggestion(SuggestionVO svo);
	public List<SuggestionVO> chaebunSuggestion();
	public int insertSuggestion(SuggestionVO svo);
	public int updateSuggestion(SuggestionVO svo);
	public int deleteSuggestion(SuggestionVO svo);
	
	/*건의 사항 댓글*/
	public List<SuReplyVO> selectSuReply(SuReplyVO srvo);
	public List<SuReplyVO> chaebunSuReply();
	public int insertSuReply(SuReplyVO srvo);
	public int updateSuReply(SuReplyVO srvo);
	public int deleteSuReply(SuReplyVO srvo);
	
	/*건의 사항 좋아요 */
	public List<SuLikeVO> chaebunSuLike();
	
	public List<SuLikeVO> beforeSuLike(SuLikeVO slvo);
	public List<SuLikeVO> countSuLike(SuLikeVO slvo);
	public int checkSuLike(SuLikeVO slvo);
	public int unCheckSuLike(SuLikeVO slvo);
	
	public List<SuLikeVO> beforeSuDislike(SuLikeVO slvo);
	public List<SuLikeVO> countSuDislike(SuLikeVO slvo);
	public int checkSuDislike(SuLikeVO slvo);
	public int unCheckSuDislike(SuLikeVO slvo);
	
}
