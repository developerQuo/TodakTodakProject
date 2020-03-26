package java142.todak.board.service;

import java.util.List;
import java142.todak.board.vo.NoCheckVO;
import java142.todak.board.vo.NoticeVO;
import java142.todak.board.vo.SuLikeVO;
import java142.todak.board.vo.SuReplyVO;
import java142.todak.board.vo.SuggestionVO;
import java142.todak.human.vo.MemberVO;

public interface BoardService {

	public List<NoticeVO> selectNotice(NoticeVO nvo);
	public List<NoticeVO> searchNotice(NoticeVO nvo);
	public int insertNotice(NoticeVO nvo);
	public int updateNotice(NoticeVO nvo);
	public int deleteNotice(NoticeVO nvo);
	public int updateNoticeHit(NoticeVO nvo);
	
	//�۾��� ���Ѻ���
	public List<MemberVO> selectWrite(MemberVO mvo);
	
	//�������� �ۼ��� ä��
	public List<NoticeVO> chaebunNotice();
	
	//---------------------------Ȯ�ι�ư------------------------------
	public int checkNotice(NoCheckVO ncvo);
	public List<NoCheckVO> checkList(NoCheckVO ncvo);
	public List<NoCheckVO> chaebunNoCheck(); 
	
	//---------------------------���ǻ��װԽ���------------------------------
	public List<SuggestionVO> selectSuggestion(SuggestionVO svo);
	public List<SuggestionVO> searchSuggestion(SuggestionVO svo);
	public List<SuggestionVO> cheabunSuggestion();
	public int updateSuggestionHit(SuggestionVO svo);
	public int insertSuggestion(SuggestionVO svo);
	public int updateSuggestion(SuggestionVO svo);
	public int deleteSuggestion(SuggestionVO svo);
	
	/*���ǻ��� ���*/
	
	public List<SuReplyVO> selectSuReply(SuReplyVO srvo);
	public List<SuReplyVO> chaebunSuReply();
	public int insertSuReply(SuReplyVO srvo);
	public int updateSuReply(SuReplyVO srvo);
	public int deleteSuReply(SuReplyVO srvo);
	
	/*���ǻ��� ���ƿ�*/
	
	public List<SuLikeVO> chaebunSuLike();
	
	public List<SuLikeVO> countSuLike(SuLikeVO slvo);
	public List<SuLikeVO> beforeSuLike(SuLikeVO slvo);
	public int checkSuLike(SuLikeVO slvo);
	public int unCheckSuLike(SuLikeVO slvo);
	
	public List<SuLikeVO> beforeSuDislike(SuLikeVO slvo);
	public List<SuLikeVO> countSuDislike(SuLikeVO slvo);
	public int checkSuDislike(SuLikeVO slvo);
	public int unCheckSuDislike(SuLikeVO slvo);
}
