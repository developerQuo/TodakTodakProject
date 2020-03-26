package java142.todak.board.vo;
import java142.todak.common.CodeVO;


public class NoticeVO extends CodeVO {
	
	private String bn_num;
	private String hm_empnum;
	private String hm_name;
	private String hm_duty;
	private String bn_deptnum;
	private String bn_divnum;
	private String bn_title;
	private String bn_content;
	private String bn_image;
	private String bn_file;
	private String bn_deleteYN;
	private String bn_insertdate;
	private String bn_updatedate;
	private String bn_hitnum; 
	
	//�˻������� �߰��� mvo���� �ҷ��� vo
	private String check_deptnum;
	private String check_divnum;
	private String check_empnum;
	private String rownum;
	
	public String getRownum() {
		return rownum;
	}
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
	public String getCheck_empnum() {
		return check_empnum;
	}
	public void setCheck_empnum(String check_empnum) {
		this.check_empnum = check_empnum;
	}
	public String getCheck_deptnum() {
		return check_deptnum;
	}
	public void setCheck_deptnum(String check_deptnum) {
		this.check_deptnum = check_deptnum;
	}
	public String getCheck_divnum() {
		return check_divnum;
	}
	public void setCheck_divnum(String check_divnum) {
		this.check_divnum = check_divnum;
	}


	
	public String getBn_num() {
		return bn_num;
	}
	public void setBn_num(String bn_num) {
		this.bn_num = bn_num;
	}
	public String getHm_empnum() {
		return hm_empnum;
	}
	public void setHm_empnum(String hm_empnum) {
		this.hm_empnum = hm_empnum;
	}
	public String getHm_name() {
		return hm_name;
	}
	public void setHm_name(String hm_name) {
		this.hm_name = hm_name;
	}
	public String getHm_duty() {
		return hm_duty;
	}
	public void setHm_duty(String hm_duty) {
		this.hm_duty = hm_duty;
	}
	public String getBn_deptnum() {
		return bn_deptnum;
	}
	public void setBn_deptnum(String bn_deptnum) {
		this.bn_deptnum = bn_deptnum;
	}
	public String getBn_divnum() {
		return bn_divnum;
	}
	public void setBn_divnum(String bn_divnum) {
		this.bn_divnum = bn_divnum;
	}
	public String getBn_title() {
		return bn_title;
	}
	public void setBn_title(String bn_title) {
		this.bn_title = bn_title;
	}
	public String getBn_content() {
		return bn_content;
	}
	public void setBn_content(String bn_content) {
		this.bn_content = bn_content;
	}
	public String getBn_image() {
		return bn_image;
	}
	public void setBn_image(String bn_image) {
		this.bn_image = bn_image;
	}
	public String getBn_file() {
		return bn_file;
	}
	public void setBn_file(String bn_file) {
		this.bn_file = bn_file;
	}
	public String getBn_deleteYN() {
		return bn_deleteYN;
	}
	public void setBn_deleteYN(String bn_deleteYN) {
		this.bn_deleteYN = bn_deleteYN;
	}
	public String getBn_insertdate() {
		return bn_insertdate;
	}
	public void setBn_insertdate(String bn_insertdate) {
		this.bn_insertdate = bn_insertdate;
	}
	public String getBn_updatedate() {
		return bn_updatedate;
	}
	public void setBn_updatedate(String bn_updatedate) {
		this.bn_updatedate = bn_updatedate;
	}
	
	public String getBn_hitnum() {
		return bn_hitnum;
	}
	public void setBn_hitnum(String bn_hitnum) {
		this.bn_hitnum = bn_hitnum;
	}

}
