package java142.todak.common;

import java142.todak.common.CodeVO;
import java142.todak.human.vo.PagingVO;

public class Paging {
	
public static void setPage(CodeVO cvo, String curpage, String sizeCtrl){
		
		if(curpage==null) cvo.setCurPage(1);//ù ȭ�� �� ������ ���� 1�������� �����մϴ�.

		if(curpage!=null){
			int curnum=Integer.parseInt(curpage);
			cvo.setCurPage(curnum);//�޾ƿ� ���������� ���� �����մϴ�.
		}
		
		cvo.setGroupSize(10);
		
		if(sizeCtrl==null) cvo.setPageSize(10);// ȭ�鿡 ǥ���� �Խñ��� �������� ������� ����Ʈ�� 5���� ǥ�����ݴϴ�.
		if(sizeCtrl!=null){
			int ctrl=Integer.parseInt(sizeCtrl);
			cvo.setPageSize(ctrl);//ȭ�鿡 ǥ���� �Խñ��� ������ ��� ������ ���� �������ݴϴ�.
		}
		
	}
public static void setPage(PagingVO pvo, String curpage, String sizeCtrl){
	
	if(curpage==null||curpage.equals("0")){
		pvo.setCurPage(1);
	}
	if(curpage!=null){
		int curnum=Integer.parseInt(curpage);
		pvo.setCurPage(curnum);
	}
	pvo.setGroupSize(10);
	
	if(sizeCtrl==null){
	pvo.setPageSize(10);
	}
	if(sizeCtrl!=null){
		int ctrl=Integer.parseInt(sizeCtrl);
		pvo.setPageSize(ctrl);
	}
}


}
