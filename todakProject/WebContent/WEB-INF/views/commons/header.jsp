<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<script src="https://kit.fontawesome.com/a076d05399.js"></script>
		<link rel="stylesheet" href="../../../include/css/commons/menu.css">
		<!-- 
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" 
				src="/include/js/jquery-1.11.0.min.js" ></script> -->
		<script type="text/javascript">
			$(function(){
				// 메인메뉴 클릭시
				$(".header-main-menu").click(function(){
					var sbList = [];
					var main = $(this).find('input').val();
					var sidebar_width = 15;
					var container_width = 84;
					var display = 'grid';
					
					if (main == "1") sbList = [['사원 등록/조회', '/human/selectMember.td', 'far fa-address-card'], 
					                           ['발령 등록/조회', '/human/selectPersonAppt.td', 'fas fa-suitcase']];
					else if (main == "2") sbList = [['결재서류 작성', '/ework/mainPage.td', 'fas fa-edit'], 
					                                ['임시저장함', '/eworkForm/selectAuthBox.td', 'far fa-save'], 
					                                ['결재', '/ework/selectAuth.td', 'fas fa-pen-fancy'], 
					                                ['서명 및 도장', '/ework/selectSignStamp.td', 'fas fa-stamp']];
					else if (main == "3") sbList = [['모금액', '/sponsor/selectSponsorship.td', 'fas fa-won-sign'],
					                                ['후원인', '/sponsor/selectMember.td', 'fas fa-user'], 
					                                ['비영리단체', '/sponsor/selectCharity.td', 'fas fa-users']];
					else if (main == "4") sbList = [['공지사항', '/board/selectNotice.td', 'fas fa-bullhorn'], 
					                                ['건의사항', '/board/selectSuggestion.td', 'far fa-comments']];
					else {
						sbList = [];
						sidebar_width = 0;
						container_width = 100;
						display = 'none';
					}
					$(".sidebar").css("display", display).css("width", sidebar_width+'%');
					$(".context-container").css("width", container_width+'%');
					sideBar(sbList);
				});
				
			});
			
			// 사이드메뉴 생성
			function sideBar(sbList){
				$(".sidebar-menu-content").html("");
				var sidebar = "<ul>";
				for (var i=0; i<sbList.length; i++){
					sidebar += "<li class='sidebar-menu'><a href="+sbList[i][1]+"?message=&selectFunc=><i class='"+sbList[i][2]+"'>&nbsp;"+sbList[i][0]+"</i></a></li>";
				}
				sidebar += "</ul>";
				//alert(sidebar);
				$(".sidebar-menu-content").html(sidebar);
			}
			
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
	</body>
</html>