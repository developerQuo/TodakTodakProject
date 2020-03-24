<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
 		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/include/js/scheduler/vendor/css/bootstrap.min.css" >
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				// 메인메뉴 클릭시
				$(".header-main-menu").click(function(){
					setMenu(this);
					$.get("/etc/setMainSession.td", { main: $(".main").prop("value") })
					
				});
				
				  var sBtn = $("ul > li");    //  ul > li 이를 sBtn으로 칭한다. (클릭이벤트는 li에 적용 된다.)
				  sBtn.find("a").click(function(){   // sBtn에 속해 있는  a 찾아 클릭 하면.
				   sBtn.removeClass("active");     // sBtn 속에 (active) 클래스를 삭제 한다.
				   $(this).parent().addClass("active"); // 클릭한 a에 (active)클래스를 넣는다.
				  });
				  
				  var sBtn2 = $("li");    //  ul > li 이를 sBtn으로 칭한다. (클릭이벤트는 li에 적용 된다.)
				  sBtn2.find("a").click(function(){   // sBtn에 속해 있는  a 찾아 클릭 하면.
					  sBtn2.removeClass("active");     // sBtn 속에 (active) 클래스를 삭제 한다.
				   $(this).parent().addClass("active"); // 클릭한 a에 (active)클래스를 넣는다.
				  });
				  
				if ( (location.pathname.indexOf('scheduler') || location.pathname.indexOf('login')) != -1) {
					  $('.schedulerMenu').addClass('active');
					}
				if (location.pathname.indexOf('human') != -1) {
					  $('.humanMenu').addClass('active');
					}
				if (location.pathname.indexOf('ework') != -1) {
					  $('.eworkMenu').addClass('active');
					}
				if (location.pathname.indexOf('sponsor') != -1) {
					  $('.sponsorMenu').addClass('active');
					}
				if (location.pathname.indexOf('board') != -1) {
					  $('.boardMenu').addClass('active');
				}
				
				  });
				

		</script>
	</head>
	<script src="/include/js/scheduler/vendor/js/bootstrap.min.js" ></script>
		<!-- header wrap -->
		<div>
		<nav class="navbar" style="  border-bottom: 3px solid #ed6b5e; height:70px;  line-height:36px;">
			<!-- header-left-wrap -->
			<div>
			    <div class="navbar-header" >
      				<a class="navbar-brand" href="/scheduler/moveScheduler.td"><img src="/resources/RELOGO2.png" alt="logo" style="width:70px"></a>
    			&nbsp;&nbsp;&nbsp;&nbsp;
    			</div>
    			
				<!-- header inner -->
				<ul id="top_menu_list" class="nav navbar-nav navbar-right">						
					<!-- header-main-menu -->
					<li class="schedulerMenu"><a href="/scheduler/moveScheduler.td" class="mainMenu" style="line-height:36px;">
						<i class="header-main-menu" data-value="0">
							<span>일정표</span>
						</i>
					</a></li>
					<li class="humanMenu"><a href="#" class="mainMenu" style="line-height:36px;">
						<i class="header-main-menu"  data-value="1">
							<i>&nbsp;<span>인사관리</span></i></i>
					</a></li>
					<li class="eworkMenu"><a href="#" class="mainMenu " style="line-height:36px;">
						<i class="header-main-menu" data-value="2">
							<i>&nbsp;<span>전자결재</span></i></i>
					</a></li>
		
					<li class="sponsorMenu"><a href="#" class="mainMenu" style="line-height:36px;">
						<i class="header-main-menu" data-value="3">
							<i>&nbsp;<span>후원관리</span></i></i>
					</a></li>
					
					<li class="boardMenu"><a href="#" class="mainMenu" style="line-height:36px;">
						<i class="header-main-menu" data-value="4">
							<i>&nbsp;<span>게시판</span></i></i>
					</a></li>
				</ul>
 			</div>
		</div>
		<ul>
		<li style="float: right;"><a href="/etc/logout.td">
					<span class="glyphicon glyphicon-log-out">&nbsp;로그아웃</span>
		</a></li></ul>
	</nav>
	</body>
</html>