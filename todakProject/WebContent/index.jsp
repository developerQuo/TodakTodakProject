<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	String message = (String)request.getAttribute("message");
	//System.out.println(" message >>> " + message);
	if (message != null){
		%>.
		<script type="text/javascript">
			alert('<%= message %>');
		</script>
		<%
	}
%>
<html>
	<style>
	
		
 		body{ 
		    background-image: url(/resources/loginBackground2.png);
		    background-repeat: no-repeat;
		    background-size : cover; 
		}
		
	</style>
	<head>
		<meta charset="UTF-8">
		<title>토닥토닥</title>
		
		<link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
		
		<script type="text/javascript">
			function loginAction(){
				document.loginForm.method="POST";
				document.loginForm.action="/etc/login.td";
				document.loginForm.submit();
			}			
			function registAction(){
				var windowW = 840;  // 창의 가로 길이
		        var windowH = 850;  // 창의 세로 길이
		        var left = Math.ceil((window.screen.width - windowW)/2);
		        var top = Math.ceil((window.screen.height - windowH)/2);


		
				document.loginForm.method="GET";
				var url= "/etc/moveSignup.td";   
				window.open(url,"","l top="+top+", left="+left+", height="+windowH+", width="+windowW);	
					}			
			function idPwAction(selector){
				var winWidth = 700;
			    var winHeight = 600;
			    var popupOption= "width="+winWidth+", height="+winHeight;  //팝업창 옵션(optoin)
			    
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
			
			//엔터키 누르면 로그인 실행
			function enterkey() {
				if(window.event.keyCode == 13) {
					console.log("엔터 누름");
					
					loginAction();
					
				}
			}
			
		</script>		
	</head>
	<body>
	<div  class=""> 
		<div class="login" style="padding:auto">
		<br><br>
			<form name="loginForm" id="loginForm">
	<!-- <p><h2 align="center">TODAK TODAK</h2></p>  -->						
				<table class="login_table" align="center">
					<tr >
							<img src="/resources/RELOGO2.png" alt="logo" width="200"  style="display: block; margin: 0px auto;">
					</tr>
					<br>
					<tr>
						<td>&nbsp;<input type="text" name="hm_id" placeholder="아이디" style="width:261px;height:25px;" maxlength="20" ></td>
					</tr>
					<tr>
						<td>&nbsp;<input type="password" name="hm_pw" placeholder="패스워드" style="width:261px;height:25px;" maxlength="10" onkeyup="enterkey();"></td>
					</tr>
					<tr style="padding-top:-5px">
						<td colspan="2" align="center">
							<input type="button" value="로그인" onclick="loginAction();" class="button" style="width:132px;height:35px;">
							<input type="reset" class="button" value="다시"  style="width:132px;height:35px;">
							<br>
							<input type="button" value="아이디찾기" onclick="idPwAction('0');" class="button" style="width:83px;height:35px;">
							<input type="button" value="비밀번호찾기" onclick="idPwAction('1');" class="button" style="width:90px;height:35px;">
							<input type="button" value="회원가입" onclick="registAction();" class="button"   style="width:83px;height:35px;">
						</td>
					</tr>
				</table>
			</form>	
		</div>
	</div>
	</body>
</html>