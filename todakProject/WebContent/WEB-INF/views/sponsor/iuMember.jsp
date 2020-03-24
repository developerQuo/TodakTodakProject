<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java142.todak.sponsor.vo.MemberVO" %>
<%@ page import="java142.todak.sponsor.vo.MemberCardVO" %>
<%@ page import="java142.todak.sponsor.vo.MemberAccountVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>후원인 정보</title>
		
		<link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
		
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<!-- <script type="text/javascript"
				src="../js/jquery-1.11.0.min.js"></script> -->
		<script type="text/javascript">
			$(document).ready(function(){
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
         
         <h3><b>후원인 정보</b></h3>
         <hr><br>
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
						$("#registerForm").prop("action", "/sponsor/updateMember.td");
					});
				</script>
			<%
				}else{
			%>
				<script type="text/javascript">
					// 인서트인 경우
					$(document).ready(function(){
						$("#registerForm").prop("action", "/sponsor/insertMember.td");
					});
				</script>
			<%		
				}
			%>
			<div class="inserttable_size">
				<form id="registerForm">
					<table class="insert_table" align="center" border="1">
						<colgroup>
							<col width ="25%"/>
							<col width ="75%"/>
						</colgroup>
						<tr><td colspan="3" align="center" style="background-color:#eeeeee;color:white;"><b>인적정보</b></td></tr>
						<tr>
							<td align="center" width="140" align="center">이름</td>
							<td colspan="2" width="250">
								<input type="text" name="sm_name" id="sm_name" style="width:210px;" value=<%= smvo.getSm_name() %>>
							</td>
						</tr>
						<tr>
							<td align="center">휴대폰번호</td>
							<td colspan="2">
								<input type="text" name="sm_hp" id="sm_hp" style="width:210px;" value=<%= smvo.getSm_hp() %>>&nbsp;&nbsp;<font size="2">* '-'구분자 없이 숫자 11자리</font>
							</td>
						</tr>
						<tr>
							<td align="center">이메일</td>
							<td colspan="2"><input type="text" name="emailId" id="emailId" style="width:210px;" value=<%= emailId %>> @
								<input type="text" name="emailDomain" id="emailDomain" style="width:210px;" value=<%= emailDomain %>>
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
								<select style="width:210px;" name="sm_regularYN" id="sm_regularYN" value=<%= smvo.getSm_regularYN() %>>
									<option value="Y">수락</option>
									<option value="N">거부</option>
								</select>
							</td>
						</tr>
						<tr>
							<td align="center">후원수단</td>
							<td>
								<select style="width:210px;" name="sm_means" id="sm_means" value=<%= smvo.getSm_means() %>>
									<option value="39">카드</option>
									<option value="40">계좌</option>
								</select>
							</td>
						</tr>
						<tr>
							<td align="center">선택약관동의여부</td>
							<td>
								<select style="width:210px;" name="sm_optionalterms" id="sm_optionalterms" value=<%= smvo.getSm_optionalterms() %>>
									<option value="Y">수락</option>
									<option value="N">거부</option>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="3" align="center" style="background-color:#eeeeee;color:white;">
								<b>카드정보</b>
							</td>
						</tr>
						<tr>
							<td align="center">카드사</td>
							<td colspan="2">
								<select style="width:210px;" name="smc_cardcorp" id="smc_cardcorp" value=<%= smcvo.getSmc_cardcorp() %>>
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
							<td colspan="2"><input type="text" name="smc_cardnum" id="smc_cardnum" style="width:210px;" value=<%= smcvo.getSmc_cardnum() %>></td>
						</tr>
						<tr>
							<td align="center">카드명의자</td>
							<td colspan="2"><input type="text" name="smc_cardowner" id="smc_cardowner" style="width:210px;" value=<%= smcvo.getSmc_cardowner() %>></td>
						</tr>
						<tr>
							<td align="center">카드만료날짜</td>
							<td colspan="2">
								<input type="text" name="smc_cardexpired" id="smc_cardexpired" style="width:210px;" value=<%= smcvo.getSmc_cardexpired() %>>&nbsp;&nbsp;<font size="2">* MMYYYY</font>
							</td>
						</tr>
						<tr>
							<td align="center">cvc</td>
							<td colspan="2">
								<input type="text" name="smc_cardcvc" id="smc_cardcvc" style="width:210px;" value=<%= smcvo.getSmc_cardcvc() %>>&nbsp;&nbsp;<font size="2">* 카드 cvc 숫자 3자리</font>
							</td>
						</tr>
						<tr>
							<td colspan="3" align="center" style="background-color:#eeeeee;color:white;">
								<b>계좌정보</b>
							</td>
						</tr>
						<tr>
							<td align="center">은행</td>
							<td colspan="2">
								<select style="width:210px;" name="sma_bank" id="sma_bank">
									<option value="38">국민은행</option>
								</select>
							</td>
						</tr>
						<tr>
							<td align="center">계좌번호</td>
							<td colspan="2">
								<input type="text" name="sma_accountnum" id="sma_accountnum" style="width:210px;" value=<%= smavo.getSma_accountnum() %>>&nbsp;&nbsp;<font size="2">* '-'구분자 없이 숫자 14자리</font>
							</td>
						</tr>
						<tr>
							<td align="center">예금주명</td>
							<td colspan="2"><input type="text" name="sma_depositor" id="sma_depositor" style="width:210px;" value=<%= smavo.getSma_depositor() %>></td>
						</tr>
						</table>
						<br>
						<div class="inserttable_align" align="right">
							<input type="hidden" id="sm_num" name="sm_num" value=<%= smvo.getSm_num() %>>
							<input type="hidden" id="sm_email" name="sm_email">
							<input type="reset" class="button" value="초기화" style="width:60px;">
							<input type="button" value="확인" class="button" id="confirm" style="width:60px;">
						</div>
				</div>
			</form>
         </div>
         
	</body>
</html>