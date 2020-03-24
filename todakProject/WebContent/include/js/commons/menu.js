var menu_id = 0;
var sbList;
function setMenu(obj){
	$(".sidebar-wrap").css("display", "block").css("width", '100%');
	var sbList = [];
	var main = $(obj).attr("data-value");
	console.log("main",main);
	$(".main").prop("value", main);			
	var sidebar_width = 15;
	var container_width = 84;
	var display = 'grid';
	
	// ****서브메뉴 이름은 슈퍼서브메뉴와 연계되어있음.
	if (main == "1") sbList = [['사원 등록/조회', '#','1_1'], 
	                           ['발령 등록/조회', '#','1_2']];
	if (main == "2") sbList = [['결재서류 작성', '#','1_3'], 
	                                ['결재', '/ework/selectAuthBox.td','2_1'], 
	                                ['서명 및 도장', '/ework/moveInsertSignStamp.td','2_2']];
	if (main == "3") sbList = [['모금액', '#','3_1'],
	                                ['후원인', '/sponsor/selectMember.td','3_2'], 
	                                ['비영리단체', '/sponsor/selectCharity.td','3_3']];
	if (main == "4") sbList = [['공지사항', '/board/selectNotice.td','4_1'], 
	                                ['건의사항', '/board/selectSuggestion.td','4_2']];
	$(".sidebar").css("display", display).css("width", sidebar_width+'%');
	$(".context-container").css("width", container_width+'%');
	if (main != "0") sideBar(sbList);
	
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
				superSidebar += "<li class='superSidebar-menu' hidden=true onclick=superSidebarClick(this,"+superSbList[j][2]+")><a href="+superSbList[j][1]+"?message=&selectFunc=><i class='"+superSbList[j][2]+"'>&nbsp;"+superSbList[j][0]+"</i></a></li>";
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
	$(".sidebar").css("margin-top", "0");
	$(".sidebar-menu-content").html(sidebar);
}

