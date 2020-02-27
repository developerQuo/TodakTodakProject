<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.List" %>
<%@ page import="java142.todak.sponsor.vo.MemberVO" %>
<%@ page import="java142.todak.sponsor.vo.MemberCardVO" %>
<%@ page import="java142.todak.sponsor.vo.MemberAccountVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>후원인</title>
		</script>
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<!-- <script type="text/javascript"
				src="../js/jquery-1.11.0.min.js"></script> -->
		<script type="text/javascript">
			$(document).ready(function(){
				//alert("(log) jQuery executed");
				var enctype = 'application/x-www-form-urlencoded';
				$("#confirm").click(function(){
					var domain = $("#emailDomainSlctr").val();
					if (domain == 'bySelf'){
						domain = $("#emailDomain").val();
					}
					var email = $("#emailId").val() + '@' + domain;
					$("#sm_email").prop("value", email);
					
					executeFunc(enctype);
					
				});

				$("#emailDomainSlctr").change(function(){
					//alert("changed");
					//alert($("#rgstEmailDomainSlctr").val());
					var domain = $("#emailDomainSlctr").val();
					if (domain == 'bySelf'){
						$("#emailDomain").val('');
						$("#emailDomain").prop("disabled", false);
					}else{
						$("#emailDomain").val($("#emailDomainSlctr").val());
						$("#emailDomain").prop("disabled", true);
					}
				});
				
			});
			5
			function executeFunc(enctype){
				//http://localhost:8088/Model2_MVC/KcmMemberServlet
				$("#registerForm").prop("method", "POST")
				.prop("enctype", enctype)
				.submit();
			}
		</script>
		
	</head>
	<body>
         <header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>

         <aside class="sidebar">
            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
         </aside>
         <div class="context-container">
			<%
				MemberVO smvo = new MemberVO();
				MemberCardVO smcvo = new MemberCardVO();
				MemberAccountVO smavo = new MemberAccountVO();
				String emailId = "";
				String emailDomain = "";
				List<MemberVO> memberList = (List<MemberVO>)request.getAttribute("memberList");
				List<MemberCardVO> cardList = (List<MemberCardVO>)request.getAttribute("cardList");
				List<MemberAccountVO> accountList = (List<MemberAccountVO>)request.getAttribute("accountList");
				if (memberList != null && !memberList.isEmpty() &&
					cardList != null && !cardList.isEmpty() &&
					accountList != null && !accountList.isEmpty()){
					smvo = memberList.get(0);
					smcvo = cardList.get(0);
					smavo = accountList.get(0);
					int index = smvo.getSm_email().indexOf("@");
					emailId = smvo.getSm_email().substring(0, index);
					emailDomain = smvo.getSm_email().substring(index+1);
			%>
				<script type="text/javascript">
					// 업데이트인 경우
					$(document).ready(function(){
						alert("update");
						$("#registerForm").prop("action", "/sponsor/updateMember.td");
					});
				</script>
			<%
				}else{
			%>
				<script type="text/javascript">
					// 인서트인 경우
					$(document).ready(function(){
						alert("insert");
						$("#registerForm").prop("action", "/sponsor/insertMember.td");
					});
				</script>
			<%		
				}
			%>
			<form id="registerForm">
				<table align="center" border="1">
					<tr><td colspan="3" align="center">후원인정보</td></tr>
					<tr>
						<td align="center" width="140" align="center">이름</td>
						<td colspan="2" width="250">
							<input type="text" name="sm_name" id="sm_name" value=<%= smvo.getSm_name() %>>
						</td>
					</tr>
					<tr>
						<td align="center">휴대폰번호</td>
						<td colspan="2"><input type="text" name="sm_hp" id="sm_hp" value=<%= smvo.getSm_hp() %>>&nbsp;&nbsp;* '-'구분자 없이 숫자 11자리</td>
					</tr>
					<tr>
						<td align="center">이메일</td>
						<td colspan="2"><input type="text" name="emailId" id="emailId" value=<%= emailId %>> @
							<input type="text" name="emailDomain" id="emailDomain" size="10" value=<%= emailDomain %>>
							<select name="emailDomainSlctr" id="emailDomainSlctr">
								<option value="bySelf">직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="hanmail.net">hanmail.net</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">정기후원여부</td>
						<td colspan="2">
							<select name="sm_regularYN" id="sm_regularYN" value=<%= smvo.getSm_regularYN() %>>
								<option value="Y">수락</option>
								<option value="N">거부</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">후원수단</td>
						<td>
							<select name="sm_means" id="sm_means" value=<%= smvo.getSm_means() %>>
								<option value="39">카드</option>
								<option value="40">계좌</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">선택약관동의여부</td>
						<td>
							<select name="sm_optionalterms" id="sm_optionalterms" value=<%= smvo.getSm_optionalterms() %>>
								<option value="Y">수락</option>
								<option value="N">거부</option>
							</select>
						</td>
					</tr>
					<tr><td colspan="3" align="center">카드정보</td></tr>
					<tr>
						<td align="center">카드사</td>
						<td colspan="2">
							<select name="smc_cardcorp" id="smc_cardcorp" value=<%= smcvo.getSmc_cardcorp() %>>
								<option value="33">비씨카드</option>
								<option value="34">삼성카드</option>
								<option value="35">현대카드</option>
								<option value="36">국민카드</option>
								<option value="37">우리카드</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">카드번호</td>
						<td colspan="2"><input type="text" name="smc_cardnum" id="smc_cardnum" value=<%= smcvo.getSmc_cardnum() %>></td>
					</tr>
					<tr>
						<td align="center">카드명의자</td>
						<td colspan="2"><input type="text" name="smc_cardowner" id="smc_cardowner" value=<%= smcvo.getSmc_cardowner() %>></td>
					</tr>
					<tr>
						<td align="center">카드만료날짜</td>
						<td colspan="2"><input type="text" name="smc_cardexpired" id="smc_cardexpired" value=<%= smcvo.getSmc_cardexpired() %>>&nbsp;&nbsp;* MMYYYY</td>
					</tr>
					<tr>
						<td align="center">cvc</td>
						<td colspan="2"><input type="text" name="smc_cardcvc" id="smc_cardcvc" value=<%= smcvo.getSmc_cardcvc() %>>&nbsp;&nbsp;* 카드 cvc 숫자 3자리</td>
					</tr>
					<tr><td colspan="3" align="center">계좌정보</td></tr>
					<tr>
						<td align="center">은행</td>
						<td colspan="2">
							<select name="sma_bank" id="sma_bank">
								<option value="38">국민은행</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">계좌번호</td>
						<td colspan="2"><input type="text" name="sma_accountnum" id="sma_accountnum" value=<%= smavo.getSma_accountnum() %>>&nbsp;&nbsp;* '-'구분자 없이 숫자 14자리</td>
					</tr>
					<tr>
						<td align="center">예금주명</td>
						<td colspan="2"><input type="text" name="sma_depositor" id="sma_depositor" value=<%= smavo.getSma_depositor() %>></td>
					</tr>
					<tr>
						<td colspan="5" align="center">
							<input type="hidden" id="sm_num" name="sm_num" value=<%= smvo.getSm_num() %>>
							<input type="hidden" id="sm_email" name="sm_email">
							<input type="button" value="확인" id="confirm">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value="초기화">
						</td>
					</tr>
				</table>
			</form>
         </div>
         
	</body>
</html>