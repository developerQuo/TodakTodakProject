package java142.todak.human.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java142.todak.human.vo.HumanHdateVO;
import java142.todak.human.vo.HumanHolidayVO;

@Repository
public class HumanHdateDaoImpl implements HumanHdateDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public List<HumanHdateVO> selectHumanhdate(HumanHdateVO hvo) {
		return session.selectList("selectHumanhdate");
	}

	@Override
	public List<HumanHdateVO> chaebunHumanhdate() {		
		return session.selectList("chaebunHumanhdate");
	}

	@Override
	public int insertHumanhdate(HumanHdateVO hvo) {
		return session.insert("insertHumanhdate");
	}

	@Override
	public int updateHumanhdate(HumanHdateVO hvo) {	
		return session.update("updateHumanhdate");
	}

	@Override
	public int deleteHumanhdate(HumanHdateVO hvo) {
		return session.delete("deleteHumanhdate");
	}

	@Override
	public List<HumanHolidayVO> selectHumanHoliday(HumanHdateVO hvo) {
		return session.selectList("selectHumanHoliday");
	}

}
