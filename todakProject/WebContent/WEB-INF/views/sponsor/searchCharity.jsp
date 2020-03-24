<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java142.todak.sponsor.vo.CharityVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>단체 정보</title>
		
		<link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
		
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#U").click(function(){
					$("#form").prop("action", "/sponsor/moveIUCharity.td").submit();
				});
				$("#D").click(function(){
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
         <h3><b>단체 정보</b></h3>
         <hr><br>
			<%
				CharityVO scvo = null;
				List<CharityVO> charityList = (List<CharityVO>)request.getAttribute("charityList");
				if (charityList != null && !charityList.isEmpty()){
					scvo = charityList.get(0);
				}
			%>
			<form id="form">
				<div class="searchtable_size">
					<table class="search_table" border="1">
						<tr>
							<td align="center" width="140" align="center" style="background-color:#eeeeee;color:white;">단체명</td>
							<td colspan="2" width="250">
								<%= scvo.getSc_name() %>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">대표자</td>
							<td colspan="2">
								<%= scvo.getSc_ceo()%>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">휴대폰번호</td>
							<td colspan="2"><%= scvo.getSc_hp() %></td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">이메일</td>
							<td colspan="2"><%= scvo.getSc_email() %></td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">소재지</td>
							<td colspan="2">
								<%= scvo.getSc_addr() %>>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">단체 등록번호</td>
							<td colspan="2"><%= scvo.getSc_registration() %></td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">단체 등록일</td>
							<td><%= new StringBuffer(scvo.getSc_registrationdate()).insert(6, ".").insert(4, ".").toString() %></td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">사업분야</td>
							<td><%= scvo.getSc_bizfield() %></td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">사업내용</td>
							<td colspan="2" rows="4" cols="60"><%= scvo.getSc_bizcontents() %></td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">목표모금액</td>
							<td colspan="2"><%= scvo.getSc_targetamount() %></td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">모금기간</td>
							<td><%= new StringBuffer(scvo.getSc_amountingstart()).insert(6, ".").insert(4, ".").toString() %> ~ <%= new StringBuffer(scvo.getSc_amountingend()).insert(6, ".").insert(4, ".").toString() %></td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">은행</td>
							<td colspan="2">국민은행</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">계좌번호</td>
							<td colspan="2"><%= scvo.getSc_accountnum() %></td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">예금주명</td>
							<td colspan="2"><%= scvo.getSc_depositor() %></td>
						</tr>
					</table>
					<br>
					<div class="searchtable_align" align="right">
						<input type="hidden" name="sc_num" id="sc_num" value="<%= scvo.getSc_num() %>">
						<input type="button" value="수정" class="button" id="U" style="width:60px;">
						<input type="button" value="삭제" class="button" id="D" style="width:60px;">
					</div>
				</div>
			</form>
         </div>
	</body>
</html>