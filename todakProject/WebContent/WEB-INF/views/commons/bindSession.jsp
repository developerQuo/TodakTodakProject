<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.etc.utils.LoginSession"%>


<%
	LoginSession sManager = LoginSession.getInstance();
	String num = sManager.getUserID(session.getId());
// 	System.out.println(" main IN bindSession >>> " + sManager.getMain(session.getId()));
%>

	<h3> 현재 접속자 수 : <%= sManager.getUserCount()%> </h3>
	<hr>
<%
	if (sManager.isLogin(session.getId()))
	{
%>
		<%= sManager.getUserID(session.getId()) %> 님 로그인함.
		<br>
		<p>
		<a href="/etc/logout.td">로그 아웃</a>
<%
	}
	else
	{
%>
		<script type="text/javascript">
			location.href="/index.jsp";
		</script>
<%
	}
%>

		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script src="https://kit.fontawesome.com/a076d05399.js"></script>
		<link rel="stylesheet" href="/include/css/commons/menu.css">
		<script type="text/javascript" src="/include/js/commons/menu.js"></script>
		<script type="text/javascript">
		// 페이지 refresh 됐을 떄
			$(function(){
				$(".main").prop("value", <%=sManager.getMain(session.getId())%>);
				var obj = $(".header-inner li:eq("+$(".main").prop("value")+")");
				setMenu(obj);
				
			});

		</script>