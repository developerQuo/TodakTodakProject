package java142.todak.common;

import java.io.File;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class FileName implements FileRenamePolicy {
	public FileName(){}
	
	public File rename(File sf){
		String f = sf.getName();
		//System.out.println("fileName >>> : " + f);
		
		try {
			String t = f;
			for (int i=0; sf.exists(); i++){
				int lt = t.lastIndexOf(".");

				String t1 = t.substring(0, lt);
				String t2 = t.substring(lt);
				String ft = "_" + (i + 2);
				f =  t1 + ft + t2;
				sf = new File(sf.getParent(), f);
			}
			
		}catch(Exception e){
			//System.out.println(" BabyFileName.rename() ===> : " + e);
		}
		
		return sf;
	}

}
