package java142.todak.common;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;

public abstract class ChaebunUtils{

	static Logger logger = Logger.getLogger(ChaebunUtils.class);

	public static String cNum(String cNum, String biz_gubun){

		//logger.info("(log)CheabunUtils 채번 진입");
		String ChaeNum=cNum;
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String date = sdf.format(d);
		ChaeNum = date+ChaeNum;
		ChaeNum = biz_gubun + ChaeNum;
		//logger.info("ChaeNum >>> : " + ChaeNum);
		
		//logger.info("(log)CheabunUtils 채번 종료");

		return ChaeNum;
	}
	
	public static String cNum2(String cNum, String biz_gubun){

		//logger.info("(log)CheabunUtils 채번 진입");
		String ChaeNum=cNum;
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		String date = sdf.format(d);
		ChaeNum = date+ChaeNum;
		ChaeNum = biz_gubun + ChaeNum;
		//logger.info("ChaeNum >>> : " + ChaeNum);
		
		//logger.info("(log)CheabunUtils 채번 종료");

		return ChaeNum;
	}
}