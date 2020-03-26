package java142.todak.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java142.todak.ework.controller.EworkController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class FileReadUtil {
	static Logger logger = Logger.getLogger(EworkController.class);
	
	public static void readFile(HttpServletRequest request
			                   ,HttpServletResponse response) throws IOException
	{
		
		//logger.info("(log)readFile 진입");
		request.setCharacterEncoding("UTF-8");
		String fileName = (String)request.getAttribute("fileName");
		String filePath = (String)request.getAttribute("filePath");
		
		//logger.info("fileName/ filePath >>> : " + fileName + " / " + filePath);
		
		String realFilePath = filePath  + "//" + fileName;
		
		//logger.info("newFilePath >>> : " + realFilePath);
		
		File file = new File(realFilePath);
		if (file.isDirectory()){
			return;
		}
		
		long fileSize = file.length();
		//logger.info(" fileSize >>> : " + fileSize ); 
		
		if (fileSize > Integer.MAX_VALUE){
			//System.out.println("File size is too big. >>> : ");
			return;
		}
		
		 // mimetype
		String mimeType;
		String disposition = "filename=\"" + realFilePath + "\"";
		if(realFilePath.toLowerCase().endsWith("xml")){
			mimeType = "text/xml;charset=UTF-8";
		}else if(realFilePath.toLowerCase().endsWith("doc")){
			mimeType = "application/msword";
		}else if(realFilePath.toLowerCase().endsWith("xls")){
			mimeType = "application/vnd.ms-excel";
		}else if(realFilePath.toLowerCase().endsWith("xlsx")){
			mimeType = "application/x-msexcel";
		}else if(realFilePath.toLowerCase().endsWith("hwp")){
			mimeType = "application/x-hwp";
		}else if(realFilePath.toLowerCase().endsWith("pdf")){
			mimeType = "application/pdf";
		}else if(realFilePath.toLowerCase().endsWith("gif")){
			mimeType = "image/gif";
		}else if(realFilePath.toLowerCase().endsWith("jpg")){			
			mimeType = "image/jpeg";
		}else if(realFilePath.toLowerCase().endsWith("png")){			
			mimeType = "image/png";
		}else if(realFilePath.toLowerCase().endsWith("jpeg")){			
			mimeType = "image/jpeg";
		}else{
			mimeType = "application/octet-stream";
		}
		
		response.setBufferSize(0);
	
		fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); //파일이름만 utf-8로 인코딩
		
		response.setHeader("Content-Disposition","attachment; filename=" + fileName + ";");
		
		response.setHeader("Content-Transfer-Encoding", "7bit");
		response.setHeader("Accept-Ranges", "bytes");
		response.setContentLength((int)fileSize);
		response.setHeader("Connection", "close");
		response.setContentType(mimeType + ";charset=UTF-8");

		FileInputStream in = new FileInputStream(file);
		
		final int BUF_SIZE = 8 * 1024;
		final OutputStream out = response.getOutputStream();
		final byte[] buf = new byte[BUF_SIZE];
		int n;
		
		while(-1 != (n = in.read(buf)))
		{
			out.write(buf, 0, n);
		}
		out.flush();
		//logger.info("(log)readFile 종료");
	}
	

                                                    
}
