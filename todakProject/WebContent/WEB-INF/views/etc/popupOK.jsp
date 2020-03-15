<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String message = (String)request.getAttribute("message");
	String checker = (String)request.getAttribute("checker");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<?xml version='1.0' encoding='UTF-8'?>
		<container>
			<checker><%= checker %></checker>
		</container>
		
		<container>
			<message><%= message %></message>
		</container>
	</body>
</html>