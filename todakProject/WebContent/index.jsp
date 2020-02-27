<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	String message = (String)request.getAttribute("message");
	//System.out.println(" message >>> " + message);
	if (message != null){
		%>
		<script type="text/javascript">
			alert('<%= message %>');
		</script>
		<%
	}
%>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>login</title>
		<script type="text/javascript">
			function checkAction(){
				document.loginForm.method="POST";
				document.loginForm.action="/etc/login.td";
				document.loginForm.submit();
			}			
		</script>		
	</head>
	<body>
		<form name="loginForm" id="loginForm">			
			<p><h3 align="center">로그인</h3></p>			
			<table align="center" border="1">
				<tr>
					<td align="center">아이디</td>
					<td>&nbsp;<input type="text" name="hm_id" size="20" maxlength="20"></td>
				</tr>
				<tr>
					<td align="center">패스워드</td>
					<td>&nbsp;<input type="text" name="hm_pw" size="20" maxlength="10"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="로그인" onclick="checkAction();">
						<input type="reset" value="다시">
					</td>
				</tr>
			</table>
		</form>	
	</body>
</html>