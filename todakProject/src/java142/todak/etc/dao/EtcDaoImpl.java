package java142.todak.etc.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java142.todak.human.vo.MemberVO;

@Repository
public class EtcDaoImpl implements EtcDao {
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<MemberVO> login(MemberVO mvo){
		return session.selectOne("login", mvo);
	}
}
