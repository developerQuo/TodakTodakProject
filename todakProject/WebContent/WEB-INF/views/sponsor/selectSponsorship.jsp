<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	String message = (String)request.getAttribute("message");
	//System.out.println(" message >>> " + message);
	if (message != null){
		%>
		<script type="text/javascript">
			var message = '<%= message %>';
			if (message != null && message != ''){
				alert(message);
			}
		</script>
		<%
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<link rel="stylesheet" href="../../../include/css/sponsor/sponsorship.css">
		<title>Insert title here</title>
	</head>
	<body>
         <header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>

         <aside class="sidebar">
            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
         </aside>
         
		<% System.out.println(sManager.getUserID(session.getId())); %>
		<div class="context-container">
		
			<!-- graph -->
			<div id="placeholder">
			
			</div>
			
		</div>
	</body>
</html>