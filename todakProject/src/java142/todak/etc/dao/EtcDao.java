package java142.todak.etc.dao;

import java.util.List;

import java142.todak.human.vo.MemberVO;

public interface EtcDao {
	public List<MemberVO> login(MemberVO mvo);
	public List<MemberVO> idEmailAuth(MemberVO hmvo);
	public List<MemberVO> pwEmailAuth(MemberVO hmvo);
	public boolean setNewPw(MemberVO hmvo);
}