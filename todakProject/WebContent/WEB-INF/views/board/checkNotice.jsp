<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java142.todak.board.controller.BoardController"  %>
<%@ page import="java142.todak.board.vo.NoticeVO"  %>
<%@ page import="java142.todak.human.vo.MemberVO"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String message = (String)request.getAttribute("message");
	
	if(message != null){
%>
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
			alert('<%=message %>');
			
			window.close();
		</script>
	
<%
	}else{

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>공지사항 확인하기</title>
		
		<link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#n_check").click(function(){
					$("#CheckNoticeForm")
					.attr(	"action", "../board/checkNotice.td")
					.submit();
					
				});
	
			});
			
		</script>
	</head>
<%
		String hm_empnum = sManager.getUserID(session.getId());
		Object obj = request.getAttribute("mList");
		ArrayList<MemberVO> mList = (ArrayList<MemberVO>) obj;
		String bn_num = (String)request.getAttribute("bn_num");
        MemberVO mvo = mList.get(0);
		//System.out.println(mvo.getHm_name() + " : " + mvo.getHm_deptnum());
		
%>
	<body>
         <div style="width:400px;height:150px;padding:60px 0 0 0;">
         	
			<form id="CheckNoticeForm" name="CheckNoticeForm" enctype="application/x-www-form-urlencoded" method="POST">
				<input type="hidden" id="bn_num" name="bn_num" value="<%=bn_num %>">
				<input type="hidden" id="hm_empnum" name="hm_empnum" value="<%=hm_empnum %>">
				<input type="hidden" id="hm_name" name="hm_name" value="<%=mvo.getHm_name() %>">
				<input type="hidden" id="hm_deptnum" name="hm_deptnum" value="<%=mvo.getHm_deptnum() %>">
				<div align = "center">
					<table align="center">
						<tr>
							<td align="center">해당 공지사항을 확인했습니까?</td>
						</tr>
						<tr>
							<td>
								<div align="center" style="padding:15px;">
									<input type="button" class="button"
										   id="n_check" name="n_check" value="확인">
								</div>
							</td>
						</tr>
					</table>
				</div>
			</form>
         </div>
		
		
<%
	}
%>
	</body>
</html>