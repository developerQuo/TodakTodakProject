<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>문서 작성</title>
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
        	<form id="form_tag" name="form_tag" method="POST">
	        	<br>
	        	<h3>결재 서류 작성</h3>
	        	<hr>
				<%
					//String path = request.getSession().getServletContext().getRealPath("/upload/doc") + "\\formDownload.hwp";
					////System.out.println("path >>> : "+ path);
				%>
				<!-- 
						JDK : 1.7			java : luna
						spring : 3.2.4		mybatis : 3.2.4
						servlet : 3.2		jsp : 2.3
						다이나믹프로젝트버전 : 3.0	헤더 인코딩 설정 완료
				 -->
				 <br><br><br>
				 <a href="/eworkForm/moveInsertProposal.td">기안서 작성</a><p>
				 <a href="/eworkForm/moveDownloadApprovalForm.td">품의서 작성</a><p>
				 <a href="/eworkForm/moveInsertHoliday.td">휴가신청서 작성</a>&nbsp;&nbsp;<p>
				  <a href="/ework/selectAuthBox.td">결재</a>&nbsp;&nbsp;<p>
				 
				 <!-- 
				 <a href="/ework/moveSetLine.td">결재라인 정하기</a>&nbsp;&nbsp;
				 <p>
				 <a href="/ework/moveSetHolidayLine.td">휴가신청서 결재라인 정하기</a>&nbsp;&nbsp;
				 <a href="/ework/moveSetApprovalLine.td">기안서 결재라인 정하기</a>&nbsp;&nbsp;
				 <a href="/ework/moveSetProposalLine.td">품의서 결재라인 정하기</a>&nbsp;&nbsp;
				  -->
			
				<br><br>
			</form> 
        </div>
	</body>
</html>