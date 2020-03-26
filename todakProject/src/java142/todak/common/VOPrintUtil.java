package java142.todak.common;

import org.apache.log4j.Logger;

import java142.todak.board.vo.NoCheckVO;
import java142.todak.board.vo.NoticeVO;
import java142.todak.board.vo.SuggestionVO;
import java142.todak.ework.vo.ApprovalVO;
import java142.todak.ework.vo.AuthPersonVO;
import java142.todak.ework.vo.HolidayVO;
import java142.todak.ework.vo.ProposalVO;
import java142.todak.ework.vo.SelectAuthBoxVO;
import java142.todak.human.vo.MemberVO;
import java142.todak.scheduler.vo.CommuteVO;

public abstract class VOPrintUtil {
	
	static Logger logger = Logger.getLogger(VOPrintUtil.class);
	
	//-----------------게시판---------------------
	
	public static void noticeVOPrint(NoticeVO nvo){
		//logger.info("nvo.getBn_num()>>>"+nvo.getBn_num());
		//logger.info("nvo.getHm_empnum()>>>"+nvo.getHm_empnum());
		//logger.info("nvo.getHm_name()>>>"+nvo.getHm_name());
		//logger.info("nvo.getHm_duty()>>>"+nvo.getHm_duty());
		//logger.info("nvo.getBn_deptnum()>>>"+nvo.getBn_deptnum());
		//logger.info("nvo.getBn_deptnum()>>>"+nvo.getBn_divnum());
		//logger.info("nvo.getBn_title()>>>"+nvo.getBn_title());
		//logger.info("nvo.getBn_content()>>>"+nvo.getBn_content());
		//logger.info("nvo.getBn_image()>>>"+nvo.getBn_image());
		//logger.info("nvo.getBn_file()>>>"+nvo.getBn_file());
		//logger.info("nvo.getBn_deleteYN()>>>"+nvo.getBn_deleteYN());
		//logger.info("nvo.getBn_insertdate()>>>"+nvo.getBn_insertdate());
		//logger.info("nvo.getBn_updatedate()>>>"+nvo.getBn_updatedate());
		
	}
	
	public static void noCheckVOPrint(NoCheckVO ncvo){
		//logger.info("ncvo.getBn_num()>>>"+ncvo.getBn_num());
		//logger.info("ncvo.getHm_empnum()>>>"+ncvo.getHm_empnum());
		//logger.info("ncvo.getHm_name()>>>"+ncvo.getHm_name());
		//logger.info("ncvo.getBn_checknum()>>>"+ncvo.getBn_checknum());
		//logger.info("ncvo.getHm_deptnum()>>>"+ncvo.getHm_deptnum());

		}
	
	public static void selectWriteVOPrint(MemberVO mvo){
		//logger.info("mvo.getHm_duty()>>>"+mvo.getHm_duty());
		//logger.info("mvo.getHm_name()>>>"+mvo.getHm_name());
		//logger.info("mvo.getHm_deptnum()>>>"+mvo.getHm_deptnum());
	}
		
		
		public static void suggestionVOPrint(SuggestionVO svo){
			//logger.info("svo.getBs_num()>>>"+svo.getBs_num());
			//logger.info("svo.getHm_empnum()>>>"+svo.getHm_empnum());
			//logger.info("svo.getBs_title()>>>"+svo.getBs_title());
			//logger.info("svo.getBs_content()>>>"+svo.getBs_content());
			//logger.info("svo.getBs_image()>>>"+svo.getBs_image());
			//logger.info("svo.getBs_insertdate()>>>"+svo.getBs_insertdate());
			//logger.info("svo.getBs_updatedate()>>>"+svo.getBs_updatedate());
			

	}
		
		public static void commuteVOPrint(CommuteVO cvo){
			//logger.info("cvo.getHc_comnum()>>>"+cvo.getHc_comnum());

			//logger.info("cvo.getHm_empnum()>>>"+cvo.getHm_empnum());
			//logger.info("cvo.getHm_name()>>>"+cvo.getHm_name());
			//logger.info("cvo.getHm_deptnum()>>>"+cvo.getHm_deptnum());
			//logger.info("cvo.getHc_date()>>>"+cvo.getHc_date());
			//logger.info("cvo.getHc_workin()>>>"+cvo.getHc_workin());
			//logger.info("cvo.getHc_workout()>>>"+cvo.getHc_workout());
			//logger.info("cvo.getHc_dayhour()>>>"+cvo.getHc_dayhour());
			//logger.info("cvo.getHc_weekhour()>>>"+cvo.getHc_weekhour());
			//logger.info("cvo.getHc_lasthour()>>>"+cvo.getHc_lasthour());
			//logger.info("cvo.getHc_totalhour()>>>"+cvo.getHc_totalhour());
			//logger.info("cvo.getHc_extraworking()>>>"+cvo.getHc_extraworking());
			//logger.info("cvo.getHc_tAndA()>>>"+cvo.getHc_tAndA());
			
			
			
		}
		
		//-----------------전자결재---------------------
		
