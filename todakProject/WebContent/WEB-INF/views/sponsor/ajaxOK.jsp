<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java142.todak.sponsor.vo.CharityVO" %>
<%@ page import="java142.todak.sponsor.vo.MemberVO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String selectFunc = (String)request.getAttribute("selectFunc");
	List<List<String>> aList = new ArrayList<List<String>>();
	
	if(selectFunc.equals("member")){
		List<MemberVO> smList = (List<MemberVO>)request.getAttribute("memberList");
		Iterator<MemberVO> iter = smList.iterator();
		while (iter.hasNext()){
			MemberVO smvo = iter.next();
			
			List<String> tmpList = null;
			tmpList = new ArrayList<String>();
			tmpList.add(smvo.getSm_num());
			tmpList.add(smvo.getSm_name());
			
			aList.add(tmpList);
			tmpList = null;
		}
	}
	if(selectFunc.equals("charity")){
		List<CharityVO> cmList = (List<CharityVO>)request.getAttribute("charityList");	
		Iterator<CharityVO> iter = cmList.iterator();
		while (iter.hasNext()){
			CharityVO cmvo = iter.next();
			
			List<String> tmpList = null;
			tmpList = new ArrayList<String>();
			tmpList.add(cmvo.getSc_num());
			tmpList.add(cmvo.getSc_name());
			
			aList.add(tmpList);
			tmpList = null;
		}	
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		</head>
	<body>
		<?xml version='1.0' encoding='UTF-8'?>
		<container>
			<%
				for(int i=0; i<aList.size(); i++){
					//System.out.println(i);
			%>
			<aList>
				<num><%= aList.get(i).get(0) %></num>
				<name><%= aList.get(i).get(1) %></name>
			</aList>
			<%
				}
			%>
		</container>
	
	</body>
</html>