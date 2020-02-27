<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java142.todak.etc.utils.LoginSession"%>


<%
	LoginSession sManager = LoginSession.getInstance();
	String num = sManager.getUserID(session.getId());
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
			location.href="../../../index.jsp";
		</script>
<%
	}
%>
