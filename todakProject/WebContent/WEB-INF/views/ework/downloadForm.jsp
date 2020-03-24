<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.common.FileReadUtil"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>파일 다운로드</title>
	</head>
	<body>
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
	</body>
</html>