package java142.todak.scheduler.dao;

import java.util.List;
import java142.todak.scheduler.vo.CommuteVO;
import java142.todak.scheduler.vo.SchedulerVO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class SchedulerDaoImpl implements SchedulerDao {
	
	@Autowired //(required=false)
	private SqlSession session;
	
	/*근태 코드 시작*/
	@Override
	public boolean insertTAndA(CommuteVO cvo){
		int iCnt = (int)session.insert("insertTAndA");
		if(iCnt == 1)   return true;
		else return false;
	}
	
	
	
	@Override
	public boolean insertLastHour(CommuteVO cvo) throws Exception {
		int iCnt = (int)session.insert("insertLastHour");
		if(iCnt == 1)   return true;
		else return false;
	}



	@Override
	public boolean insertCommute(CommuteVO cvo) {
		int iCnt = (int)session.insert("insertCommute");
		if(iCnt == 1)   return true;
		else return false;
	}

	@Override
	public boolean updateCommute(CommuteVO cvo) throws Exception{
		
		int iCnt = (int)session.update("updateCommute");
		if(iCnt == 1)   return true;
		else return false;

	}
	
	@Override
	public boolean insertExtrawork(CommuteVO cvo) throws Exception{
		
		int iCnt = (int)session.insert("insertExtrawork");
		if(iCnt == 1)   return true;
		else return false;
	}


	@Override
	public List<CommuteVO> selectLastHour(CommuteVO cvo) {
		// TODO Auto-generated method stub
		return session.selectList("selectLastHour");
	}
	
	@Override
	public List<CommuteVO> selectCheabun(CommuteVO cvo) {
		return session.selectList("selectCheabun");
	}
	
	@Override
	public List<CommuteVO> selectCommute(CommuteVO cvo) {
		return session.selectList("selectCommute");
	}
	
	/*근태 코드 끝*/

	@Override
	public List<SchedulerVO> selectSchedulerWorkSchedule(SchedulerVO svo) {
		return session.selectList("selectSchedulerWorkSchedule");
	}

	@Override
	public int insertSchedulerWorkSchedule(SchedulerVO svo) {
		return session.insert("insertSchedulerWorkSchedule");
	}

	@Override
	public List<SchedulerVO> chaebunSchedulerWorkSchedule() {
		return session.selectList("chaebunSchedulerWorkSchedule");
	}

	@Override
	public int updateSchedulerWorkSchedule(SchedulerVO svo) {
		return session.update("updateSchedulerWorkSchedule");
	}

	@Override
	public int deleteSchedulerWorkSchedule(SchedulerVO svo) {
		return session.delete("deleteSchedulerWorkSchedule");
	}



}
