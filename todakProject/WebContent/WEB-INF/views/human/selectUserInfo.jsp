<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java142.todak.human.vo.MemberVO" %>
<%@ page import="java.util.List" %>

<%
	String picture = "";
	String name = "";
	String fulladdr = "";
			
	Object obj = request.getAttribute("selectUserInfo");
	//System.out.println("obj >>> : " + obj);
	
	if(obj!=null) {
		//System.out.println("if(obj!=null) 진입 >>> ");
		
		List<MemberVO> selectUserInfo = (List<MemberVO>) obj;
		//System.out.println("selectUserInfo >>> : " + selectUserInfo);
		MemberVO mvo = selectUserInfo.get(0);
		//System.out.println("mvo >>> : " + mvo);
		
		picture = mvo.getHm_picture();
		//System.out.println("picture >>> : " + picture);
		
		//fulladdr = "../../human/upload/";
		fulladdr = "../../upload/human/"; // *** test 하기 위해서 경로를 바꿨음 ***
		fulladdr = fulladdr + picture;
		//System.out.println("fulladdr >>> : " + fulladdr);
		
		name = mvo.getHm_name();
		//System.out.println("name >>> : " + name);
		
	} else {
		//System.out.println("데이터 없음");
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>로그인 유저 정보</title>
	</head>
	<body>
		<?xml version="1.0" enctype="UTF-8"?>
		<selectUserInfo>
			<picture><%=fulladdr %></picture>
			<name><%=name %></name>
		</selectUserInfo>
	</body>
</html>