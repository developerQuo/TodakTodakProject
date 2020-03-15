<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://kit.fontawesome.com/a076d05399.js"></script>
		<link rel="stylesheet" href="/include/css/commons/menu.css">
		<script type="text/javascript" src="/include/js/commons/menu.js"></script>
		<script type="text/javascript">

			$(function(){
				// 메인메뉴 클릭시
				$(".header-main-menu").click(function(){
					setMenu(this);
// 	 				alert(" main AT main clicked >>> " + $(".main").prop("value"));
					$.get("/etc/setMainSession.td", { main: $(".main").prop("value") })
				});
				
			});

		</script>
	</head>
	<body>
		<!-- header wrap -->
		<div class="header-wrap">
			
			<!-- header-wrap -->
			<div class="header-wrap">
			
				<!-- header inner -->
				<ul class="header-inner">
				
					<!-- header-main-menu -->
					<li><a href="#">
						<i class="header-main-menu">
							<i class="far fa-calendar">&nbsp;<span>일정표</span></i>
							<input type="hidden" value="0"/>
						</i>
					</a></li>
					
					<li><a href="#">
						<i class="header-main-menu">
							<i class="far fa-user">&nbsp;<span>인사관리</span></i>
							<input type="hidden" value="1"/></i>
					</a></li>
		
					<li><a href="#">
						<i class="header-main-menu">
							<i class="far fa-edit">&nbsp;<span>전자결재</span></i>
							<input type="hidden" value="2"/></i>
					</a></li>
		
					<li><a href="#">
						<i class="header-main-menu">
							<i class="far fa-heart">&nbsp;<span>후원관리</span></i>
							<input type="hidden" value="3"/></i>
					</a></li>
					
					<li><a href="#">
						<i class="header-main-menu">
							<i class="fas fa-chalkboard">&nbsp;<span>게시판</span></i>
							<input type="hidden" value="4"/></i>
					</a></li>
					
				</ul>
			</div>
		</div>
		<input class="main" type="hidden" value="0" />
	</body>
</html>