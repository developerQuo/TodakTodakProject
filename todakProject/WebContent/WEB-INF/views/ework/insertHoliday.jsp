<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.ework.vo.AuthVO" %>
<%@ page import="java142.todak.ework.vo.HolidayVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<% 
	String user_id = sManager.getUserID(session.getId());
	//System.out.println(user_id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>휴가신청서 작성하기</title>
			
		<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
		<script type="text/javascript"
			src="../webedit/dist/js/service/HuskyEZCreator.js" charset="utf-8"></script>

		<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
		<script type="text/javascript"
			src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
			
		<link href="/include/css/default.css" rel="stylesheet">

		<!-- function 함수 짜야함 -->
		
		<script type="text/javascript">
			var oEditors = [];
			var setLine = null;
			var user_id = "<%=user_id%>";
			var auth_line = "";
			
			$(function() {
				
				console.log("제이쿼리");
				
				$.ajax({
					url : "../eworkForm/selectPerson.td",
					data : {
						"hm_empnum" : user_id
					},
					success : whenSussessUserInfo,
					error : whenError
				});
				
				nhn.husky.EZCreator.createInIFrame({
					oAppRef : oEditors,
					elPlaceHolder : "eh_reason", //textarea에서 지정한 id와 일치해야 합니다. 
					//SmartEditor2Skin.html 파일이 존재하는 경로
					sSkinURI : "../webedit/dist/SmartEditor2Skin.html",
					htParams : {
						// 툴바 사용 여부 (true:사용/ false:사용하지 않음),글씨체 포인트,정렬,색상등등
						bUseToolbar : true,
						// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseVerticalResizer : true,
						// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
						bUseModeChanger : true,
						fOnBeforeUnload : function() {
						}
					},
					fOnAppLoad : function() {
						
						var get_title = localStorage.getItem("title");
						var get_startdate = localStorage.getItem("startdate");
						var get_enddate = localStorage.getItem("enddate");
						var get_startperiod = localStorage.getItem("startperiod");
						var get_endperiod = localStorage.getItem("endperiod");
						var get_reason = localStorage.getItem("reason");
						
						if(get_reason!=null) {
							console.log("if(get_reason!=null) 진입 >>> ");
						
							var remove_reason = get_reason.replace(/(<([^>]+)>)/ig,""); //태그 모두 지우고 텍스트만 남기기
						
						}
						
						var get_emergency1 = localStorage.getItem("emergency1");
						var get_emergency2 = localStorage.getItem("emergency2");
						var get_emergency3 = localStorage.getItem("emergency3");
						console.log("get_title >>> : " + get_title);
						console.log("get_startdate >>> : " + get_startdate);
						console.log("get_enddate >>> : " + get_enddate);
						console.log("get_startperiod >>> : " + get_startperiod);
						console.log("get_endperiod >>> : " + get_endperiod);
						//console.log("get_reason >>>:" + get_reason + "<<<");
						console.log("remove_reason >>> : " + remove_reason);
						console.log("get_emergency1 >>> : " + get_emergency1);
						console.log("get_emergency2 >>> : " + get_emergency2);
						console.log("get_emergency3 >>> : " + get_emergency3);
						
						if((get_title!=null) || (get_startdate!=null) || (get_enddate!=null) 
											 || (get_startperiod!=null) || (get_endperiod!=null) || (get_reason!=null)
											 							|| (get_emergency2!=null) || (get_emergency3!=null)) {
						
							console.log("if((get_title!=null) || (get_startdate!=null) || (get_enddate!=null) " + 
															 "|| (get_startperiod!=null) || (get_endperiod!=null)|| (remove_reason!=null) " +
															 							"|| (get_emergency2!=null) || (get_emergency3!=null)) 진입 >>> ");
							
							if((get_title!='') || (get_startdate!='') || (get_enddate!='') 
												|| (get_startperiod!='') || (get_endperiod!='') || (remove_reason!='')
																							|| (get_emergency2!='') || (get_emergency3!='')) {
								console.log("if((get_title!='') || (get_startdate!='') || (get_enddate!='') " +
													"|| (get_startperiod!='') || (get_endperiod!='') || (get_reason.indexOf('<p><br></p>')==-1)" + 
																	"|| (get_emergency2!=null) || (get_emergency3!=null)) 진입 >>> ");
								
								if(confirm("작성했던 내용이 존재합니다. 불러오겠습니까?")) {
									console.log("if(confirm('작성했던 내용이 존재합니다. 불러오겠습니까?')) 진입 >>> ");
									
									var reason = localStorage.getItem("reason");
									console.log(reason);
									
									oEditors.getById["eh_reason"].exec("PASTE_HTML", [ reason ]);
									$('#eh_title').attr("value", localStorage.getItem("title"));
									$('#eh_startdate').attr("value", localStorage.getItem("startdate"));
									$('#eh_enddate').attr("value", localStorage.getItem("enddate"));
									$('#eh_startperiod').attr("value", localStorage.getItem("startperiod"));
									$('#eh_endperiod').attr("value", localStorage.getItem("endperiod"));
									
									$("#" + localStorage.getItem("emergency1")).attr("selected","selected");
									
									//$('#ep_startdate').attr("value", localStorage.getItem("emergency1"));
									
									$('#ep_startdate').attr("value", localStorage.getItem("emergency2"));
									$('#ep_startdate').attr("value", localStorage.getItem("emergency3"));
									
									
								} else {
									console.log("else 진입 >>> ");
									
									localStorage.removeItem("title");
									localStorage.removeItem("startdate");
									localStorage.removeItem("enddate");
									localStorage.removeItem("reason");
								}
								
							}
						}
						
						//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
						//oEditors.getById["eh_reason"].exec("PASTE_HTML", [ "" ]);
					},
					fCreator : "createSEditor2"
				});
					
				//----------------------- 임시저장 -----------------------
	      		setInterval(function() {
	      			
	      			var eh_reason = oEditors.getById["eh_reason"].getIR(); //<p><br></p>
					console.log("'eh_reason' : " + eh_reason);
	      			
	      			localStorage.setItem("title", $('#eh_title').val()); //제목
	          		localStorage.setItem("startdate", $('#eh_startdate').val()); //결재시작일
	          		localStorage.setItem("enddate", $('#eh_enddate').val()); //결재마감일
	          		localStorage.setItem("startperiod", $('#eh_startperiod').val()); //휴가시작일
	          		localStorage.setItem("endperiod", $('#eh_endperiod').val()); //휴가종료일
	          		localStorage.setItem("reason", eh_reason); //휴가 사유
	          		localStorage.setItem("emergency1", $('#eh_emergency1').val()); //전화번호 앞자리
	          		localStorage.setItem("emergency2", $('#eh_emergency2').val()); //전화번호 중간
	          		localStorage.setItem("emergency3", $('#eh_emergency3').val()); //전화번호 뒷자리
	          		
	          		console.log(localStorage.getItem("title"));
	          		console.log(localStorage.getItem("startdate"));
	          		console.log(localStorage.getItem("enddate"));
	          		console.log(localStorage.getItem("startperiod"));
	          		console.log(localStorage.getItem("endperiod"));
	          		console.log(localStorage.getItem("reason"));
	          		console.log(localStorage.getItem("emergency1"));
	          		console.log(localStorage.getItem("emergency2"));
	          		console.log(localStorage.getItem("emergency3"));
	          		
	      		}, 1000*10); //10초
	      		
	      		//---------------------- 임시저장 끝 ----------------------	
				
				//------------------------------------------------------------------------
				
				$('#lineB').click(function() {
					console.log("휴가신청서 결재라인 정하기");
					
					setLine = window.open('/eworkForm/moveSetHolidayLine.td', 
										  '결재라인', 'width=600, height=600, resizable=no, scrollbars=no');
					console.log("setLine >>> : " + setLine);
					
					//$('#writeForm').attr('action', '/ework/moveSetHolidayLine.td').submit();
					
				});
				
				$('#draftB').click(function() {
					console.log("기안");
					var eh_emergency1 = $('#eh_emergency1 option:selected').val();
					console.log("eh_emergency1 >>> : " + eh_emergency1);
					var eh_emergency2 = $('#eh_emergency2').val();
					console.log("eh_emergency2 >>> : " + eh_emergency2);
					var eh_emergency3 = $('#eh_emergency3').val()
					console.log("eh_emergency3 >>> : " + eh_emergency3);
					
					console.log("eh_emergency >>> : " + eh_emergency1 + eh_emergency2 + eh_emergency3);
					
					$('#eh_emergency').attr('value', eh_emergency1 + eh_emergency2 + eh_emergency3);
					
					if(!setLineFunction()) return false;
					if(!validation()) return false;
					
					
					oEditors.getById["eh_reason"].exec("UPDATE_CONTENTS_FIELD", []);
					
					$("#writeForm")
					.attr("action", "../eworkForm/insertHoliday.td")
					.submit();
					
				});
				
			});
			
			//----------------------------------- js -----------------------------------
			
			function whenSussessUserInfo(data) {
				console.log("성공");
				console.log(data);
				
				user_name = $(data).find("hm_name").text();
				//user_deptnum = $(data).find("hm_deptnum").text();
				user_position = $(data).find("hm_position").text();
				//user_duty = $(data).find("hm_duty").text();
				
				console.log("user_name >>> : " + user_name);
				//console.log("user_deptnum >>> : " + user_deptnum);
				console.log("user_position >>> : " + user_position);
				//console.log("user_duty >>> : " + user_duty);
				
				$('#eh_writer').attr('value', user_name);
				$('#position').attr('value', position(user_position));
				$('#hm_position').attr('value', user_position);
				
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
			
			function setLineFunction() {
				if(!$('#auth_line').val()) {
					alert("결재라인을 설정하지 않았습니다.");
					return false;
				}
				return true;
			}
			
			function validation() {
				console.log("function validation()");
				
				var eh_startdate = $("#eh_startdate").val();
				var eh_enddate = $("#eh_enddate").val();
				var eh_startperiod = $("#eh_startperiod").val();
				var eh_endperiod = $("#eh_endperiod").val();
				
				var eh_reason = oEditors.getById["eh_reason"].getIR(); //<p><br></p>
				console.log("eh_reason : " + eh_reason);
				
				if(!$("#eh_num").val()) {
					console.log("if(!$('#eh_num').val())");
					alert("휴가신청서 번호를 입력하세요.");
					$("#eh_num").focus();
					return false;
				}
				
				if(!$("#ea_num").val()) {
					console.log("if(!$('#ea_num').val())");
					alert("결재번호를 입력하세요.");
					$("#ea_num").focus();
					return false;
				}
				
				if(!$("#eh_title").val()) {
					console.log("if(!$('#eh_title').val())");
					alert("제목을 입력하세요.");
					$("#eh_title").focus();
					return false;
				}
				
				if(!$("#eh_writer").val()) {
					console.log("if(!$('#eh_writer').val())");
					alert("작성자를 입력하세요.");
					$("#eh_writer").focus();
					return false;
				}
				
				if(!$("#position").val()) {
					console.log("if(!$('#position').val())");
					alert("직급을 입력하세요.");
					$("#position").focus();
					return false;
				}
				
				if(!eh_startdate) {
					console.log("if(!$('#eh_startdate').val())");
					alert("결재 시작일을 입력하세요.");
					$("#eh_startdate").focus();
					return false;
				}
				
				if(!eh_enddate) {
					console.log("if(!$('#eh_enddate').val())");
					alert("결재 종료일을 입력하세요.");
					$("#eh_enddate").focus();
					return false;
				}
				
				if(!eh_startperiod) {
					console.log("if(!$('#eh_startperiod').val())");
					alert("휴가 시작일을 입력하세요.");
					$("#eh_startperiod").focus();
					return false;
				}
				
				if(!eh_endperiod) {
					console.log("if(!$('#eh_endperiod').val())");
					alert("휴가 종료일을 입력하세요.");
					$("#eh_endperiod").focus();
					return false;
				}
				
				if(eh_startdate > eh_enddate) {
					console.log("if(eh_startdate > eh_enddate)");
					alert("결재 시작일은 결재 종료일보다 빨라야 합니다.");
					return false;
				}
				
				if(eh_startperiod > eh_endperiod) {
					console.log("if(eh_startperiod > eh_endperiod)");
					alert("휴가 시작일은 휴가 종료일보다 빨라야 합니다.");
					return false;
				}
				
				if(eh_reason=='<p><br></p>' || eh_reason=='') {
					console.log("if(eh_reason=='<p><br></p>' || eh_reason=='')");
					alert("내용을 입력하세요.");
					$("#eh_reason").focus();
					return false;
				}
				
				if(!$("#eh_emergency2").val()) {
					console.log("if(!$('#eh_emergency2').val())");
					alert("전화번호 중간자리를 입력하세요.");
					$("#eh_emergency2").focus();
					return false;
				}
				
				if(!$("#eh_emergency3").val()) {
					console.log("if(!$('#eh_emergency3').val())");
					alert("전화번호 뒷자리를 입력하세요.");
					$("#eh_emergency3").focus();
					return false;
				}
				
				return true;
			}
		</script>
	
	</head>
	<body>
		<header class="header"> 
           <%@ include file="/WEB-INF/views/commons/header.jsp" %>
        </header>

        <aside class="sidebar">
           <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
        </aside>
        
        <div class="context-container">
        
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
      	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
      	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
      	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>
      	<script type="text/javascript">
      		//<![CDATA[
      		$(function() {
      			$.datepicker.setDefaults({
      			    dateFormat: 'yymmdd' //Input Display Format 변경
      			});
      			$('#eh_startdate').datepicker({
      				showOn: "button",
                    //buttonImage: "images/calendar.gif",
                   	buttonImageOnly: false,
                  	buttonText: "날짜 설정"
      			});
      			
      			$('#eh_enddate').datepicker({
                	showOn: "button",
                    //buttonImage: "images/calendar.gif",
                   	buttonImageOnly: false,
                  	buttonText: "날짜 설정"
				});
      			
      			$('#eh_startperiod').datepicker({
      				showOn: "button",
                    //buttonImage: "images/calendar.gif",
                   	buttonImageOnly: false,
                  	buttonText: "날짜 설정"
      			});
      			
      			$('#eh_endperiod').datepicker({
                	showOn: "button",
                    //buttonImage: "images/calendar.gif",
                   	buttonImageOnly: false,
                  	buttonText: "날짜 설정"
				});
      			
      		});
      	</script>
        
		<%
			String eh_num = "";	
			String ea_num = "";
		
			Object obj = null;
			obj = request.getAttribute("hvo");
			//System.out.println("obj >>> : " + obj);
			
			Object obj2 = null;
			obj2 = request.getAttribute("auvo");
			
			if(obj!=null) {
				//System.out.println("if(obj!=null) 진입 >>> ");
				
				HolidayVO hvo = (HolidayVO) obj;
				//System.out.println("hvo >>> : " + hvo);
				eh_num = hvo.getEh_num();
				//System.out.println("eh_num >>> : " + eh_num);
				
			}
			
			if(obj2!=null) {
				//System.out.println("if(obj2!=null) 진입 >>> ");
				
				AuthVO auvo = (AuthVO) obj2;
				//System.out.println("auvo >>> : " + auvo);
				ea_num = auvo.getEa_num();
				//System.out.println("ea_num >>> : " + ea_num);
				
			}
		%>
	        <h3><b>휴가신청서 작성</b></h3>
	        <hr>
	        <br>	
			<form id="writeForm" name="writeForm" method="POST">
			<div class="write_table">
				<table id="writeHoliday">
					<tr>
						<td>결재라인</td>
						<td>
							<input type="text" id="auth_line" name="auth_line" size="66px" readonly>
						</td>
					</tr>
					<!-- 넣을수도 있고 빼도 될거같고 -->
					<tr>
						<td>서류번호</td>
						<td width="600">
							<input type="text" id="eh_num" name="eh_num" size="21" value="<%=eh_num%>" readonly>
						</td>
					</tr>
					<tr>
						<td>결재번호</td>
						<td width="600">
							<input type="text" id="ea_num" name="ea_num" size="21" value="<%=ea_num%>" readonly>
						</td>
					</tr>
					<!-- //넣을수도 있고 빼도 될거같고 -->
					<tr>
						<td>제목</td>
						<td>
							<input type="text" id="eh_title" name="eh_title" size="21">
						</td>
					</tr>
					<tr>
						<td>사원번호</td>
						<td>
							<input type="text" id="hm_empnum" name="hm_empnum" size="21" value="<%=user_id%>" readonly>
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td>
							<input type="text" id="eh_writer" name="eh_writer" size="21">
						</td>
					</tr>
					<tr>
						<td>직급</td>
						<td>
							<input type="text" id="position" name="position" size="21">
						</td>
					</tr>
					<tr>
						<td>결재 기간</td>
						<td>
							<input type="text" id="eh_startdate" name="eh_startdate" size="21" readonly>
							&nbsp;&nbsp;~&nbsp;&nbsp;
							<input type="text" id="eh_enddate" name="eh_enddate" size="21" readonly>
						</td>
					</tr>
					<tr>
						<td>휴가 종류</td>
						<td>
							<select id="eh_sort" name="eh_sort" style="width:220px;">
								<option value="47" selected>연차</option>
								<option value="48">월차</option>
								<option value="49">반차</option>
								<option value="50">병가</option>
								<option value="51">정기휴가</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>휴가 기간</td>
						<td>
							<input type="text" id="eh_startperiod" name="eh_startperiod" size="21" readonly>
							&nbsp;&nbsp;~&nbsp;&nbsp;
							<input type="text" id="eh_endperiod" name="eh_endperiod" size="21" readonly>
						</td>
					</tr>
					<tr>
						<td>분류</td>
						<td>
							<select id="eh_group" name="eh_group" style="width:220px;">
								<option value="23">기안서</option>
								<option value="22">품의서</option>
								<option value="21" selected>휴가신청서</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>휴가 사유</td>
						<td>
							<!-- <textarea name="eh_content" id="eh_content" rows="20" cols="150"></textarea> -->
							<textarea name="eh_reason" id="eh_reason" title="내용"
							style="width: 90%; height: 200px; padding: 0; margin: 0;"></textarea>
						</td>
					</tr>
					<tr>
						<td>비상연락처</td>
						<td>
							<select id="eh_emergency1">
								<option id="010" value="010" selected>010</option>
								<option id="011" value="011">011</option>
								<option id="016" value="016">016</option>
								<option id="017" value="017">017</option>
								<option id="018" value="018">018</option>
								<option id="019" value="019">019</option>
							</select>&nbsp;-&nbsp;
							<input type="text" id="eh_emergency2" name="eh_emergency2" size="12">
							&nbsp;-&nbsp;
							<input type="text" id="eh_emergency3" name="eh_emergency3" size="12">
						</td>
					</tr>
					<tr>
							<div id="eworkB">
								<td align="left"><input type="button" 
														id="lineB" name="lineB" class="button"
														style="width:100px;" value="결재라인 정하기"></td>
								<td align="right"><input type="button" 
														 id="draftB" name="draftB" class="button"
														 style="width:65px;" value="기안하기"></td>
								<input type="hidden" id="hm_position" name="hm_position">
								<input type="hidden" id="eh_emergency" name="eh_emergency">
							</div>
					</tr>
				</table>
				</div>
			</form>
		</div>
		<br><br>
	</body>
</html>