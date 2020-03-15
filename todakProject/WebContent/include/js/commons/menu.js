/**
 * 
 */
// 메뉴 세팅
function setMenu(obj){
	var sbList = [];
	var main = $(obj).find('input').val();
	$(".main").prop("value", main);
//	console.log('ss >>> ' + $(".main").prop("value"));					
	var sidebar_width = 15;
	var container_width = 84;
	var display = 'grid';
	
	// ****서브메뉴 이름은 슈퍼서브메뉴와 연계되어있음.
	if (main == "1") sbList = [['사원 등록/조회', '#', 'far fa-address-card'], 
	                           ['발령 등록/조회', '#', 'fas fa-suitcase']];
	else if (main == "2") sbList = [['결재서류 작성', '#', 'fas fa-edit'], 
	                                ['임시저장함', '/eworkForm/selectAuthBox.td', 'far fa-save'], 
	                                ['결재', '/ework/selectAuth.td', 'fas fa-pen-fancy'], 
	                                ['서명 및 도장', '/ework/selectSignStamp.td', 'fas fa-stamp']];
	else if (main == "3") sbList = [['모금액', '#', 'fas fa-won-sign'],
	                                ['후원인', '/sponsor/selectMember.td', 'fas fa-user'], 
	                                ['비영리단체', '/sponsor/selectCharity.td', 'fas fa-users']];
	else if (main == "4") sbList = [['공지사항', '/board/selectNotice.td', 'fas fa-bullhorn'], 
	                                ['건의사항', '/board/selectSuggestion.td', 'far fa-comments']];
	else {
		sbList = [];
		sidebar_width = 0;
		container_width = 100;
		display = 'none';
		//position = 'static';
	}
	$(".sidebar").css("display", display).css("width", sidebar_width+'%');
	$(".context-container").css("width", container_width+'%');
	sideBar(sbList);
}

// 사이드메뉴 생성
function sideBar(sbList){
	$(".sidebar-menu-content").html("");
	var sidebar = "<ul>";
	for (var i=0; i<sbList.length; i++){
		sidebar += "<li class='sidebar-menu'>";
		var superSbList = superSideBar(sbList[i][0]);
		if(superSbList.length > 0){
			sidebar += "<a href='#' onclick='midMenu(this)'><i class='"+sbList[i][2]+"'>&nbsp;"+sbList[i][0]+"</i></a>";
			var superSidebar = "<ul>";
			for (var j=0; j<superSbList.length; j++){
				superSidebar += "<li class='superSidebar-menu' hidden=true><a href="+superSbList[j][1]+"?message=&selectFunc=><i class='"+superSbList[j][2]+"'>&nbsp;"+superSbList[j][0]+"</i></a></li>";
			}
			superSidebar += "</ul>";
			sidebar += superSidebar;
		}else{
			sidebar += "<a href="+sbList[i][1]+"?message=&selectFunc=><i class='"+sbList[i][2]+"'>&nbsp;"+sbList[i][0]+"</i></a>";
		}
		sidebar += "</li>";
		//console.log("sidebar >>> " + sidebar);
	}
	sidebar += "</ul>";
	$(".sidebar-menu-content").html(sidebar);
}

// 슈퍼 사이드메뉴 생성
function superSideBar(sideBarName){
	var superSbList = [];
	if (sideBarName == "사원 등록/조회") 
		superSbList = [['사원현황', '/#human/selectMember.td', '	fas fa-address-book'], 
	         	       ['부서 인사정보 조회', '#/human/selectPersonAppt.td', 'fas fa-search'], 
	         	       ['회원등록 승인 페이지', '#/human/selectPersonAppt.td', 'fas fa-address-card']];
	else if (sideBarName == "발령 등록/조회") 
		superSbList = [['인사발령 등록/조회', '#/ework/mainPage.td', 'fas fa-sitemap'], 
                       ['부서 인사발령 조회', '#/eworkForm/selectAuthBox.td', 'fas fa-search']];
	else if (sideBarName == "결재서류 작성") 
		superSbList = [['기안서 작성', '#/sponsor/selectSponsorship.td', 'fas fa-envelope-open-text'],
                       ['품의서 작성', '#/sponsor/selectMember.td', 'fas fa-search-dollar'], 
                       ['휴가신청서 작성', '#/sponsor/selectCharity.td', 'fas fa-plane']];
	else if (sideBarName == "모금액") 
		superSbList = [['전체조회', '/sponsor/selectSponsorship.td', '	fas fa-poll'], 
                  	   ['후원인별 조회', '#', 'fas fa-user'], 
                  	   ['비영리단체별 조회', '#', 'fas fa-users']];
	else {
		superSbList = [];
	}
	return superSbList;
}

// 슈퍼 사이드메뉴 hidden
function midMenu(me){
	$(me).siblings("ul").children("li").each(function(index){
		if ($(this).prop("hidden") == true) $(this).prop("hidden", false);
		else $(this).prop("hidden", true);
	});
}
			