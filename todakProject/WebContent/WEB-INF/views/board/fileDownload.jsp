<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java142.todak.board.controller.BoardController"  %>
<%@ page import="java142.todak.common.FileReadUtil"  %>
<%@ page import="java142.todak.board.vo.NoticeVO"  %>
<%@ page import="java.util.ArrayList"  %>

<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>파일 다운로드 중이당</title>
	</head>
	<body>
		<header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>

         <aside class="sidebar">
            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
         </aside>
         
         <div class="container">
	<%
	
				Object filePath = request.getAttribute("FilePath");
				filePath = (String)filePath;
				
				Object fileName = request.getAttribute("fileName");
				fileName = (String)fileName;
				
				request.setAttribute("filePath", filePath);
				request.setAttribute("fileName" ,fileName);
				
				FileReadUtil fru = new FileReadUtil();
				fru.readFile(request, response);
				
				
	
	%>
         
         </div>
	</body>
</html>