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
	public List<MemberVO> login(MemberVO mvo){
		return etcDao.login(mvo);
	}
	
}
