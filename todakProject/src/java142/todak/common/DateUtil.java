package java142.todak.common;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;

public abstract class DateUtil {
	
	static Logger logger = Logger.getLogger(DateUtil.class);
	
	public static String getDate() {
		//logger.info("(DateUtil)public static String getDate() ���� >>> ");
		
		Date date = new Date();
		//logger.info("  date : " + date);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		//logger.info("  sdf : " + sdf);
		
		sdf.format(date);
		//logger.info("  sdf.format(date) : " + sdf.format(date));
		
		//logger.info("(DateUtil)public static String getDate() �� >>> : " + sdf.format(date));
		return sdf.format(date);
	}
	
	public static String getFormat(String date) {
		//logger.info("(DateUtil)public static String getFormat() ���� >>> ");
	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/mm/dd");
		//logger.info("  sdf : " + sdf);
		
		sdf.format(date);
		//logger.info("  sdf.format(date) : " + sdf.format(date));
		
		//logger.info("(DateUtil)public static String getFormat() �� >>> : " + sdf.format(date));
		return sdf.format(date);
	}
	
}
