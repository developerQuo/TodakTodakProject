package java142.todak.etc.dao;

import java.util.List;

import java142.todak.human.vo.MemberVO;

public interface EtcDao {
	public List<MemberVO> login(MemberVO mvo);
}