		public static void printVO(ProposalVO pvo) {
			//logger.info("  getEp_num()>>>" + pvo.getEp_num());
			//logger.info("  getEa_num()>>>" + pvo.getEa_num());
			//logger.info("  getEp_title()>>>" + pvo.getEp_title());
			//logger.info("  getHm_empnum()>>>" + pvo.getHm_empnum());
			//logger.info("  getEp_writer()>>>" + pvo.getEp_writer());
			//logger.info("  getHm_position()>>>" + pvo.getHm_position());
			//logger.info("  getEp_startdate()>>>" + pvo.getEp_startdate());
			//logger.info("  getEp_enddate()>>>" + pvo.getEp_enddate());
			//logger.info("  getEp_group()>>>" + pvo.getEp_group());
			//logger.info("  getEp_content()>>>" + pvo.getEp_content());
			//logger.info("  getEp_insertdate()>>>" + pvo.getEp_insertdate());
			//logger.info("  getEp_updatedate()>>>" + pvo.getEp_updatedate());
			//logger.info("  getEp_deleteYN()>>>" + pvo.getEp_deleteYN());
		} //end of printVO method
		
		public static void printVO(ApprovalVO avo) {
			//logger.info("  getEap_num()>>>" + avo.getEap_num());
			//logger.info("  getEa_num()>>>" + avo.getEa_num());
			//logger.info("  getEf_num()>>>" + avo.getEf_num());
			//logger.info("  getEap_title()>>>" + avo.getEap_title());
			//logger.info("  getHm_empnum()>>>" + avo.getHm_empnum());
			//logger.info("  getEap_writer()>>>" + avo.getEap_writer());
			//logger.info("  getHm_position()>>>" + avo.getHm_position());
			//logger.info("  getEap_startdate()>>>" + avo.getEap_startdate());
			//logger.info("  getEap_enddate()>>>" + avo.getEap_enddate());
			//logger.info("  getEap_group()>>>" + avo.getEap_group());
			//logger.info("  getEap_filedir()>>>" + avo.getEap_filedir());
			//logger.info("  getEap_insertdate()>>>" + avo.getEap_insertdate());
			//logger.info("  getEap_updatedate()>>>" + avo.getEap_updatedate());
			//logger.info("  getEap_deleteYN()>>>" + avo.getEap_deleteYN());
		} //end of printVO method

		public static void printVO(AuthPersonVO apvo) {
			//logger.info("  getEai_num()>>>" + apvo.getEai_num());
			//logger.info("  getEa_num()>>>" + apvo.getEa_num());
			//logger.info("  getEai_recentnum()>>>" + apvo.getEai_recentnum());
			//logger.info("  getEai_position()>>>" + apvo.getEai_position());
			//logger.info("  getEai_auth()>>>" + apvo.getEai_auth());
			//logger.info("  getEai_filedir()>>>" + apvo.getEai_filedir());
			//logger.info("  getEai_substituteYN()>>>" + apvo.getEai_substituteYN());
			//logger.info("  getEai_subsitutenum()>>>" + apvo.getEai_substitutenum());
			//logger.info("  getEai_sequence()>>>" + apvo.getEai_sequence());
		}
		
		public static void printVO(HolidayVO hvo) {
			//logger.info("  getEh_num()>>>" + hvo.getEh_num());
			//logger.info("  getEa_num()>>>" + hvo.getEa_num());
			//logger.info("  getEh_title()>>>" + hvo.getEh_title());
			//logger.info("  getHm_empnum()>>>" + hvo.getHm_empnum());
			//logger.info("  getEh_writer()>>>" + hvo.getEh_writer());
			//logger.info("  getHm_position()>>>" + hvo.getHm_position());
			//logger.info("  getEh_startdate()>>>" + hvo.getEh_startdate());
			//logger.info("  getEh_enddate()>>>" + hvo.getEh_enddate());
			//logger.info("  getEh_group()>>>" + hvo.getEh_group());
			//logger.info("  getEh_sort()>>>" + hvo.getEh_sort());
			//logger.info("  getEh_reason()>>>" + hvo.getEh_reason());
			//logger.info("  getEh_startperiod()>>>" + hvo.getEh_startperiod());
			//logger.info("  getEh_endperiod()>>>" + hvo.getEh_endperiod());
			//logger.info("  getEh_emergency()>>>" + hvo.getEh_emergency());
			//logger.info("  getEh_insertdate()>>>" + hvo.getEh_insertdate());
			//logger.info("  getEh_updatedate()>>>" + hvo.getEh_updatedate());
			//logger.info("  getEh_deleteYN()>>>" + hvo.getEh_deleteYN());
		}
		
		public static void printVO(SelectAuthBoxVO sabvo) {
			//logger.info("  getEab_num()>>>" + sabvo.getEab_num());
			//logger.info("  getEa_num()>>>" + sabvo.getEa_num());
			//logger.info("  getEab_writer()>>>" + sabvo.getEab_writer());
			//logger.info("  getEab_title()>>>" + sabvo.getEab_title());
			//logger.info("  getEab_startdate()>>>" + sabvo.getEab_startdate());
			//logger.info("  getEab_enddate()>>>" + sabvo.getEab_enddate());
			//logger.info("  getEl_line()>>>" + sabvo.getEl_line());
			//logger.info("  getEa_presentnum()>>>" + sabvo.getEa_presentnum());
			//logger.info("  getEai_substitutenum()>>>" + sabvo.getEai_substitutenum());
			//logger.info("  getEab_group()>>>" + sabvo.getEab_group());
			//logger.info("  getEab_insertdate()>>>" + sabvo.getEab_insertdate());
			//logger.info("  getEab_updatedate()>>>" + sabvo.getEab_updatedate());
			//logger.info("  getEab_deleteYN()>>>" + sabvo.getEab_deleteYN());

		}
		
}
