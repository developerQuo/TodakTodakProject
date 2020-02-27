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
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#U").click(function(){
					//alert("update");
					$("#form").prop("action", "/sponsor/moveIUMember.td").submit();
				});
				$("#D").click(function(){
					//alert("delete");
					var bool = confirm('정말 삭제하시겠습니까?');
					if (bool){
						$("#form").prop("action", "/sponsor/deleteMember.td").submit();
					}
				});
			});
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
				MemberVO smvo = null;
				MemberCardVO smcvo = null;
				MemberAccountVO smavo = null;
				String smc_cardexpired = "";
				List<MemberVO> memberList = (List<MemberVO>)request.getAttribute("memberList");
				List<MemberCardVO> cardList = (List<MemberCardVO>)request.getAttribute("cardList");
				List<MemberAccountVO> accountList = (List<MemberAccountVO>)request.getAttribute("accountList");
				if (memberList != null && !memberList.isEmpty() &&
					cardList != null && !cardList.isEmpty() &&
					accountList != null && !accountList.isEmpty()){
					smvo = memberList.get(0);
					smcvo = cardList.get(0);
					smc_cardexpired = smcvo.getSmc_cardexpired();
					if (smc_cardexpired != null && !smc_cardexpired.equals(""))
						smc_cardexpired = new StringBuffer(smcvo.getSmc_cardexpired()).insert(2, "-").toString();
					smavo = accountList.get(0);
				}
			%>
			<form id="form">
				<table align="center" border="1">
					<tr><td colspan="3" align="center">후원인정보</td></tr>
					<tr>
						<td align="center" width="140" align="center">이름</td>
						<td colspan="2" width="250">
							<%= smvo.getSm_name() %>
						</td>
					</tr>
					<tr>
						<td align="center">휴대폰번호</td>
						<td colspan="2"><%= smvo.getSm_hp() %></td>
					</tr>
					<tr>
						<td align="center">이메일</td>
						<td colspan="2"><%= smvo.getSm_email() %></td>
					</tr>
					<tr>
						<td align="center">정기후원여부</td>
						<td colspan="2">
							<%= smvo.getSm_regularYN() %>
						</td>
					</tr>
					<tr>
						<td align="center">후원수단</td>
						<td colspan="2"><%= smvo.getSm_means() %></td>
					</tr>
					<tr>
						<td align="center">선택약관동의여부</td>
						<td colspan="2"><%= smvo.getSm_optionalterms() %></td>
					</tr>
					<tr><td colspan="3" align="center">카드정보</td></tr>
					<tr>
						<td align="center">카드사</td>
						<td colspan="2"><%= smcvo.getSmc_cardcorp() %></td>
					</tr>
					<tr>
						<td align="center">카드번호</td>
						<td colspan="2"><%= smcvo.getSmc_cardnum() %></td>
					</tr>
					<tr>
						<td align="center">카드명의자</td>
						<td colspan="2"><%= smcvo.getSmc_cardowner() %></td>
					</tr>
					<tr>
						<td align="center">카드만료날짜</td>
						<td><%= smc_cardexpired %></td>
					</tr>
					<tr>
						<td align="center">cvc</td>
						<td colspan="2"><%= smcvo.getSmc_cardcvc() %></td>
					</tr>
					<tr><td colspan="3" align="center">계좌정보</td></tr>
					<tr>
						<td align="center">은행</td>
						<td colspan="2">국민은행</td>
					</tr>
					<tr>
						<td align="center">계좌번호</td>
						<td colspan="2"><%= smavo.getSma_accountnum() %></td>
					</tr>
					<tr>
						<td align="center">예금주명</td>
						<td colspan="2"><%= smavo.getSma_depositor() %></td>
					</tr>
					<tr>
						<td colspan="5" align="center">
							<input type="hidden" name="sm_num" id="sm_num" value="<%= smvo.getSm_num() %>">
							<input type="hidden" name="smc_num" id="smc_num" value="<%= smcvo.getSmc_num() %>">
							<input type="hidden" name="sma_num" id="sma_num" value="<%= smavo.getSma_num() %>">
							<input type="button" value="수정" id="U">
							<input type="button" value="삭제" id="D">
						</td>
					</tr>
				</table>
			</form>
         </div>
         
	</body>
</html>