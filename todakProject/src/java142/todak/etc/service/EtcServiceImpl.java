package java142.todak.etc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java142.todak.etc.dao.EtcDao;
import java142.todak.human.vo.MemberVO;

@Service
@Transactional
public class EtcServiceImpl implements EtcService {
	
	@Autowired
	private EtcDao etcDao;
	
	@Override
	public List<MemberVO> login(MemberVO hmvo){
		return etcDao.login(hmvo);
	}

	@Override
	public List<MemberVO> idEmailAuth(MemberVO hmvo){
		return etcDao.idEmailAuth(hmvo);
	}
	
	@Override
	public List<MemberVO> pwEmailAuth(MemberVO hmvo){
		return etcDao.pwEmailAuth(hmvo);
	}
	
	@Override
	public boolean setNewPw(MemberVO hmvo){
		return etcDao.setNewPw(hmvo);
	}
}