// 슈퍼 사이드메뉴 생성
function superSideBar(sideBarName){
	menu_id = $(this).attr("data-value");
	var superSbList = [];
	if (sideBarName == "사원 등록/조회") 
		superSbList = [['사원현황', '/human/select.td'], 
	         	       ['부서 인사정보 조회', '#'], 
	         	       ['사원등록 승인', '#']];
	else if (sideBarName == "발령 등록/조회") 
		superSbList = [['인사발령 등록', '#'], 
                       ['부서 인사발령 조회', '#']];
	else if (sideBarName == "결재서류 작성") 
		superSbList = [['기안서 작성', '/eworkForm/moveInsertProposal.td'],
                       ['품의서 작성', '/eworkForm/moveInsertApproval.td'], 
                       ['휴가신청서 작성', '/eworkForm/moveInsertHoliday.td']];
	else if (sideBarName == "모금액") 
		superSbList = [['전체 조회', '/sponsor/selectSponsorship.td'], 
                  	   ['후원인별 조회', '#'], 
                  	   ['비영리단체별 조회', '#']];
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

//슈퍼 사이드메뉴 클릭시
function superSidebarClick(obj){
	$(function(){
		// a태그로 이동하는지 여부
		var hasChild = $(obj).children("a").prop("href").indexOf('#');
		if (hasChild != -1){
			
			if ($(obj).children("a").text() == " 후원인별 조회"){
				$.get("/sponsor/selectMember.td", { selectFunc: "ajax" }, function(data, status){
					listing(data);
				  });
			}
			if ($(obj).children("a").text() == " 비영리단체별 조회"){
				$.get("/sponsor/selectCharity.td", { selectFunc: "ajax" }, function(data, status){
					listing(data);
				  });
			}
			if ($(obj).children("a").text() == " 회원등록 승인"){
				
				$.ajax({
					url:"/human/Authority.td",
					type:"POST",
					error:function(){
						alert('시스템 오류 입니다. 관리자에게 문의 하세요');
					},
					success:function(resultData){
						if(resultData==false){
							alert("권한이 불충분합니다!");
						}
						if(resultData==true){
							location.href="/human/selectAppr.td";
						}
					}
				});
				}
			if ($(obj).children("a").text() == " 인사발령 등록"){
				$.ajax({
					url:"/human/Authority.td",
					type:"POST",
					error:function(){
						alert('시스템 오류 입니다. 관리자에게 문의 하세요');
					},
					success:function(resultData){
						if(resultData==false){
							alert("권한이 불충분합니다!");
						}
						if(resultData==true){
							location.href="/human/apptSelect.td";
						}
					}
				});
				}
			if ($(obj).children("a").text() == " 부서 인사발령 조회"){
				$.ajax({
					url:"/human/Authority.td",
					type:"POST",
					error:function(){
						alert('시스템 오류 입니다. 관리자에게 문의 하세요');
					},
					success:function(resultData){
						if(resultData==false){
							alert("권한이 불충분합니다!");
						}
						if(resultData==true){
							location.href="/human/apptAllselect.td";
							
						}
					}
				});
				}
			if ($(obj).children("a").text() == " 부서 인사정보 조회"){
				
				$.ajax({
					url:"/human/deptAuthority.td",
					type:"POST",
					error:function(){
						alert('시스템 오류 입니다. 관리자에게 문의 하세요');
					},
					success:function(resultData){
						if(resultData==false){
							alert("권한이 불충분합니다!");
						}
						if(resultData==true){
							location.href="/human/deptReference.td";
						
						}
					}
				});
				}
			
		}
		
	});
}

//울트라사이드바 메뉴 리스팅
function listing(data){

	// 기존 사이드바 넓이 늘리기
	$(".sidebar").css("display", "table").css("width", '30%');
	// 새로운 사이드바 영역확보하기
	$(".sidebar-wrap").css("display", "table-cell").css("width", '46%').css("vertical-align", 'top');
	$(".ultraSidebar").css("display", "table-cell").css("border-left", "white 2px solid");
	// context-container 넓이 줄이기
	$(".context-container").css("width", '69%');
	$(".ultraSidebar-content").html("로딩중...").css("text-align", "center").css("vertical-align", "middle");
	
	var aList = [];
	$(data).find('aList').each(function(){
		var num = $(this).find('num').text();
		var name = $(this).find('name').text();
		aList.push([num, name]);
	});

	ultraSideBar(aList);
	
}

//후원인별 & 비영리단체별 사이드바 
function ultraSideBar(aList){
	// 사이드바에 목록 리스팅하기
	var listingText = "<ul>";
	for(var i=0; i<aList.length; i++){
		var numbering = ""+(i+1);
		while(numbering.length < 3){
			numbering = '0' + numbering;
		}
		listingText += "<li>"+numbering+"&nbsp;<a href='#' onclick='ultraSidebarClicked(this)'>&nbsp;<label>"+aList[i][0]+"</label>&nbsp;<label>"+aList[i][1]+"</label></a></li>";
	}
	
	listingText += "</ul>";

	$(".ultraSidebar-content").html(listingText);
}

//울트라사이드바 메뉴 클릭시
function ultraSidebarClicked(obj){
	var name = $(obj).children("label:last").text();
	var num = $(obj).children("label:first").text();
	var url = "/sponsor/selectSponsorship.td?";
	if(num.charAt() == 'M'){
		url += "sm_num="+num + "&sm_name=" + name;
	}
	if(num.charAt() == 'N'){
		url += "sc_num="+num + "&sc_name=" + name;
	}

	location.href = url;
}

$(document).ready(function(){

	if (location.pathname.indexOf('human') != -1) {
		setMenu($("#top_menu_list").find("li").eq(1).find(".mainMenu").find(".header-main-menu"));
		 $('this').addClass('active');
		}
	if (location.pathname.indexOf('ework') != -1) {
		setMenu($("#top_menu_list").find("li").eq(2).find(".mainMenu").find(".header-main-menu"));
		}
	if (location.pathname.indexOf('sponsor') != -1) {
		setMenu($("#top_menu_list").find("li").eq(3).find(".mainMenu").find(".header-main-menu"));
		 $('.sidebar-menu').addClass('active');
		}
	if (location.pathname.indexOf('board') != -1) {
		setMenu($("#top_menu_list").find("li").eq(4).find(".mainMenu").find(".header-main-menu"));
	}
})