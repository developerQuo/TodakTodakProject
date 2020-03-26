<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.human.vo.MemberVO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>부서 회원번호 조회</title>
	</head>
	<body>
		<?xml version="1.0" encoding="UTF-8"?>
		<%
			Object ob = null;
			List<MemberVO> list = null;
			String hm_empnum = "";
			String hm_name = "";
			String hm_position = "";
			String hm_duty = "";
			String listSize = "";
			
			ob = request.getAttribute("list");
			//System.out.println("ob >>> : " + ob);
			
			if(ob!= null) {
				//System.out.println("if(ob!= null) 진입 >>> ");
				
				list = (List<MemberVO>) ob;
				//System.out.println("list >>> : " + list);
				listSize = String.valueOf(list.size());
				//System.out.println("listSize >>> : " + listSize);
				
			%>
			<size>
				<listSize><%=listSize %></listSize>
			</size>
			<%
				
				for(int i=0; i<list.size(); i++) {
					MemberVO mvo = list.get(i);
					//System.out.println("mvo >>> : " + mvo);
					
					hm_empnum = mvo.getHm_empnum();
					hm_name = mvo.getHm_name();
					hm_position = mvo.getHm_position();
					hm_duty = mvo.getHm_duty();
					
					//System.out.println("hm_empnum >>> : " + hm_empnum);
					//System.out.println("hm_name >>> : " + hm_name);
					//System.out.println("hm_position >>> : " + hm_position);
					//System.out.println("hm_duty >>> : " + hm_duty);
					
			%>
				<list>
					<empnum><%= hm_empnum%>,</empnum>
					<name><%= hm_name%>,</name>
					<position><%= hm_position%>,</position>
					<duty><%= hm_duty%>,</duty>
				</list>
			<%
				}
				
			}
			
		%>
	</body>
</html>