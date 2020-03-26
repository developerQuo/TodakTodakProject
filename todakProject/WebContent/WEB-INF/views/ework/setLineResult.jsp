<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java142.todak.ework.vo.LineVO" %>
    
<%
	String result = "";
	
	Object obj = request.getAttribute("result");
	//System.out.println("obj >>> : " + obj);	

	if(obj!= null) {
		result = (String) obj;
		//System.out.println("result >>> : " + result);
	} else {
		//System.out.println("obj가 없음");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>결과 화면</title>
		<script type="text/javascript">
			alert("<%=result%>");
			
			if("${result}".indexOf("문제") > -1) {
				history.go(-1);
			} else {
				window.close();
			}
		</script>
	</head>
	<body>

	</body>
</html>