<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>품의서</title>
		
		<script type="text/javascript" 
				src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function() {
				console.log("제이쿼리");
				
				$('#download_href').click(function() {
					console.log("$('#download_href').click(function()");
					
					$('#download_form')
					.attr("action", "/eworkForm/downloadDocument.td")
					.submit();
					
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

			<br><br><br>
			
			<form id="download_form" name="download_form"align>
				<a id="download_href" href="#">품의서 양식 다운로드</a><p>
				<input type="hidden" id="file" name="file" value="formDownload.hwp"> <!-- value엔 파일이름.형식 -->
				
				<a href="/eworkForm/moveInsertApproval.td">품의서 작성</a>&nbsp;&nbsp;
			</form>
		</div>
		<br><br>
	</body>
</html>