<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java142.todak.sponsor.vo.CharityVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>비영리단체</title>
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#U").click(function(){
					//alert("update");
					$("#form").prop("action", "/sponsor/moveIUCharity.td").submit();
				});
				$("#D").click(function(){
					//alert("delete");
					var bool = confirm('정말 삭제하시겠습니까?');
					if (bool){
						$("#form").prop("action", "/sponsor/deleteCharity.td").submit();
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
				CharityVO scvo = null;
				List<CharityVO> charityList = (List<CharityVO>)request.getAttribute("charityList");
				if (charityList != null && !charityList.isEmpty()){
					scvo = charityList.get(0);
				}
			%>
			<form id="form">
				<table align="center" border="1">
					<tr><td colspan="3" align="center">단체정보</td></tr>
					<tr>
						<td align="center" width="140" align="center">단체명</td>
						<td colspan="2" width="250">
							<%= scvo.getSc_name() %>
						</td>
					</tr>
					<tr>
						<td align="center">대표자</td>
						<td colspan="2">
							<%= scvo.getSc_ceo()%>
						</td>
					</tr>
					<tr>
						<td align="center">휴대폰번호</td>
						<td colspan="2"><%= scvo.getSc_hp() %></td>
					</tr>
					<tr>
						<td align="center">이메일</td>
						<td colspan="2"><%= scvo.getSc_email() %></td>
					</tr>
					<tr>
						<td align="center">소재지</td>
						<td colspan="2">
							<%= scvo.getSc_addr() %>>
						</td>
					</tr>
					<tr>
						<td align="center">단체 등록번호</td>
						<td colspan="2"><%= scvo.getSc_registration() %></td>
					</tr>
					<tr>
						<td align="center">단체 등록일</td>
						<td><%= new StringBuffer(scvo.getSc_registrationdate()).insert(6, "-").insert(4, "-").toString() %></td>
					</tr>
					<tr>
						<td align="center">사업분야</td>
						<td><%= scvo.getSc_bizfield() %></td>
					</tr>
					<tr>
						<td align="center">사업내용</td>
						<td colspan="2" rows="4" cols="60"><%= scvo.getSc_bizcontents() %></td>
					</tr>
					<tr>
						<td align="center">목표모금액</td>
						<td colspan="2"><%= scvo.getSc_targetamount() %></td>
					</tr>
					<tr>
						<td align="center">모금기간</td>
						<td><%= new StringBuffer(scvo.getSc_amountingstart()).insert(6, "-").insert(4, "-").toString() %> - <%= new StringBuffer(scvo.getSc_amountingend()).insert(6, "-").insert(4, "-").toString() %></td>
					</tr>
					<tr>
						<td align="center">은행</td>
						<td colspan="2">국민은행</td>
					</tr>
					<tr>
						<td align="center">계좌번호</td>
						<td colspan="2"><%= scvo.getSc_accountnum() %></td>
					</tr>
					<tr>
						<td align="center">예금주명</td>
						<td colspan="2"><%= scvo.getSc_depositor() %></td>
					</tr>
					<tr>
						<td colspan="5" align="center">
							<input type="hidden" name="sc_num" id="sc_num" value="<%= scvo.getSc_num() %>">
							<input type="button" value="수정" id="U">
							<input type="button" value="삭제" id="D">
						</td>
					</tr>
				</table>
			</form>
         </div>
	</body>
</html>