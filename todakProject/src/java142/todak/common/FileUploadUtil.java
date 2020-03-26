package java142.todak.common;

import java.util.Enumeration;
import java.util.Vector;
import java142.todak.board.controller.BoardController;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import org.apache.log4j.Logger;

public class FileUploadUtil {

	private static final int SIZE_LIMIT = 5240880;	
	private MultipartRequest m;

	static Logger logger = Logger.getLogger(BoardController.class);
	
	public boolean fileUpload(HttpServletRequest request, String filePaths){
		
		boolean fb = false;
		
		try{
			m = new MultipartRequest( request
                                     ,filePaths
                                     ,SIZE_LIMIT
                                     ,"UTF-8"
                                     ,new FileName());
			
//			request.setCharacterEncoding("UTF-8");
			
			return fb = true;
			
			
		}catch(Exception e){
			//System.out.println("FileUploadUtil.fileUpldad() >>> : " + e);
		}
		
		return fb;		
	}
	
	public String getParameter(String s){
		return m.getParameter(s);
	}
	
	public Enumeration<String> getFileNames()
	{
		Enumeration<String> en = m.getFileNames();
		Vector<String> v = new Vector<String>();
		
		while (en.hasMoreElements())
		{
			String f = en.nextElement().toString();
			//logger.info("f Ȯ�ο� >>> :" + f);
			v.add(m.getFilesystemName(f));
		}
		
		return v.elements();
	}
	
	public String getFileName(String f){
		return m.getFilesystemName(f);
	}
	
}
