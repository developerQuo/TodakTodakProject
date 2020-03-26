<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.ework.vo.ApprovalVO" %>
<%@ page import="java142.todak.ework.vo.AuthVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>

<% 
	String user_id = sManager.getUserID(session.getId());
	//System.out.println(user_id); 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>품의서 작성하기</title>
		
		<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
		<script type="text/javascript"
			src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
			
		<link href="/include/css/default.css" rel="stylesheet">
		
		<script type="text/javascript">
			var setLine = null;
			var user_id = "<%=user_id%>";
			var auth_line = "";
			
			$(function() {
				
				$.ajax({
					url : "../eworkForm/selectPerson.td",
					data : {
						"hm_empnum" : user_id
					},
					success : whenSussessUserInfo,
					error : whenError
				});
				
				
				//----------------------- 임시저장 -----------------------
	      		setInterval(function() {
	      			
	      			localStorage.setItem("title", $('#eap_title').val());
	          		localStorage.setItem("startdate", $('#eap_startdate').val());
	          		localStorage.setItem("enddate", $('#eap_enddate').val());
	          		//localStorage.setItem("content", ep_content);
	          		
	          		console.log(localStorage.getItem("title"));
	          		console.log(localStorage.getItem("startdate"));
	          		console.log(localStorage.getItem("enddate"));
	 
	      		}, 1000*10); //10초
	      		
	      		//---------------------- 임시저장 끝 ----------------------
				
				
				var get_title = localStorage.getItem("title");
				var get_startdate = localStorage.getItem("startdate");
				var get_enddate = localStorage.getItem("enddate");
				
				console.log("get_title >>> : " + get_title);
				console.log("get_startdate >>> : " + get_startdate);
				console.log("get_enddate >>> : " + get_enddate);
				
				if((get_title!=null) || (get_startdate!=null) || (get_enddate!=null)) {
				
					console.log("if((get_title!=null) || (get_startdate!=null) || (get_enddate!=null)) 진입 >>> ");
						
					if((get_title!='') || (get_startdate!='') || (get_enddate!='')) { 
						console.log("if((get_title!='') || (get_startdate!='') || (get_enddate!='')) 진입 >>> ");
						
						if(confirm("작성했던 내용이 존재합니다. 불러오겠습니까?")) {
							console.log("if(confirm('작성했던 내용이 존재합니다. 불러오겠습니까?')) 진입 >>> ");
							
							$('#eap_title').attr("value", localStorage.getItem("title"));
							$('#eap_startdate').attr("value", localStorage.getItem("startdate"));
							$('#eap_enddate').attr("value", localStorage.getItem("enddate"));
							
						} else {
							console.log("else 진입 >>> ");
							
							localStorage.removeItem("title");
							localStorage.removeItem("startdate");
							localStorage.removeItem("enddate");
							
						}
						
					}
				}
					
				$('#lineB').click(function() {
					console.log("휴가신청서 결재라인 정하기");
					var windowW = 600;  // 창의 가로 길이
			        var windowH = 600;  // 창의 세로 길이
			        var left = Math.ceil((window.screen.width - windowW)/2);
			        var top = Math.ceil((window.screen.height - windowH)/2);

					
					
					setLine = window.open('/eworkForm/moveSetApprovalLine.td', 
							  '결재라인', "l top="+top+", left="+left+", height="+windowH+", width="+windowW);
					console.log("setLine >>> : " + setLine);
					
				});	

				$('#draftB').click(function() {
					console.log("품의서 기안하기");
					
					if(!setLineFunction()) return false;
					if(!validation()) return false;
					
					$("#writeForm")
					.attr({
						"method" : "POST",
						"action" : "../eworkForm/insertApproval.td"
					})
					.submit();
					
				});
				
				$('#eap_filedir').change(function() {
					console.log("파일이름 textbox에 넣어주기");
					
					var file_dir = $('#eap_filedir').val();
					console.log("file_dir >>> : " + file_dir);
					
					var start = file_dir.lastIndexOf("\\")+1;
					console.log("start >>> : " + start);
					var end = file_dir.length;
					console.log("end >>> : " + end);
					var file_name = file_dir.substring(start, end);
					console.log("file_name >>> : " + file_name);
					
					$('#file_name').attr("value",file_name);
					
				});
					
				$('#download_href').click(function() {
					console.log("$('#download_href').click(function()");
					
					$('#download_form')
					.attr("action", "/eworkForm/downloadDocument.td")
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
				
				$('#eap_writer').attr('value', user_name);
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
				var eap_startdate = $("#eap_startdate").val();
				var eap_enddate = $("#eap_enddate").val();
				
				
				if(!$("#eap_num").val()) {
					console.log("if(!$('#eap_num').val())");
					alert("품의서번호를 입력하세요");
					$("#eap_num").focus();
					return false;
				}
				
				if(!$("#ea_num").val()) {
					console.log("if(!$('#ea_num').val())");
					alert("결재번호를 입력하세요");
					$("#ea_num").focus();
					return false;
				}
				
				if(!$("#eap_title").val()) {
					console.log("if(!$('#eap_title').val())");
					alert("제목을 입력하세요");
					$("#eap_title").focus();
					return false;
				}
				
				if(!$("#eap_writer").val()) {
					console.log("if(!$('#eap_writer').val())");
					alert("작성자를 입력하세요");
					$("#eap_writer").focus();
					return false;
				}
				
				if(!eap_startdate) {
					console.log("if(!eap_startdate)");
					alert("결재 시작일을 입력하세요");
					$("#eap_startdate").focus();
					return false;
				}
				
				if(!eap_enddate) {
					console.log("if(!eap_enddate)");
					alert("결재 마감일을 입력하세요");
					$("#eap_enddate").focus();
					return false;
				}
				
				if(eap_startdate > eap_startdate) {
					console.log("if(eh_startdate > eh_enddate)");
					alert("휴가 시작일은 휴가 종료일보다 빨라야 합니다.");
					return false;
				}
				
				
				if(!$("#eap_filedir").val())  {
					console.log("if(!$('#eap_filedir').val())");
					alert("파일을 입력하세요");
					$("#eap_filedir").focus();
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
			<!-- <jsp:include page="/etc/moveSession.td" flush="false"/> -->
			
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
      			
      			$('#eap_startdate').datepicker({
      				showOn: "button",
                    //buttonImage: "images/calendar.gif",
                   	buttonImageOnly: false,
                  	buttonText: "날짜 설정"
      			});
      			
      			$('#eap_enddate').datepicker({
                	showOn: "button",
                    //buttonImage: "images/calendar.gif",
                   	buttonImageOnly: false,
                  	buttonText: "날짜 설정"
				});
      			
      		});
      		//]]>
      	</script>
			
		<div class="context-container">	
		<%
			String eap_num = "";
			String ea_num = "";
		
			Object ob = null;
			ob = request.getAttribute("avo");
			//System.out.println("ob >>> : " + ob);
			
			Object ob2 = null;
			ob2 = request.getAttribute("auvo");
			//System.out.println("ob2 >>> : " + ob2);
			
			if(ob!=null && ob2!=null) {
			
				ApprovalVO avo = (ApprovalVO) ob;
				//System.out.println("avo >>> : " + avo);
				eap_num = avo.getEap_num();
				//System.out.println("eap_num >>> : " + eap_num);
				
				AuthVO auvo = (AuthVO) ob2;
				//System.out.println("auvo >>> : " + auvo);
				ea_num = auvo.getEa_num();
				//System.out.println("ea_num >>> : " + ea_num);
				
			}
		%>
	        <h3><b>품의서 작성&nbsp;&nbsp;&nbsp;</b></h3>
	        <hr>
	         <form id="download_form" name="download_form">
				<a id="download_href" href="#">품의서 양식 다운로드</a>
				<input type="hidden" id="file" name="file" value="formDownload.hwp"> <!-- value엔 파일이름.형식 -->
			</form>
			<form id="writeForm" name="writeForm" enctype="multipart/form-data">
			<div class="write_table" align = "center">
				<table id="writeApproval">
					<tr>
						<td>결재라인</td>
						<td>
							<input type="text" id="auth_line" name="auth_line" size="66px" readonly>
						</td>
					</tr>
					<!-- 넣을수도 있고 빼도 될거같고 -->
					<tr>
						<td>서류번호</td>
						<td width="300">
							<input type="text" id="eap_num" name="eap_num" value="<%=eap_num %>" size="21" readonly>
						</td>
						<!-- 
						<td>결재서류양식번호</td>
						<td>
							<input type="text" id="ef_num" name="ef_num" size="30">
						</td>
						 -->
					</tr>
					<tr>
						<td>결재번호</td>
						<td>
							<input type="text" id="ea_num" name="ea_num" size="21" value="<%=ea_num%>" readonly>
						</td>
					</tr>
					<!-- //넣을수도 있고 빼도 될거같고 -->
					<tr>
						<td>제목</td>
						<td>
							<input type="text" id="eap_title" name="eap_title" size="21">
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
							<input type="text" id="eap_writer" name="eap_writer" size="21" readonly>
						</td>
					</tr>
					<tr>
						<td>직급</td>
						<td>
							<input type="text" id="position" name="position" size="21" readonly>
						</td>
					</tr>
					<tr>
						<td>결재기간</td>
						<td colspan="2">
							<input type="text" id="eap_startdate" name="eap_startdate" size="21" readonly>
							&nbsp;&nbsp;~&nbsp;&nbsp; 
							<input type="text" id="eap_enddate" name="eap_enddate" size="21" readonly>
						</td>
					</tr>
					<tr>
						<td>분류</td>
						<td>
							<select id="eap_group" name="eap_group">
								<option value="23">기안서</option>
								<option value="22" selected>품의서</option>
								<option value="21">휴가계획서</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>파일</td>
						<td>
							<input type="text" id="file_name" class="file_textbox" size="21" readonly>
							<input type="button" value="찾아보기" class="button" onclick="document.all.eap_filedir.click();">
							<input type="file" id="eap_filedir" name="eap_filedir" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<div id="eworkB">
							<td align="left"><input type="button" 
													id="lineB" name="lineB" class="button"
													style="width:100px" value="결재라인 정하기"></td>
							<td align="right"><input type="button" id="draftB" name="draftB" class="button"
													 style="width:65px" value="기안하기"></td>
							<input type="hidden" id="hm_position" name="hm_position">
						</div>
					</tr>
				</table>
				</div>
			</form>
			<br><br>
		</div>
	</body>
</html>