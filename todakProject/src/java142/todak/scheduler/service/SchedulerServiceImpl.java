package java142.todak.scheduler.service;

import java.util.List;
import java142.todak.scheduler.dao.SchedulerDao;
import java142.todak.scheduler.vo.CommuteVO;
import java142.todak.scheduler.vo.SchedulerVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SchedulerServiceImpl implements SchedulerService {
	Logger logger = Logger.getLogger(SchedulerServiceImpl.class);
	
	@Autowired
	private SchedulerDao schedulerDao;
	
	/*근태 코드 시작 */
	@Override
	public boolean insertExtrawork(CommuteVO cvo) throws Exception {
		//logger.info("SchedulerServiceImpl.insertExtrawork 진입");
		boolean result = false;
		result = schedulerDao.insertExtrawork(cvo);
		//logger.info("SchedulerServiceImpl.insertExtrawork 종료");
		return result;
	}

	@Override
	public boolean insertTAndA(CommuteVO cvo) throws Exception{
		//logger.info("SchedulerServiceImpl.insertTAndA 진입");
		boolean result = false;
		result = schedulerDao.insertTAndA(cvo);
		//logger.info("SchedulerServiceImpl.insertTAndA 종료");
		return result;
	}
	
	
	
	@Override
	public boolean insertLastHour(CommuteVO cvo) throws Exception {
		//logger.info("SchedulerServiceImpl.insertTAndA 진입");
		boolean result = false;
		result = schedulerDao.insertLastHour(cvo);
		//logger.info("SchedulerServiceImpl.insertTAndA 종료");
		return result;
	}

	@Override
	public boolean insertCommute(CommuteVO cvo) throws Exception{
		//logger.info("SchedulerServiceImpl.insertCommute 진입");
		boolean result = false;
		result = schedulerDao.insertCommute(cvo);
		//logger.info("SchedulerServiceImpl.insertCommute 종료");
		return result;
	}

	@Override
	public boolean updateCommute(CommuteVO cvo) throws Exception{
		//logger.info("SchedulerServiceImpl.updateCommute 진입");
		boolean result = false;
		result = schedulerDao.updateCommute(cvo);
		//logger.info("SchedulerServiceImpl.updateCommute 종료");
		return result;
	}

	@Override
	public List<CommuteVO> selectCheabun(CommuteVO cvo) {
		//logger.info("SchedulerServiceImpl.selectCheabun 진입");
		List<CommuteVO> cList = null;
		cList = schedulerDao.selectCheabun(cvo);
		//logger.info("SchedulerServiceImpl.selectCheabun 종료");
		return cList;
	}
	
	

	@Override
	public List<CommuteVO> selectCommute(CommuteVO cvo) {
		//logger.info("SchedulerServiceImpl.selectCommute 진입");
		List<CommuteVO> cList = null;
		cList = schedulerDao.selectCommute(cvo);
		//logger.info("SchedulerServiceImpl.selectCommute 종료");
		return cList;
	}
	
	

	@Override
	public List<CommuteVO> selectLastHour(CommuteVO cvo) {
		//logger.info("SchedulerServiceImpl.selectLastHour 진입");
		List<CommuteVO> cList = null;
		cList = schedulerDao.selectLastHour(cvo);
		//logger.info("SchedulerServiceImpl.selectLastHour 종료");
		return cList;
	}

	/*근태 코드 끝 */
	
	@Override
	public List<SchedulerVO> selectSchedulerWorkSchedule(SchedulerVO svo) {
		List<SchedulerVO> sl = null;
		sl = schedulerDao.selectSchedulerWorkSchedule(svo);
		return sl;
	}

	@Override
	public List<SchedulerVO> chaebunSchedulerWorkSchedule() {
		List<SchedulerVO> cb = null;
		cb = schedulerDao.chaebunSchedulerWorkSchedule();
		return cb;
	}

	@Override
	public int insertSchedulerWorkSchedule(SchedulerVO svo) {
		int result = 0;
		result = schedulerDao.insertSchedulerWorkSchedule(svo);
		return result;
	}

	@Override
	public int updateSchedulerWorkSchedule(SchedulerVO svo) {
		int result = 0;
		result = schedulerDao.updateSchedulerWorkSchedule(svo);
		return result;
	}

	@Override
	public int deleteSchedulerWorkSchedule(SchedulerVO svo) {
		int result = 0;
		result = schedulerDao.deleteSchedulerWorkSchedule(svo);
		return result;
	}

}
