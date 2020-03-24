package java142.todak.scheduler.dao;

import java.util.List;
import java142.todak.scheduler.vo.CommuteVO;
import java142.todak.scheduler.vo.SchedulerVO;

public interface SchedulerDao {
	
	/*근태 코드 시작 */
	public boolean insertTAndA(CommuteVO cvo)throws Exception;
	public boolean insertCommute(CommuteVO cvo)throws Exception;
	public boolean insertLastHour(CommuteVO cvo)throws Exception;
	
	public boolean updateCommute(CommuteVO cvo) throws Exception;
	public boolean insertExtrawork(CommuteVO cvo) throws Exception;
	
	public List<CommuteVO> selectCheabun(CommuteVO cvo);
	public List<CommuteVO> selectCommute(CommuteVO cvo);
	public List<CommuteVO> selectLastHour(CommuteVO cvo);
	/*근태 코드 끝 */
	
	public List<SchedulerVO> selectSchedulerWorkSchedule(SchedulerVO svo);
	public List<SchedulerVO> chaebunSchedulerWorkSchedule();
	public int insertSchedulerWorkSchedule(SchedulerVO svo);
	public int updateSchedulerWorkSchedule(SchedulerVO svo);
	public int deleteSchedulerWorkSchedule(SchedulerVO svo);

}
