package java142.todak.board.vo;

import java142.todak.common.CodeVO;

public class SuggestionVO extends CodeVO {

	private	String	bs_num;
	private	String	hm_empnum;
	private	String	bs_title;
	private	String	bs_content;
	private	String	bs_image;
	private	String	bs_insertdate;
	private	String	bs_updatedate;
	private	String	bs_deleteyn;

	private	String	bs_hitnum;
	private	String	rownum;
	
	private	String	bsr_num;
	private String	bsl_likeYN;
	private String	bsl_dislikeYN;

	
	public String getBs_num() {
		return bs_num;
	}
	public void setBs_num(String bs_num) {
		this.bs_num = bs_num;
	}
	public String getHm_empnum() {
		return hm_empnum;
	}
	public void setHm_empnum(String hm_empnum) {
		this.hm_empnum = hm_empnum;
	}
	public String getBs_title() {
		return bs_title;
	}
	public void setBs_title(String bs_title) {
		this.bs_title = bs_title;
	}
	public String getBs_content() {
		return bs_content;
	}
	public void setBs_content(String bs_content) {
		this.bs_content = bs_content;
	}
	public String getBs_image() {
		return bs_image;
	}
	public void setBs_image(String bs_image) {
		this.bs_image = bs_image;
	}
	public String getBs_insertdate() {
		return bs_insertdate;
	}
	public void setBs_insertdate(String bs_insertdate) {
		this.bs_insertdate = bs_insertdate;
	}
	public String getBs_updatedate() {
		return bs_updatedate;
	}
	public void setBs_updatedate(String bs_updatedate) {
		this.bs_updatedate = bs_updatedate;
	}
	public String getBs_deleteyn() {
		return bs_deleteyn;
	}
	public void setBs_deleteyn(String bs_deleteyn) {
		this.bs_deleteyn = bs_deleteyn;
	}
	
	
	public String getBsr_num() {
		return bsr_num;
	}
	public void setBsr_num(String bsr_num) {
		this.bsr_num = bsr_num;
	}
	public String getBsl_likeYN() {
		return bsl_likeYN;
	}
	public void setBsl_likeYN(String bsl_likeYN) {
		this.bsl_likeYN = bsl_likeYN;
	}
	public String getBsl_dislikeYN() {
		return bsl_dislikeYN;
	}
	public void setBsl_dislikeYN(String bsl_dislikeYN) {
		this.bsl_dislikeYN = bsl_dislikeYN;
	}

	
	public String getBs_hitnum() {
		return bs_hitnum;
	}
	public void setBs_hitnum(String bs_hitnum) {
		this.bs_hitnum = bs_hitnum;
	}
	public String getRownum() {
		return rownum;
	}
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
	
}
