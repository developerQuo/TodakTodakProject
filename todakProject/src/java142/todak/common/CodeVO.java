package java142.todak.common;

public class CodeVO {
	
	private	String	cd_num;
	private	String	cd_name;
	private	String	cd_code;
	
	private int pageSize;
	private int groupSize;
	private int curPage;
	private int totalCount;
	
	private String keyword;
	private String findIndex;
	   
	//°Ë»ö¿ë hm_empnum
	private String n_hm_empnum;
	
	   
	
	public String getCd_num() {
		return cd_num;
	}
	public void setCd_num(String cd_num) {
		this.cd_num = cd_num;
	}
	public String getCd_name() {
		return cd_name;
	}
	public void setCd_name(String cd_name) {
		this.cd_name = cd_name;
	}
	public String getCd_code() {
		return cd_code;
	}
	public void setCd_code(String cd_code) {
		this.cd_code = cd_code;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getGroupSize() {
		return groupSize;
	}
	public void setGroupSize(int groupSize) {
		this.groupSize = groupSize;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	public String getN_hm_empnum() {
		return n_hm_empnum;
	}
	public void setN_hm_empnum(String n_hm_empnum) {
		this.n_hm_empnum = n_hm_empnum;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getFindIndex() {
		return findIndex;
	}
	public void setFindIndex(String findIndex) {
		this.findIndex = findIndex;
	}


}
