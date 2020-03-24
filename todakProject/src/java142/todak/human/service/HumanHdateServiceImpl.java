package java142.todak.human.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java142.todak.human.dao.HumanHdateDao;
import java142.todak.human.vo.HumanHdateVO;
import java142.todak.human.vo.HumanHolidayVO;

@Service
@Transactional
public class HumanHdateServiceImpl implements HumanHdateService {
	Logger logger = Logger.getLogger(HumanHdateServiceImpl.class);
	
	@Autowired
	private HumanHdateDao humanHdateDao;

	@Override
	public List<HumanHdateVO> selectHumanhdate(HumanHdateVO hvo) {
		List<HumanHdateVO> sList = null;
		sList = humanHdateDao.selectHumanhdate(hvo);
		return sList;
	}

	@Override
	public List<HumanHdateVO> chaebunHumanhdate() {
		List<HumanHdateVO> cList = null;
		cList = humanHdateDao.chaebunHumanhdate();
		return cList;
	}

	@Override
	public int insertHumanhdate(HumanHdateVO hvo) {
		int result = 0;
		result = humanHdateDao.insertHumanhdate(hvo);
		return result;
	}

	@Override
	public int updateHumanhdate(HumanHdateVO hvo) {
		int result = 0;
		result = humanHdateDao.updateHumanhdate(hvo);
		return result;
	}

	@Override
	public int deleteHumanhdate(HumanHdateVO hvo) {
		int result = 0;
		result = humanHdateDao.deleteHumanhdate(hvo);
		return result;
	}

	@Override
	public List<HumanHolidayVO> selectHumanHoliday(HumanHdateVO hvo) {
		List<HumanHolidayVO> hList = null;
		hList = humanHdateDao.selectHumanHoliday(hvo);
		return hList;
	}

}
