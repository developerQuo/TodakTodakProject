<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<% 
	String user_id = sManager.getUserID(session.getId());
	//System.out.println(user_id); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>결재라인 정하기</title>
		
		<script type="text/javascript"
				src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
				
		<link href="/include/css/default.css" rel="stylesheet">
				
		<script type="text/javascript">
			var head = '';
			var team = '';
			var deptnum = '';
			var hm_empnum = '';
			var hm_name = '';
			var hm_position = '';
			var hm_duty = '';
			var arr_empnum = null;
			var arr_name = null;
			var arr_position = null;
			var arr_duty = null;
			var arrLength = 0;
			var head_name = '';
			var team_name = '';
			var member_name = '';
			var line = '';
			
			var user_id = "<%=user_id%>";
			var user_name = "";
			var user_deptnum = "";
			var user_position = "";
			var user_duty = "";
			var user_head = "";
			var user_team = "";
			
			var auth_line = "";
			
			//var default_duty = new Array('18', '19', '20');
			
			
			$(document).ready(function() {
				console.log("제이쿼리");
				
				$('#teams').hide();
				$('#members').hide();
				
				$.ajax({
					url : "../eworkForm/selectPerson.td",
					data : {
						"hm_empnum" : user_id
					},
					success : whenSussessUserInfo,
					error : whenError
				});
				
				head = $('#headquarters option:selected').val(); //option 선택값 가져오기
				console.log('head >>> : ' + head);
				
				$('#headquarters').change(function() {
					console.log('본부 변경');
					
					head = $('#headquarters option:selected').val(); //option 선택값 가져오기
					console.log('head >>> : ' + head);
					
					if(head!= null) {
						
						$('#teams *').remove();	
						$('#members *').remove();
						$('#members').hide();
						
						if(head == '**') {
							console.log("if(head == '**') 진입 >>> ");
							
							$('#teams').hide();
							
						}
						
						if(head == '99') {
							console.log("if(head == '99') 진입 >>> ");
							
							$('#teams').hide();
							
							if(($('#firstApplicant').html() != '') && ($('#secondApplicant').html() != '') && ($('#thirdApplicant').html() == '')) { //이 태그에 아무것도 없으면
								console.log("if(($('#firstApplicant').html() != '') && ($('#secondApplicant').html() != '') && ($('#thirdApplicant').html() == '')) 진입 >>> ");
								
								$('#thirdApplicant').append("<div>배나영(이사)(H202002190013, 임원/ 대표이사)</div><br>"); //이사 값 바뀌면 수정
								//$('#thirdApplicant').append("<div>김예림(이사)(H202002190007, 임원/ 대표이사)</div><br>"); //이사 값 바뀌면 수정
								
								line = line + 'H202002190013-'; //이사 값 바뀌면 수정
								//line = line + 'H202002190007-'; //이사 값 바뀌면 수정
								auth_line = auth_line + '배나영(이사)-'; //이사 값 바뀌면 수정
								//auth_line = auth_line + '김예림(이사)-'; //이사 값 바뀌면 수정
								console.log("auth_line >>> : " + auth_line);
								console.log("line >>> : " + line);
							
							} else {
								alert("3차 결재자는 대표이사여야 합니다.");
							}
							
						}
					
						
						if(head == '03') { //나눔사업본부
							console.log("if(head == '03') 진입 >>> ");
							
							$('#teams').show();
						
							$('#teams').append("<option value='**'>팀/본부 선택</option>");
							$('#teams').append("<option value='11'>배분팀</option>");
							$('#teams').append("<option value='12'>혁신사업팀</option>");
							$('#teams').append("<option value=''>나눔사업본부</option>");
							
						} else if(head == '02') { //마케팅본부
							console.log("if(head == '02') 진입 >>> ");
							
							$('#teams').show();
						
							$('#teams').append("<option value='**'>팀/본부 선택</option>");
							$('#teams').append("<option value='10'>홍보팀</option>");
							$('#teams').append("<option value=''>마케팅본부</option>");
							
						} else if(head == '01') { //전략기획본부
							console.log("if(head == '01') 진입 >>> ");
						
							$('#teams').show();
						
							$('#teams').append("<option value='**'>팀/본부 선택</option>");
							$('#teams').append("<option value='07'>기획팀</option>");
							$('#teams').append("<option value='08'>소통협력팀</option>");
							$('#teams').append("<option value='09'>IT팀</option>");
							$('#teams').append("<option value=''>전략기획본부</option>");
							
						} else if(head == '00') { //경영지원본부
							console.log("if-else 진입 >>> ");
							
							$('#teams').show();
						
							$('#teams').append("<option value='**'>팀/본부 선택</option>");
							$('#teams').append("<option value='04'>인재경영팀</option>");
							$('#teams').append("<option value='05'>재무팀</option>");
							$('#teams').append("<option value='06'>관리팀</option>");
							$('#teams').append("<option value=''>경영지원본부</option>");
							
						}
					}
					
					team = $('#teams option:selected').val(); //option 선택값 가져오기
					console.log('team >>> : ' + team);
					
				});
				
				$('#teams').change(function() {
					console.log('팀 변경');
					
					team = $('#teams option:selected').val(); //option 선택값 가져오기
					console.log('team >>> : ' + team);
					
					console.log("head : " + head + ", team : " + team);
					
					deptnum = head + team ;
					console.log("deptnum : " + deptnum);
					
					$.ajax({
						url : "../eworkForm/selectTeamMember.td",
						data : {
							"hm_deptnum" : deptnum
						},
						success : whenSuccess,
						error : whenError 
					});
					
				});
				
				$('#members').change(function() {
					console.log("임직원 변경");
					
					
					head_name = $('#headquarters option:selected').text();
					console.log('head_name >>> : ' + head_name); // 본부 이름 가져오기
					
					team_name = $('#teams option:selected').text();
					console.log('team_name >>> : ' + team_name); // 팀 이름 가져오기
					
					member = $('#members option:selected').val(); //option 선택값 가져오기
					console.log('member >>> : ' + member); //회원번호 가져오기
					
					member_name = $('#members option:selected').text();
					console.log('member_name >>> : ' + member_name); //이름 가져오기
					
					
					
					//div1, 2, 3이 비었을 때 && 텍스트 값에 "팀장"이 포함되어있으면 div1에 append
					if(($('#firstApplicant').html()=='') && ($('#secondApplicant').html()=='') && ($('#thirdApplicant').html()=='')) {
						
						console.log("if(($('#firstApplicant').html()=='') && ($('#secondApplicant').html()=='') && ($('#thirdApplicant').html()=='')) 진입 >>> ");
						
						if((member_name.indexOf('팀장') != -1) && head == '00') {
							console.log("if(member_name.indexOf('팀장') != -1 && head == '00') 진입 >>> ");
							 
							$('#firstApplicant').append("<div>" + member_name + "(" + member + ", " + head_name + "/ " + team_name + ")</div><br>");
							
							line = line + member + '-';
							auth_line = auth_line + member_name + '-';
							console.log("auth_line >>> : "+ auth_line);
							console.log("line >>> : "+ line);
							
						} else { //div 1, 2, 3이 비었는데 텍스트값에 "팀장"이 없으면 alert
							console.log("if(member_name.indexOf('팀장') != -1 && head == '00')-else 진입 >>> ");
						
							alert("1차 결재자는 재무 팀장이어야 합니다.");
							
						}
						
					} else if(($('#firstApplicant').html()!='') && ($('#secondApplicant').html()=='') && ($('#thirdApplicant').html()=='')) {
						
						console.log("if(($('#firstApplicant').html()!='') && ($('#secondApplicant').html()=='') && ($('#thirdApplicant').html()=='')) 진입 >>> ");
						
						if((member_name.indexOf('본부장') != -1) && (head == '00')) {
							console.log("if((member_name.indexOf('본부장') != -1) && (head == '00')) 진입 >>> ");
							 
							$('#secondApplicant').append("<div>" + member_name + "(" + member + ", " + head_name + ")</div><br>");
							
							line = line + member + '-';
							auth_line = auth_line + member_name + '-';
							console.log("auth_line >>> : "+ auth_line);
							console.log("line >>> : "+ line);
							
						} else { //div 1, 2, 3이 비었는데 텍스트값에 "본부장"이 없으면 alert
							console.log("if((member_name.indexOf('본부장') != -1) && (head == '00'))-else 진입 >>> ");
						
							alert("2차 결재자는 경영지원 본부장이어야 합니다.");
							
						}
						
					} else if(($('#firstApplicant').html() != '') 
										&& ($('#secondApplicant').html() != '') 
										&& ($('#thirdApplicant').html() == '')) {
						console.log("else if(($('#firstApplicant').html() != '') && ($('#secondApplicant').html() != '') && ($('#thirdApplicant').html() == '')) 진입 >>> ");
						
						alert("3차 결재자는 대표이사여야 합니다.");
						
					}
					
				
				});
				
				$('#ok_button').click(function() {
					console.log("확인 버튼 누름");
					
					var line_end = line.length - 1;
					console.log("line_end >>> : " + line_end);
					line = line.substring(0, line_end);
					console.log("line >>> : "+ line);
					
					var authLine_end = auth_line.length - 1;
					console.log("authLine_end >>> : " + authLine_end);
					auth_line = auth_line.substring(0, authLine_end);
					console.log("auth_line >>> : "+ auth_line);
					
					console.log("user_id >>> : "+ user_id);
					
					line = user_id + "-" + line;
					console.log("line >>> : "+ line);
					
					auth_line = user_name + "(" + position(user_position) + ", " + duty(user_duty) + ")-" + auth_line;
					console.log("auth_line >>> : " + auth_line);
						
					$('input[name=el_line]').val(line);
					console.log($('input[name=el_line]').val());
					
					if(line.length < 55) {
						console.log("else if(line.length < 55) 진입 >>> ");
						
						alert("결재자는 총 3명이어야 합니다.");
						line = '';
						console.log("line >>> : " + line);
						auth_line = '';
						console.log("auth_line >>> : " + auth_line);
						
					} else {
						console.log("if(line.length < 55)-else 진입 >>> ");
						
						if(auth_line!='') {
							console.log("if(auth_line!='') 진입 >>> ");
							
							//opener: 나를 부른 부모창 
							window.opener.document.getElementById('auth_line').value = auth_line; //부모창에게 전달하기
						}
						
						$('#form_tag')
						.attr('action', '/eworkForm/insertLine.td')
						.submit();
					
					
					}
					
				});
				
				$('#reset_button').click(function() {
					console.log("초기화 버튼");
					
					$('#firstApplicant *').remove();
					$('#secondApplicant *').remove();
					$('#thirdApplicant *').remove();
					
					line = '';
					console.log("line >>> : " + line);
					
					return false;
				});
				
			});
			
			function whenSussessUserInfo(data) {
				console.log("성공");
				console.log(data);
				
				user_name = $(data).find("hm_name").text();
				user_deptnum = $(data).find("hm_deptnum").text();
				user_position = $(data).find("hm_position").text();
				user_duty = $(data).find("hm_duty").text();
				
				console.log("user_name >>> : " + user_name);
				console.log("user_deptnum >>> : " + user_deptnum);
				console.log("user_position >>> : " + user_position);
				console.log("user_duty >>> : " + user_duty);
				
				
				
			}
			
			function whenSuccess(data) {
				console.log("성공");
				console.log(data);
				
				hm_empnum = $(data).find("empnum").text();
				console.log(hm_empnum);
				hm_name = $(data).find("name").text();
				console.log(hm_name);
				hm_position = $(data).find("position").text();
				console.log(hm_position);
				hm_duty = $(data).find("duty").text();
				console.log(hm_duty);
				
				arr_empnum = hm_empnum.split(",");
				console.log(arr_empnum);
				arr_name = hm_name.split(",");
				console.log(arr_name);
				arr_position = hm_position.split(",");
				console.log(arr_position);
				arr_duty = hm_duty.split(",");
				console.log(arr_duty);
				
				listSize = $(data).find("listSize").text();
				console.log(listSize);
				
				for(var i=0; i<listSize; i++) {
					console.log(arr_empnum[i]);
					console.log(arr_name[i]);
					console.log(arr_position[i]);
					console.log(arr_duty[i]);
				}

				selectMember(team, listSize);
				
			}
			
			function whenError() {
				alert("실패");
			}
			
			function position(hm_position) {
				console.log("function position(hm_position) 시작 >>> ");
				console.log("hm_position >>> : " + hm_position);
				
				var position = "";
				
				if(hm_position == '17') position = "사원"
				else if(hm_position == '16') position = "대리";
				else if(hm_position == '15') position = "과장";
				else if(hm_position == '14') position = "부장";
				else if(hm_position == '13')position = "임원";
				else position = '';
				
				return position;
			}
			
			function duty(hm_duty) {
				console.log("function duty(hm_duty) 시작 >>> ");
				console.log("hm_duty >>> : " + hm_duty);
				
				var duty = "";
				
				if(hm_duty == '18') duty = '팀장';
				else if(hm_duty == '19') duty = '본부장';
				else if(hm_duty == '20') duty = '대표이사';
				else if(hm_duty == '67') duty = '없음';
				else if(hm_duty == '73') duty = '없음';
				else if(hm_duty == '98') duty = '기타';
				else duty = '';
				
				return duty;
				
			}
			
			function selectMember(team, listSize){
				console.log("function selectMember(team, arrLength) 시작 >>> ");
				console.log("team >>> : " + team);
				console.log("listSize >>> : " + listSize);
				console.log("hm_position >>> : " + hm_position);
				
				member = $('#members option:selected').val(); //option 선택값 가져오기
				console.log('member >>> : ' + member);
				
				if(team!=null) {
					
					$('#members *').remove();	
					$('#members').show();
				}
				
				if(team == '**') {
					$('#members *').remove();
					$('#members').hide();
				}
					
				$('#members').append("<option value='**'>임직원 선택</option>");
				console.log("listSize >>> : " + listSize);
					
				
				
				for(var i=0; i<listSize; i++) {
					console.log("for문 들어옴" + i);
						
					$('#members').append("<option value='" + arr_empnum[i] + "'>" + arr_name[i] 
														+ "(" +	position(arr_position[i]) + ", " + duty(arr_duty[i]) + ")</option>");
					
				}

			} 
		</script>
	</head>
	<body>
	<form id="form_tag" name="form_tag" method="POST">
		<!-- 
				1.
				세션에 있는 회원번호를 가지고 그 회원의
				부서번호, 직급, 직책의 정보를 DB에서 가져옴
				2.
				부서번호를 이용하여 재무팀장의 회원번호를 가져옴
				3.
				부서번호를 이용하여 경영지원본부장의 회원번호를 가져옴
				4.
				부서번호를 이용하여 대표이사의 회원번호를 가져옴			
		 -->
		 <br><br>
		 <select id="headquarters">
		 	<option id="select_head" value="**" selected>본부 선택</option>
		 	<option id="management_support" value="00">경영지원본부</option>
		 	<option id="strategic_planning" value="01">전략기획본부</option>
		 	<option id="marketing" value="02">마케팅본부</option>
		 	<option id="sharing_biz" value="03">나눔사업본부</option>
		 	<option id="ceo" value="99">대표이사</option> <!-- 대표이사..!!!!!!! -->
		 </select>
		 <select id="teams">
		 </select>
		 <select id="members">
		 </select>
		 
		 <p><br><br>
		 <hr>
		 
		 <div style="width:720px; height:300px;">
		 
		 	<div id="firstApplicant"></div>
		 	<div id="secondApplicant"></div>
		 	<div id="thirdApplicant"></div>
			<br>
		 
		 </div>
		 
		 <div id="button" align="right">
		 	<input type="button" id="reset_button" class="button" style="width:50px;" value="초기화" align="right">
		 	<input type="button" id="ok_button" class="button" style="width:50px;" value=" 확인 " align="right">
		 	<input type='hidden' id='el_line' name='el_line' value=''>
		 </div>
	</form>
	</body>
</html>