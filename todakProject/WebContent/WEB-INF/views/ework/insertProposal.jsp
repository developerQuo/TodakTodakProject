<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.ework.vo.ProposalVO" %>
<%@ page import="java142.todak.ework.vo.AuthVO" %>
<%@ page import="java142.todak.ework.vo.LineVO" %>
<%@ page import="java.util.List" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<% 
	String user_id = sManager.getUserID(session.getId());
	//System.out.println(user_id);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>기안서 작성하기</title>
		<!-- 
		<script type="text/javascript"
		 		 src="../include/js/common.js" charset="utf-8"></script> -->
		
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
					fOnAppLoad : function() {
						
						var get_title = localStorage.getItem("title");
						var get_startdate = localStorage.getItem("startdate");
						var get_enddate = localStorage.getItem("enddate");
						var get_content = localStorage.getItem("content"); //텍스트와 태그가 같이 포함되어있는 문자열
						
						if(get_content!=null) {
							console.log("if(get_content!=null) 진입 >>> ");
							
							var remove_content = get_content.replace(/(<([^>]+)>)/ig,""); //태그 모두 지우고 텍스트만 남기기
						
						}
						
						console.log("get_title >>> : " + get_title);
						console.log("get_startdate >>> : " + get_startdate);
						console.log("get_enddate >>> : " + get_enddate);
						//console.log("get_content >>>:" + get_content + "<<<");
						console.log("remove_content >>> : " + remove_content);
						
						if((get_title!=null) || (get_startdate!=null) || (get_enddate!=null) || (get_content!=null)) {
						
							console.log("if((get_title!=null) || (get_startdate!=null) || (get_enddate!=null) || (remove_content!=null)) 진입 >>> ");
								
							if((get_title!='') || (get_startdate!='') || (get_enddate!='') || (remove_content!='')) { 
								console.log("if((get_title!='') || (get_startdate!='') || (get_enddate!='') || (remove_content!='')) 진입 >>> ");
								
								if(confirm("작성했던 내용이 존재합니다. 불러오겠습니까?")) {
									console.log("if(confirm('작성했던 내용이 존재합니다. 불러오겠습니까?')) 진입 >>> ");
									
									var content = localStorage.getItem("content");
									console.log(content);
									
									oEditors.getById["ep_content"].exec("PASTE_HTML", [content]);
									$('#ep_title').attr("value", localStorage.getItem("title"));
									$('#ep_startdate').attr("value", localStorage.getItem("startdate"));
									$('#ep_enddate').attr("value", localStorage.getItem("enddate"));
									
								} else {
									console.log("else 진입 >>> ");
									
									localStorage.removeItem("title");
									localStorage.removeItem("startdate");
									localStorage.removeItem("enddate");
									localStorage.removeItem("content");
								}
								
							}
						}
						
						
						//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
						//oEditors.getById["ep_content"].exec("PASTE_HTML", [""]);
					},
					oAppRef : oEditors,
					elPlaceHolder : "ep_content", //textarea에서 지정한 id와 일치해야 합니다. 
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
					fCreator : "createSEditor2"
				});
				
				//----------------------- 임시저장 -----------------------
	      		setInterval(function() {
	      			
	      			var ep_content = oEditors.getById["ep_content"].getIR(); //<p><br></p>
					console.log("'ep_content' : " + ep_content);
	      			
	      			localStorage.setItem("title", $('#ep_title').val());
	          		localStorage.setItem("startdate", $('#ep_startdate').val());
	          		localStorage.setItem("enddate", $('#ep_enddate').val());
	          		localStorage.setItem("content", ep_content);
	          		
	          		console.log(localStorage.getItem("title"));
	          		console.log(localStorage.getItem("startdate"));
	          		console.log(localStorage.getItem("enddate"));
	          		console.log(localStorage.getItem("content"));
	      		}, 1000*10); //10초
	      		
	      		//---------------------- 임시저장 끝 ----------------------
	      		
	      		
				//-------------------------------------------------------------------------
				
				$('#lineB').click(function() {
					console.log("휴가신청서 결재라인 정하기");
					var windowW = 600;  // 창의 가로 길이
			        var windowH = 600;  // 창의 세로 길이
			        var left = Math.ceil((window.screen.width - windowW)/2);
			        var top = Math.ceil((window.screen.height - windowH)/2);
					
					setLine = window.open('/eworkForm/moveSetPropos	alLine.td', 
							  '결재라인', "l top="+top+", left="+left+", height="+windowH+", width="+windowW);
					console.log("setLine >>> : " + setLine);
					
				});
				
				$('#draftB').click(function() {
					console.log("기안하기 버튼");
					
					if(!setLineFunction()) return false;
					if(!validation()) return false;
					
					oEditors.getById["ep_content"].exec("UPDATE_CONTENTS_FIELD", []);
					
					$("#writeForm")
					.attr("action", "../eworkForm/insertProposal.td")
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
				
				$('#ep_writer').attr('value', user_name);
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
				var ep_startdate = $("#ep_startdate").val();
				var ep_enddate = $("#ep_enddate").val();
				
				var ep_content = oEditors.getById["ep_content"].getIR(); //<p><br></p>
				console.log("'ep_content' : " + ep_content);
				
				if(!$("#ea_num").val()) {
					console.log("if(!$('#ea_num').val())");
					alert("결재번호를 입력하세요.");
					$("#ea_num").focus();
					return false;
				}
				
				if(!$("#ep_title").val()) {
					console.log("if(!$('#ep_title').val())");
					alert("제목을 입력하세요.");
					$("#ep_title").focus();
					return false;
				}
				
				if(!$("#ep_writer").val()) {
					console.log("if(!$('#ep_writer').val())");
					alert("작성자를 입력하세요.");
					$("#ep_writer").focus();
					return false;
				}
				
				if(!ep_startdate) {
					console.log("if(!$('#ep_startdate').val())");
					alert("결재 시작일을 입력하세요.");
					$('#ep_startdate').focus();
					return false;
				}
				
				if(!ep_enddate) {
					console.log("if(!$('#ep_enddate').val())");
					alert("결재 마감일을 입력하세요.");
					$("#ep_enddate").focus();
					return false;
				}
				
				if(ep_startdate > ep_enddate) {
					console.log("if(ep_startdate > ep_enddate)");
					alert("결재 시작일은 결재 마감일보다 빨라야 합니다.");
					return false;
				}
				
				
				if(ep_content=='<p><br></p>' || ep_content=='') {
					console.log("if(ep_content=='<p><br></p>' || ep_content=='')");
					alert("내용을 입력하세요.");
					$("#ep_content").focus();
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
      			
      			$('#ep_startdate').datepicker({
      				showOn: "button",
                    //buttonImage: "images/calendar.gif",
                   	buttonImageOnly: false,
                  	buttonText: "날짜 설정"
      			});
      			
      			$('#ep_enddate').datepicker({
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
			String ep_num = "";
			String ea_num = "";
			
			Object ob = request.getAttribute("pvo");
			//System.out.println("ob >>> : " + ob);
			
			Object ob2 = null;
			ob2 = request.getAttribute("auvo");
			//System.out.println("ob2 >>> : " + ob2);
			
			if(ob!=null && ob2!=null) {
			
				ProposalVO pvo = (ProposalVO) ob;
				//System.out.println("pvo >>> : " + pvo);
				ep_num = pvo.getEp_num();
				//System.out.println("ep_num >>> : " + ep_num);
				
				AuthVO auvo = (AuthVO) ob2;
				//System.out.println("auvo >>> : " + auvo);
				ea_num = auvo.getEa_num();
				//System.out.println("ea_num >>> : " + ea_num);
				
			}
			
		%>
	        <h3><b>기안서 작성</b></h3>
	        <hr>
	        <br>	
			<form id="writeForm" name="writeForm" method="POST" >
			<div class="write_table" align="center" >
				<table id="writeProposal">
					<tr>
						<td>결재라인</td>
						<td>
							<input type="text" id="auth_line" name="auth_line" size="66px" readonly>
						</td>
					</tr>
					<!-- 넣을수도 있고 빼도 될거같고 -->
					<tr rowspan="4">
						<td>서류번호</td>
						<td width="600">
							<input type="text" id="ep_num" name="ep_num" value="<%=ep_num%>" size="21" readonly>
						</td>
					</tr>
					<tr>
						<td>결재번호</td>
						<td>
							<input type="text" id="ea_num" name="ea_num" value="<%=ea_num%>" size="21" readonly>
						</td>
					</tr>
					<!-- //넣을수도 있고 빼도 될거같고 -->
					<tr>
						<td>제목</td>
						<td>
							<input type="text" id="ep_title" name="ep_title" size="21">
						</td>
					</tr>
					<tr>
						<td>사원번호</td>
						<td>
							<input type="text" id="hm_empnum" name="hm_empnum" value="<%=user_id%>" size="21" readonly>
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td>
							<input type="text" id="ep_writer" name="ep_writer" size="21" readonly>
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
						<td>
							<input type="text" id="ep_startdate" name="ep_startdate" size="21" readonly>
							&nbsp;&nbsp;~&nbsp;&nbsp;
							<input type="text" id="ep_enddate" name="ep_enddate" size="21" readonly>
						</td>
					</tr>
					<tr>
						<td>분류</td>
						<td>
							<select id="ep_group" name="ep_group">
								<option value="23" selected>기안서</option>
								<option value="22">품의서</option>
								<option value="21">휴가계획서</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<!-- <textarea name="ep_content" id="ep_content" rows="20" cols="150"></textarea> -->
							<textarea name="ep_content" id="ep_content" title="내용"
							style="width: 100%; height: 200px; padding: 0; margin: 0;"></textarea>
						</td>
					</tr>
					<tr>
						<div id="eworkB">
							<td align="left"><input type="button" 
													id="lineB" name="lineB" class="button" 
													style="width:100px;" value="결재라인 정하기"></td>
							<td align="right"><input type="button" 
													 id="draftB" class="button" name="draftB" 
													 style="width:65px;" value="기안하기"></td>
							<input type="hidden" id="hm_position" name="hm_position">
						</div>
					</tr>
				</table>
				</div>
			</form>
			<br><br>
			
		</div>
		<br><br>
	</body>
</html>