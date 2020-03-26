<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>기안 결과</title>
		<script type="text/javascript"
				src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				console.log("제이쿼리");
				
				$('#back_href').click(function() {
					console.log("뒤로가기");
					
					history.back();
					
					return false;
				});
				
			});
		</script>
	</head>
	<body>
	
		<jsp:include page="/etc/moveSession.td" flush="false"/>
		<header class="header"> 
	       <%@ include file="/WEB-INF/views/commons/header.jsp" %>
	    </header>
	
	    <aside class="sidebar">
	       <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
	    </aside>
		
		<div class="context-container">
		<%
			boolean bFlag = false;	
		
			Object obj = request.getAttribute("bFlag");
			//System.out.println("obj >>> : " + obj);
			
			if(obj!=null) {
				//System.out.println("if(obj!=null) 진입 >>> ");
				
				bFlag = (boolean) obj;
				//System.out.println("bFlag >>> : " + bFlag);
				
			}
			
			if(bFlag) {
		%>
				<br><br><br>
				<p><h2>기안이 완료되었습니다.</h2>
				<br><br>
				<div align="right">
					<a id="auth_href" href="/ework/selectAuthBox.td">결재 화면으로 이동</a>
				</div>
		<% 			
			} else {
		%>
				<br><br><br>
				<p><h2>시스템 문제로 인해 기안에 실패하였습니다.</h2>
				<br><br>
				<div align="right">
					<a id="back_href" href="">이전 페이지로 이동</a>
				</div>
		<%
			}
		%>
		
		</div>
		
	</body>
</html>