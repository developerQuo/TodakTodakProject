package java142.todak.scheduler.utils;

import java.util.List;
import java142.todak.scheduler.vo.SchedulerVO;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class JsonUtil {
	
	
	public static JSONArray jsonSelectSchedule(List<SchedulerVO> svo,String result) throws Exception{
		//System.out.println("JsonUtil.jsonSelectSchedule 함수 진입 >>>> ");
		//System.out.println("[JSON Util] svo >>>>>>>>>>>>>>>>>: " +svo);
		JSONArray jsonArray = null;
		JSONObject jsonObject = null;
		SchedulerVO scvo = null;
		scvo = new SchedulerVO();
		jsonArray = new JSONArray();	

		try{
			int svoSize = svo.size();
			//System.out.println("svoSize : " + svoSize);
			for(int i=0; i<svoSize; i++){
				jsonObject = new JSONObject();
				scvo = svo.get(i);
				//System.out.println("[JSON Util] scvo >>>> : " + scvo);
				
				jsonObject.put("_id",scvo.getSw_num());
				jsonObject.put("title",scvo.getSw_title());
				jsonObject.put("start",scvo.getSw_startdate());
				jsonObject.put("end",scvo.getSw_enddate());
				jsonObject.put("description",scvo.getSw_content());
				jsonObject.put("type",scvo.getSw_type());
				// 접속한 사람과 입력한 데이터의 hm_empnum 값을 비교 / 동일할때만 화면에 렌더링
				if(scvo.getHm_empnum().equals(scvo.getHm_empnum())){
					jsonObject.put("username",scvo.getHm_empnum());	
				}
				jsonObject.put("backgroundColor",scvo.getSw_backgroundcolor());
				jsonObject.put("textColor",scvo.getSw_textcolor());
				
				//System.out.println("_id >>> : " + scvo.getSw_num());
				//System.out.println("title >>> : " + scvo.getSw_title());
				//System.out.println("start >>> : " + scvo.getSw_startdate());
				//System.out.println("end >>> : " + scvo.getSw_enddate());
				//System.out.println("description >>> : " + scvo.getSw_content());
				//System.out.println("type >>> : " + scvo.getSw_type());
				//System.out.println("username >>> : " + scvo.getHm_empnum());
				//System.out.println("backgroundColor >>> : " + scvo.getSw_backgroundcolor());
				//System.out.println("textColor >>> : " + scvo.getSw_textcolor());
				
				if(scvo.getSw_repetitiontype().toLowerCase().equals("true")){
					jsonObject.put("allDay", scvo.getSw_repetitiontype());
					//System.out.println("[JSONUTIL true]" + scvo.getSw_repetitiontype());
				}else{
					String bool = scvo.getSw_repetitiontype();
					if(!bool.equals("true")){
						bool = "false";
					}
					jsonObject.put("allDay", bool);
					//System.out.println("[JSONUTIL false]" + scvo.getSw_repetitiontype());
				}
					
				jsonArray.add(jsonObject);
				
			}
		}catch(Exception e){
			//System.out.println("JsonUtil error >>> : " + e.getMessage());
		}
	
		//System.out.println("JsonUtil.jsonSelectSchedule 함수 탈출 <<<< ");
		
		return jsonArray;
		
	}// end of jsonSelectSchedule()
}// end of JSonTest class
