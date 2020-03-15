package java142.todak.sponsor.vo;

public class MemberVO {
	private String sm_num = "";
    private String sm_name = "";
    private String sm_hp = "";
    private String sm_email = "";
    private String sm_regularYN = "";
    private String sm_means = "";
    private String sm_optionalterms = "";
    private String sm_deleteYN = "";
    private String sm_insertdate = "";
    private String sm_updatedate = "";
	private int pageNo = 0;
	private int totalCount = 0;
	public String getSm_num() {
		return sm_num;
	}
	public void setSm_num(String sm_num) {
		this.sm_num = sm_num;
	}
	public String getSm_name() {
		return sm_name;
	}
	public void setSm_name(String sm_name) {
		this.sm_name = sm_name;
	}
	public String getSm_hp() {
		return sm_hp;
	}
	public void setSm_hp(String sm_hp) {
		this.sm_hp = sm_hp;
	}
	public String getSm_email() {
		return sm_email;
	}
	public void setSm_email(String sm_email) {
		this.sm_email = sm_email;
	}
	public String getSm_regularYN() {
		return sm_regularYN;
	}
	public void setSm_regularYN(String sm_regularYN) {
		this.sm_regularYN = sm_regularYN;
	}
	public String getSm_means() {
		return sm_means;
	}
	public void setSm_means(String sm_means) {
		this.sm_means = sm_means;
	}
	public String getSm_optionalterms() {
		return sm_optionalterms;
	}
	public void setSm_optionalterms(String sm_optionalterms) {
		this.sm_optionalterms = sm_optionalterms;
	}
	public String getSm_deleteYN() {
		return sm_deleteYN;
	}
	public void setSm_deleteYN(String sm_deleteYN) {
		this.sm_deleteYN = sm_deleteYN;
	}
	public String getSm_insertdate() {
		return sm_insertdate;
	}
	public void setSm_insertdate(String sm_insertdate) {
		this.sm_insertdate = sm_insertdate;
	}
	public String getSm_updatedate() {
		return sm_updatedate;
	}
	public void setSm_updatedate(String sm_updatedate) {
		this.sm_updatedate = sm_updatedate;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
}
