package java142.todak.human.dao;

import java.util.List;

import java142.todak.human.vo.HumanHdateVO;
import java142.todak.human.vo.HumanHolidayVO;

public interface HumanHdateDao {
	public List<HumanHdateVO> selectHumanhdate(HumanHdateVO hvo);
	public List<HumanHdateVO> chaebunHumanhdate();
	public int insertHumanhdate(HumanHdateVO hvo);
	public int updateHumanhdate(HumanHdateVO hvo);
	public int deleteHumanhdate(HumanHdateVO hvo);
	
	// 휴가조회 VO 
	public List<HumanHolidayVO> selectHumanHoliday(HumanHdateVO hvo);
}
