<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java142.todak.ework.vo.SignStampVO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>서명 이미지</title>
	</head>
	<body>
	<%
		Object obj = request.getAttribute("list_sign");
		//System.out.println("obj >>> : " + obj);
		
		SignStampVO ssvo = null;
		
		
		if(obj!=null) {
			//System.out.println("if(obj!=null) 진입 >>> ");
			
			List<SignStampVO> list_sign = null;
			list_sign = (List<SignStampVO>) obj;
			//System.out.println("list_sign >>> : " + list_sign);
			
			ssvo = list_sign.get(0);
			//System.out.println("ssvo >>> : " + ssvo);
			
		}
	%>
		<?xml version="1.0" encoding="UTF-8"?>
		<sign>
			<filedir><%=ssvo.getEs_filedir() %></filedir>
		</sign>
	</body>
</html>