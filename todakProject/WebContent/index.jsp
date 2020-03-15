<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<meta charset="UTF-8">
		<title>login</title>
		<script type="text/javascript">
			function loginAction(){
				document.loginForm.method="POST";
				document.loginForm.action="/etc/login.td";
				document.loginForm.submit();
			}			

			function registAction(){
				document.loginForm.method="POST";
				document.loginForm.action="#";
				document.loginForm.submit();
			}			

			function idPwAction(selector){
				var winWidth = 700;
			    var winHeight = 600;
			    var popupOption= "width="+winWidth+", height="+winHeight;    //팝업창 옵션(optoin)
			    
				if (selector == '0') idPopupOpen(popupOption);
				if (selector == '1') pwPopupOpen(popupOption);
			}			
			
			function idPopupOpen(popupOption){
				var url= "/etc/moveId.td";    //팝업창 페이지 URL
				window.open(url,"",popupOption);
			}

			function pwPopupOpen(popupOption){
				var url= "/etc/movePw.td";    //팝업창 페이지 URL
				window.open(url,"",popupOption);
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
					<td>&nbsp;<input type="password" name="hm_pw" size="20" maxlength="10"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="로그인" onclick="loginAction();">
						<input type="button" value="회원가입" onclick="registAction();">
						<input type="button" value="아이디찾기" onclick="idPwAction('0');">
						<input type="button" value="비밀번호찾기" onclick="idPwAction('1');">
						<input type="reset" value="다시">
					</td>
				</tr>
			</table>
		</form>	
	</body>
</html>