<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<%
	//System.out.println(sManager.getUserID(session.getId()));
	String hm_empnum = sManager.getUserID(session.getId());
%>

	<head>
	    <meta charset="UTF-8" />
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <title>일정표</title>
	    <link rel=" shortcut icon" href="/include/js/scheduler/image/favicon.ico"/>
	
	    <link rel="stylesheet" href="/include/js/scheduler/vendor/css/fullcalendar.min.css"/>
	    <link rel="stylesheet" href="/include/js/scheduler/vendor/css/bootstrap.min.css" >
	    <link rel="stylesheet" href="/include/js/scheduler/vendor/css/select2.min.css" />
	    <link rel="stylesheet" href="/include/js/scheduler/vendor/css/bootstrap-datetimepicker.min.css" />
	
	    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
	    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	
	    <link rel="stylesheet" href="/include/js/scheduler/main.css" >
	    
	    
	    
	    <link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
	
	</head>
	
	<body>
	  <header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>

         <aside class="sidebar">
            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
            
            <div style="color:black;text-align:center;
            			width:auto;height:auto;
            			font-size:15px;font-weight:bold;">
            			
	            <script type="text/javascript"
	            			src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	            <script type="text/javascript">
	            		
	            	var picture = "";
	            	var name = "";
	            	
	            	$(document).ready(function() {
	            	
	            		console.log("제이쿼리");
	            		
	            		// *** commue.jsp의 input 태그 id *** 꼭 있어야됨!!
	            		$('#hm_empnum').attr("value", "<%=hm_empnum%>");
	            		
	            		$.ajax({
	            			type : "POST",
	            			url : "/human/selectUserInfo.td",
	            			data : {
	            				hm_empnum : "<%=hm_empnum%>"
	            			},
	            			success : whenSuccess,
	            			error : whenError
	            		});
	            	});
	            	
	            	function whenSuccess(data) { 
	            		//세션에 담겨있는 사원번호로 /views/human/selectUserInfo.jsp에서
	            		//그 사원의 사진과 이름을 찾아서 가져옴
	            		
	            		console.log("성공")
	            		console.log(data);
	            		
	            		picture = $(data).find("picture").text();
	            		console.log("picture >>> : " + picture);
	            		
	            		name = $(data).find("name").text();
	            		console.log("name >>> : " + name);
	            		
	            		$('#name').append(name);
	            		$('#picture').attr("src", picture);
	            		
	            	}
	            	
	            	function whenError() {
	            		console.log("실패");
	            	}
	            	
	            </script>
	            	
	                             안녕하세요, <span id="name"></span>님!
	           	<br><br>
	            <img id="picture" alt="이미지 없음" src="" 
	            	 width="150px" height="150px"
	            	 style="border-radius:70%"/>
	            <br><br>
	            <%@ include file="/WEB-INF/views/scheduler/commute.jsp"%> <!-- jsp에 있는 bindSession 주석 처리 했음 -->
	            <button type="button" id="ReferenceButton" onclick="moveReference()" class="button" style="width:152px;height:30px;">내 정보</button>
            
         	</div>
         	
         </aside>
         <div class="context-container" >
	 
	    <div>
	    
	     <!-- Trigger the modal with a button -->
		  <button type="button" id="holiButton" onclick="holidayCount()" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal">휴가 조회</button>
		  <!-- <button type="button" id="ReferenceButton" onclick="moveReference()" class="btn btn-info btn-sm">인사정보 조회</button> -->
		  <button type="button" id="ApptholiButton" onclick="moveApptRecord()" class="btn btn-info btn-sm">인사발령 기록 조회</button>
		  <button type="button" id="CommuteButton" onclick="moveCommuteRecord()" class="btn btn-info btn-sm">출퇴근기록 조회</button>
		  <!-- Modal -->
		  <div class="modal fade" id="myModal" role="dialog">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 class="modal-titles">휴가 정보</h4>
		        </div>
		        <div class="modal-body">
		          <table class="table table-striped" id="holidayInfo">
				    
				  </table>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
		      </div>
		      
		    </div>
		  </div>
	    </div>

	    
	    <div class="container">
	        <!-- 일자 클릭시 메뉴오픈 -->
	        <div id="contextMenu" class="dropdown clearfix">
	            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
	                style="display:block;position:static;margin-bottom:5px;">
	                <li><a tabindex="-1" href="#">등록</a></li>	              
	                <li class="divider"></li>
	                <li><a tabindex="-1" href="#" data-role="close">닫기</a></li>
	            </ul>
	        </div>
	
	        <div id="wrapper">
	            <div id="loading"></div>
	            <div id="calendar" style="float:center;widht:50%;"></div>
	        </div>
	
	
	        <!-- 일정 추가 modal -->
	        <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
	            <div class="modal-dialog" role="document">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
	                                aria-hidden="true">&times;</span></button>
	                        <h4 class="modal-title"></h4>
	                    </div>
	                    <div class="modal-body">
	
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-allDay">하루종일</label>
	                                <input class='allDayNewEvent' id="edit-allDay" type="checkbox">
	                            </div>
	                        </div>
	
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-title">일정명</label>
	                                <input class="inputModal" type="text" name="edit-title" id="edit-title"
	                                    required="required" />
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-start">시작</label>
	                                <input class="inputModal" type="text" name="edit-start" id="edit-start" />
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-end">끝</label>
	                                <input class="inputModal" type="text" name="edit-end" id="edit-end" />
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-type">구분</label>
	                                <select class="inputModal" type="text" name="edit-type" id="edit-type">
	                                    <option value="47">연차</option>
	                                    <option value="48">월차</option>
	                                    <option value="49">반차</option>
	                                    <option value="50">병가</option>
	                                    <option value="50">정기휴가</option>
	                                    <option value="56">회의</option>
	                                    <option value="57">미팅</option>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-color">색상</label>
	                                <select class="inputModal" name="color" id="edit-color">
	                                    <option value="#D25565" style="color:#D25565;">빨간색</option>
	                                    <option value="#9775fa" style="color:#9775fa;">보라색</option>
	                                    <option value="#ffa94d" style="color:#ffa94d;">주황색</option>
	                                    <option value="#74c0fc" style="color:#74c0fc;">파란색</option>
	                                    <option value="#f06595" style="color:#f06595;">핑크색</option>
	                                    <option value="#63e6be" style="color:#63e6be;">연두색</option>
	                                    <option value="#a9e34b" style="color:#a9e34b;">초록색</option>
	                                    <option value="#4d638c" style="color:#4d638c;">남색</option>
	                                    <option value="#495057" style="color:#495057;">검정색</option>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-xs-12">
	                                <label class="col-xs-4" for="edit-desc">설명</label>
	                                <textarea rows="4" cols="50" class="inputModal" name="edit-desc"
	                                    id="edit-desc"></textarea>
	                            </div>
	                            <div class="col-xs-12">	                        
	                                <input type="hidden"class="inputModal" name="edit-num" id="edit-num" value="">
	                            </div>
	                            <div class="col-xs-12">	                                
	                                <input type="hidden"class="inputModal" name="edit-username" 
	                                id="edit-username" value= "<%=num%>" >
	                            </div>
	                        </div>
	                    </div>
	                    <div class="modal-footer modalBtnContainer-addEvent">
	                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	                        <button type="button" class="btn btn-primary" id="save-event">저장</button>
	                    </div>
	                    <div class="modal-footer modalBtnContainer-modifyEvent">
	                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	                        <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
	                        <button type="button" class="btn btn-primary" id="updateEvent">저장</button>
	                    </div>
	                </div><!-- /.modal-content -->
	            </div><!-- /.modal-dialog -->
	        </div><!-- /.modal -->
			<!--  
	        <div class="panel panel-default">            
	        </div>
	        -->
	        <!-- /.filter panel -->
	    </div>
	    <!-- /.container -->
	
	    <script src="/include/js/scheduler/vendor/js/jquery.min.js" ></script>
	    <script src="/include/js/scheduler/vendor/js/bootstrap.min.js" ></script>
	    <script src="/include/js/scheduler/vendor/js/moment.min.js" ></script>
	    <script src="/include/js/scheduler/vendor/js/fullcalendar.min.js" ></script>
	    <script src="/include/js/scheduler/vendor/js/ko.js" ></script>
	    <script src="/include/js/scheduler/vendor/js/select2.min.js" ></script>
	    <script src="/include/js/scheduler/vendor/js/bootstrap-datetimepicker.min.js" ></script>
	    <script src="/include/js/scheduler/js/main.js" ></script>
	    <script src="/include/js/scheduler/js/addEvent.js" ></script>
	    <script src="/include/js/scheduler/js/editEvent.js" ></script>
	    <script src="/include/js/scheduler/js/etcSetting.js" ></script>
	    </div>
	    
	
	</body>

</html>