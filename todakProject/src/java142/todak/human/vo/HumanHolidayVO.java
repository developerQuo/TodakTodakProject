package java142.todak.human.vo;

public class HumanHolidayVO {
	private String hmEmpnum = "";
	private String regResult = "";
	private String useResult = "";
	private String hoResult = "";
	
	public String getHmEmpnum() {
		return hmEmpnum;
	}
	public void setHmEmpnum(String hmEmpnum) {
		this.hmEmpnum = hmEmpnum;
	}
	public String getRegResult() {
		return regResult;
	}
	public void setRegResult(String regResult) {
		this.regResult = regResult;
	}
	public String getUseResult() {
		return useResult;
	}
	public void setUseResult(String useResult) {
		this.useResult = useResult;
	}
	public String getHoResult() {
		return hoResult;
	}
	public void setHoResult(String hoResult) {
		this.hoResult = hoResult;
	}
	@Override
	public String toString() {
		return "HumanHolidayVO [hmEmpnum=" + hmEmpnum + ", regResult="
				+ regResult + ", useResult=" + useResult + ", hoResult="
				+ hoResult + "]";
	}
	
}
