<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java142.todak.human.vo.MemberVO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>유저 정보 조회</title>
	</head>
	<body>
		<%
			String hm_name = "";
			String hm_deptnum = "";
			String hm_position = "";
			String hm_duty = "";
		
		
			Object ob = request.getAttribute("list");
			//System.out.println("ob >>> : " + ob);
			
			if(ob!=null) {
				//System.out.println("if(ob!=null) 진입 >>> ");
				
				List<MemberVO> list = (List<MemberVO>)ob;
				//System.out.println("list >>> : " + list);
				
				MemberVO mvo = list.get(0);
				//System.out.println("mvo >>> : " + mvo);
				
				hm_name = mvo.getHm_name();
				hm_deptnum = mvo.getHm_deptnum();
				hm_position = mvo.getHm_position();
				hm_duty = mvo.getHm_duty();
				
				//System.out.println("hm_name >>> : " + hm_name);
				//System.out.println("hm_deptnum >>> : " + hm_deptnum);
				//System.out.println("hm_position >>> : " + hm_position);
				//System.out.println("hm_duty >>> : " + hm_duty);
				
			} else {
				//System.out.println("if(ob!=null)-else 진입 >>> ");
				
			}
		%>
		
		<?xml version="1.0" encoding="UTF-8"?>
		
		<list>
			<hm_name><%=hm_name %></hm_name>
			<hm_deptnum><%=hm_deptnum %></hm_deptnum>
			<hm_position><%=hm_position %></hm_position>
			<hm_duty><%=hm_duty %></hm_duty>
		</list>
		
	</body>
</html>