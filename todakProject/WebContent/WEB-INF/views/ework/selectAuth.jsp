<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java142.todak.ework.vo.SelectAuthBoxVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>

<% 
	String user_id = sManager.getUserID(session.getId());
	//System.out.println(user_id); 
				int list_size = 0;
				Object obj = request.getAttribute("list");
			
				if(obj!=null) {
					//System.out.println("if(obj!=null) 진입 >>> ");
					
					List<SelectAuthBoxVO> list = (List<SelectAuthBoxVO>) obj;
					//System.out.println("list >>> : " + list);
					list_size = list.size();
					
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>결재</title>
		<script type="text/javascript"
				src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
				
		<link href="/include/css/default.css" rel="stylesheet">			
				
		<script type="text/javascript">
			var list_size = <%=list_size%>;
		
			var totalData = list_size;    // 총 데이터 수
	    	var dataPerPage = 10;    // 한 페이지에 나타낼 데이터 수
	    	var pageCount = 10;       // 한 화면에 나타낼 페이지 수
	    	var currentPage = 1;
	    	var totalPage = 0;
	    	var pageGroup = 0;
	    	var last = 0;
	    	var first = 0;
	    	var next = 0;
	    	var prev = 0;
	    	var startRow = 0;
	    	var endRow = 0;
	    	
			var count = 0;
			var printCount = 0;
			
			$(document).ready(function() {
				console.log("제이쿼리");
				
				paging(totalData, dataPerPage, pageCount, currentPage, state);
				console.log("pageCount : " + pageCount);
				
				$('#search_button').click(function() {
					console.log("$('#search_button').click(function()");
					
					$('#search_form')
					.attr('action', '/ework/selectAuthBox.td')
					.submit();
					
				});
				
					
				$('#state').change(function() {
					console.log('결재상태 변경');
					
					state = $('#state option:selected').val(); //option 선택값 가져오기
					console.log('state >>> : ' + state);
					
					paging(totalData, dataPerPage, pageCount, currentPage, state);
					
				});
				
				$('.auth_detail').click(function() {
					console.log("상세조회 클릭");
					var ea_num = $(this).parents("tr").attr("data-num1"); //this: td태그
					console.log("ea_num >>> : " + ea_num);
					
					var eab_group = $(this).parents("tr").attr("data-num2"); //this: td태그
					console.log("eab_group >>> : " + eab_group);
					
					var ea_presentnum = $(this).parents("tr").attr("data-num3"); //this: td태그
					console.log("ea_presentnum >>> : " + ea_presentnum);
					
					$('#ea_num').val(ea_num);
					console.log("ea_num >>> : " + $('#ea_num').val());
					
					$('#eab_group[type=hidden]').attr("value", eab_group);
					console.log("eab_group >>> : " + $('#eab_group').val());
					
					$('#ea_presentnum').attr("value", ea_presentnum);
					console.log("ea_presentnum >>> : " + $('#ea_presentnum').val());
					
					$('#select_form')
					.attr('action', '/ework/authDetail.td')
					.submit();
				});
				
			});
		
			function paging(totalData, dataPerPage, pageCount, currentPage, state){
		        
				state = $('#state option:selected').val(); //option 선택값 가져오기
				console.log('state >>> : ' + state);
				
				console.log("totalData : " + totalData);
		        console.log("currentPage : " + currentPage);
		        console.log("list_size : " + list_size);
		        
		        totalPage = Math.ceil(totalData/dataPerPage);    // 총 페이지 수
		        pageGroup = Math.ceil(currentPage/pageCount);    // 페이지 그룹
		        
		        console.log("pageGroup : " + pageGroup);
		    
		        
		     	// 0 => 0(0*4), 4(0*4+4)
		        // 1 => 4(1*4), 8(1*4+4)
		        // 2 => 8(2*4), 12(2*4+4)
		        // 시작 행 = 페이지 번호 * 페이지당 행수
		        // 끝 행 = 시작 행 + 페이지당 행수
		        
		        //////////////////////
		        startRow = (currentPage-1) * dataPerPage + 1; //시작 행
		        endRow = startRow + dataPerPage - 1; //끝 행
		        console.log("startRow : " + startRow);
		        console.log("endRow : " + endRow);
		        //////////////////////
		        
		        
		        state = $('#state option:selected').val(); //option 선택값 가져오기
		        console.log('state >>> : ' + state);
		                       					
		        console.log("현재페이지 : " + currentPage);
		                       					
		        if(state == '') {
			        console.log("if(state == '') 진입 >>> ");
			                       						
			        var temp = $("#authbox_table > tbody > tr");
			        $(temp).show();
			                       						
			        printCount = 0;
			        //$("#authbox_table > tbody > tr").show(); 
			                       				                                           
			        for(var i=0; i<list_size; i++) {
				        var temp = $('#no' + i);
				        console.log(temp);
				        var bFlag = $('#no' + i).is(':visible');
				        console.log(bFlag);
				                       				                           		        	
				        if(bFlag) {
				        	console.log("if(bFlag) 진입 >>> ");
				                       				        		
				            printCount++;
				            console.log(printCount);
				            $('#number' + i).text(printCount);
				                       				                           		        		
				            if((printCount<startRow || printCount>endRow)) {
				            	$(temp).hide();
				            }
				       }
			       }
		                       						
		       } else if(state == 0) {
		       	   console.log("if(state == 0) 진입 >>> ");
		                       						
		           $("#authbox_table > tbody > tr").hide();
		           var temp = $("#authbox_table > tbody > tr > td:contains('미결')");
		           $(temp).parent().show();
		                       						
		           printCount = 0;
		           //$("#authbox_table > tbody > tr").show(); 
		                       					                                           
		           for(var i=0; i<list_size; i++) {
		               var temp = $('#no' + i);
		               console.log(temp);
		               var bFlag = $('#no' + i).is(':visible');
		               console.log(bFlag);
		                       					                           		        	
		               if(bFlag) {
		                   console.log("if(bFlag) 진입 >>> ");
		                       					        		
		                   printCount++;
		                   console.log(printCount);
		                   $('#number' + i).text(printCount);
		                       					                           		        		
		                   if((printCount<startRow || printCount>endRow)) {
		                       $(temp).hide();
		                   }
		               }
		           }
		                       						
		       } else if(state == 1) {
		           console.log("else if(state == 1) 진입 >>> ");
		                       						
		           $("#authbox_table > tbody > tr").hide();
		           var temp = $("#authbox_table > tbody > tr > td:contains('진행중')");
		           $(temp).parent().show();
		                       						
		           printCount = 0;
		           //$("#authbox_table > tbody > tr").show(); 
		                       					                                           
		           for(var i=0; i<list_size; i++) {
		               var temp = $('#no' + i);
		               console.log(temp);
		               var bFlag = $('#no' + i).is(':visible');
		               console.log(bFlag);
		                       					                           		        	
		               if(bFlag) {
		                   console.log("if(bFlag) 진입 >>> ");
		                       					        		
		                   printCount++;
		                   console.log(printCount);
		                   $('#number' + i).text(printCount);
		                       					                           		        		
		                   if((printCount<startRow || printCount>endRow)) {
		                       $(temp).hide();
		                   }
		               }
		           }
		                       						
		       } else if(state == 2) {
		           console.log("else if(state == 2) 진입 >>> ");
		                       						
		           $("#authbox_table > tbody > tr").hide();
		           var temp = $("#authbox_table > tbody > tr > td:contains('결재 완료')");
		           $(temp).parent().show();
		                       						
		           printCount = 0;
		           //$("#authbox_table > tbody > tr").show(); 
		                       					                                           
		           for(var i=0; i<list_size; i++) {
		               var temp = $('#no' + i);
		               console.log(temp);
		               var bFlag = $('#no' + i).is(':visible');
		               console.log(bFlag);
		                       					                           		        	
		               if(bFlag) {
		                   console.log("if(bFlag) 진입 >>> ");
		                       					        		
		                   printCount++;
		                   console.log(printCount);
		                   $('#number' + i).text(printCount);
		                       					                           		        		
		                   if((printCount<startRow || printCount>endRow)) {
		                       $(temp).hide();
		                   }
		               }
		           }
		                       						
		       } else if(state == 3) {
		           console.log("else if(state == 3) 진입 >>> ");
		                       						
		           $("#authbox_table > tbody > tr").hide();
		           var temp = $("#authbox_table > tbody > tr > td:contains('반려')");
		           $(temp).parent().show();
		                       						
		           printCount = 0;
		           // $("#authbox_table > tbody > tr").show(); 
		                       					                                           
		           for(var i=0; i<list_size; i++) {
		               var temp = $('#no' + i);
		               console.log(temp);
		               var bFlag = $('#no' + i).is(':visible');
		               console.log(bFlag);
		                       					                           		        	
		               if(bFlag) {
		                   console.log("if(bFlag) 진입 >>> ");
		                       					        		
		                   printCount++;
		                   console.log(printCount);
		                   $('#number' + i).text(printCount);
		                       					                           		        		
		                   if((printCount<startRow || printCount>endRow)) {
		                       $(temp).hide();
		                   }
		               }
		           }
		                       						
		       }
		                       					
		       console.log("printCount : " + printCount);
		       totalData = printCount; //printCount가 화면에 실제로 보이는 tr의 갯수를 가지고 있음
		       
		       totalPage = Math.ceil(totalData/dataPerPage);    // 총 페이지 수 다시 계산(totalData값이 바뀌었기 때문)
		       console.log("페이지카운트 : " + pageCount);
		       last = pageGroup * pageCount;    // 화면에 보여질 마지막 페이지 번호
		       if(last > totalPage) {
		    	   console.log("if(last > totalPage) 진입 >>> ");
		    	   
		    	   last = totalPage;
		       }
		       
		       first = last - (pageCount-1);    // 화면에 보여질 첫번째 페이지 번호
		       if(first <= 0) first = 1;    // 이거 안 넣으면 페이지 번호에 음수가 뜸
		       
		       next = last+1;
		       prev = first-1;
		                       			        
		       console.log("last : " + last);
		       console.log("first : " + first);
		       console.log("next : " + next);
		       console.log("prev : " + prev);
		 
		       var $pagingView = $("#paging");
		        
		       var html = "";
		       
		       if(prev > 0)
		            html += "<a href=# id='first'>◁◁</a>&nbsp;&nbsp;&nbsp;<a href=# id='prev'>◀</a>";
		       else
		     	    html += "◁◁&nbsp;&nbsp;&nbsp;◀&nbsp;&nbsp;&nbsp;";
		            
		       for(var i=first; i <= last; i++){
		    	   
		   	       if(i == currentPage)
		   	    	   html += "&nbsp;"+i+"&nbsp;";
		   	       else
		               html += "&nbsp;[<a href='#' id=" + i + ">" + i + "</a>]&nbsp;";
		       }
		       
		       console.log("토탈데이터 : " + totalData);
		       console.log("데이터퍼페이지 : " + dataPerPage);
		       console.log("토탈페이지 : " + totalPage);
		       
		       if(last < totalPage)
		           html += "<a href=# id='last'>▷▷</a><a href=# id='next'>▶</a>";
		       else
			       html += "&nbsp;&nbsp;&nbsp;▶&nbsp;&nbsp;&nbsp;▷▷";
		       
		       $("#paging").html(html);    // 페이지 목록 생성
		       $("#paging a").css("color", "black");
		       $("#paging a#" + currentPage).css({"text-decoration":"none", 
		                                           "color":"blue", 
		                                           "font-weight":"regular"});    // 현재 페이지 표시
		  
		                                           
		       $("#paging a").click(function(){
		           
		           var $item = $(this);
		           var $id = $item.attr("id");
		           var selectedPage = $item.text();
		           
		           if($id == "next") {
		               selectedPage = next;
		           }
		           if($id == "prev") {
		               selectedPage = prev;
		           }
		           if($id == "first") {
		        	   selectedPage = first;
		           }
		           if($id == "last") {
		        	   selectedPage = last;
		           }
		            
		           paging(totalData, dataPerPage, pageCount, selectedPage);
		        
		       });
		                                           
		    }	
				
			function group(eab_group) {
				var group = '';
				
				if(eab_group == '21') group = "휴가계";
				if(eab_group == '22') group = "품의서";
				if(eab_group == '23') group = "기안서";
				
				return group;
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
      			
      			$('#eab_startdate').datepicker({
      				showOn: "button",
                    //buttonImage: "images/calendar.gif",
                   	buttonImageOnly: false,
                  	buttonText: "날짜"
      			});
      			
      			$('#eab_enddate').datepicker({
                	showOn: "button",
                    //buttonImage: "images/calendar.gif",
                   	buttonImageOnly: false,
                  	buttonText: "날짜"
				});
      			
      		});
      		//]]>
      	</script>
	    
		<div class="context-container">
			<h3><b>결재</b></h3>
       		<hr>
       		<form id="search_form" name="search_form" method="POST">
       		<center>
       		
       			<table class="table_align">
       				<colgroup>
						<col width="10%"/>
						<col width="40%"/>
						<col width="6%"/>
						<col width="34%"/>
						<col width="10%"/>
					</colgroup>
       				<tr>
		       			<td>작성자</td>
		       			<td>
		       				<input type="text" id="eab_writer" name="eab_writer" style="width:302px;">
		       			</td>
		       			<td>제목</td>
		       			<td>
		       				<input type="text" id="eab_title" name="eab_title" style="width:302px;">
		       			</td>
		       			<td rowspan="2">
				       		<div id="search_div" align="right">
				       			<input type="button" id="search_button" name="search_button" 
				       				   style="width:50pt; height:50pt;" class="button" value=" 검색 ">
			       			</div>
		       			</td>
		       		</tr>
		       		<tr>
		       			<td>결재기간</td>
		       			<td>
		       				<input type="text" id="eab_startdate" name="eab_startdate" style="width:98px;" readonly>&nbsp;~&nbsp;
		       				<input type="text" id="eab_enddate" name="eab_enddate" style="width:98px;" readonly>
		       			</td>
		       			<td>분류</td>
		       			<td>
		       				<select id="eab_group" name="eab_group" style="width:302px">
		       					<option value="">분류 선택</option>
		       					<option value="21">휴가계</option>
		       					<option value="22">품의서</option>
		       					<option value="23">기안서</option>
		       				</select>
		       			</td>
		       		</tr>
		       		<tr>
		       			<td  colspan="5">
		       				<hr>
		       			</td>
		       		</tr>
		       		<tr>
		       			<td>결재상태</td>
		       			<td>
		       				<select id="state" name="state" style="width:302px">
		    					<option value="">결재상태 선택</option>
								<option value="0">미결</option>
       							<option value="1">진행중</option>
    							<option value="2">결재완료</option>
    							<option value="3">반려</option>
		    				</select>
		       			</td>
		       		</tr>
       			</table>
       			
       		</center>	
       		</form>
       		<p>
			<center>
			<br>
			<form id="select_form" name="select_form" method="POST">
			<div class="authtable_size">
				<table class="table" id="authbox_table" cellpadding="3">
					<colgroup>
								<col width="7%"/>
								<col width="9%"/>
								<col width="40%"/>
								<col width="25%"/>
								<col width="10%"/>
								<col width="9%"/>
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th><b>작성자</th>
							<th><b>제목</th>
							<th><b>결재 기간</th>
							<th><b>결재상태</th>
							<th><b>분류</th>
						</tr>
					</thead>
					<tbody>

			<%
					
					if(list!=null && list.size() > 0) {
						//System.out.println("if(list!=null && list.size() > 0) 진입 >>> ");
						
						for(int i=0; i<list.size(); i++) {
							SelectAuthBoxVO sabvo = list.get(i);
							//System.out.println("sabvo >>> : " + sabvo);
							
							String eab_num = sabvo.getEab_num();
							//System.out.println("eab_num >>> : " + eab_num);
							String ea_num = sabvo.getEa_num();
							//System.out.println("ea_num >>> : " + ea_num);
							String eab_writer = sabvo.getEab_writer();
							//System.out.println("eab_writer >>> : " + eab_writer);
							String eab_title = sabvo.getEab_title();
							//System.out.println("eab_title >>> : " + eab_title);
							
							String eab_startdate = sabvo.getEab_startdate();
							//System.out.println("eab_startdate >>> : " + eab_startdate);
							String startdate_year = eab_startdate.substring(0,4);
							//System.out.println("startdate_year >>> : " + startdate_year);
							String startdate_month = eab_startdate.substring(4,6);
							//System.out.println("startdate_month >>> : " + startdate_month);
							String startdate_day = eab_startdate.substring(6,8);
							//System.out.println("startdate_day >>> : " + startdate_day);
							
							String eab_enddate = sabvo.getEab_enddate();
							//System.out.println("eab_enddate >>> : " + eab_enddate);
							String enddate_year = eab_enddate.substring(0,4);
							//System.out.println("enddate_year >>> : " + enddate_year);
							String enddate_month = eab_enddate.substring(4,6);
							//System.out.println("enddate_month >>> : " + enddate_month);
							String enddate_day = eab_enddate.substring(6,8);
							//System.out.println("enddate_day >>> : " + enddate_day);
							
							String el_line = sabvo.getEl_line();
							//System.out.println("el_line >>> : " + el_line);
							String ea_presentnum = sabvo.getEa_presentnum();
							if(ea_presentnum == null) ea_presentnum = "#";
							//System.out.println("ea_presentnum >>> : " + ea_presentnum);
							String eai_substitutenum = sabvo.getEai_substitutenum();
							//System.out.println("eai_substitutenum >>> : " + eai_substitutenum);
							String eab_group = sabvo.getEab_group();
							//System.out.println("eab_group >>> : " + eab_group);
							String eab_insertdate = sabvo.getEab_insertdate();
							//System.out.println("eab_insertdate >>> : " + eab_insertdate);
							String eab_updatedate = sabvo.getEab_updatedate();
							//System.out.println("eab_updatedate >>> : " + eab_updatedate);
							String eab_deleteYN = sabvo.getEab_deleteYN();
							//System.out.println("eab_deleteYN >>> : " + eab_deleteYN);
							
							if(el_line.indexOf(user_id) != -1) {
								if((el_line.lastIndexOf(ea_presentnum) >= el_line.lastIndexOf(user_id)) || ea_presentnum.equals("#") || ea_presentnum.equals("return")) {
									
									//System.out.println("-----------------------------------------");
									//System.out.println("el_line.lastIndexOf(ea_presentnum) >>> : " + el_line.indexOf(ea_presentnum));
									//System.out.println("el_line.lastIndexOf(user_id) >>> : " + el_line.indexOf(user_id));
									//System.out.println("-----------------------------------------");
			%>
									<tr id="no<%=i %>" data-num1="<%=ea_num%>" data-num2="<%=eab_group%>" data-num3="<%=ea_presentnum%>">
										<td id="number<%=i%>" align="center"></td>
										<td align="center"><%=eab_writer %></td>
										<td align="center">
											<div class="auth_detail"><%=eab_title %></div>
										</td>
										<td align="center">
											<%=startdate_year %>-<%=startdate_month %>-<%=startdate_day %> ~ 
											<%=enddate_year %>-<%=enddate_month %>-<%=enddate_day %>
										</td>
			<%
									if(ea_presentnum.indexOf("return") != -1) {
			%>
											<td align="center">
												반려
											</td>
			<%
									} else if(ea_presentnum.indexOf(user_id) != -1) {
			%>
										<td align="center">
											미결
										</td>
			<%
									} else if(ea_presentnum.indexOf("#") != -1) {
			%>
										<td align="center">
											결재 완료
										</td>
			<%
									}else if(ea_presentnum.indexOf(user_id) == -1) {
			%>
										<td align="center">
											진행중
										</td>
			<%
									} 
			%>
										<td align="center">
											<script type="text/javascript">
												document.write(group(<%=eab_group %>));
											</script>
										</td>
									</tr>
			<%
								}
							}
			%>
					
			<%
							
						}
			%>
					</tbody>
				</table>
			<%			
			
					}
			
				} else {
			%>
					<script type="text/javascript">
						alert("데이터가 없습니다");
						history.back();
					</script>
			<%
				}
			%>
				
			</div>
			
			<br>
			<div id="paging"></div>
				
			<input type="hidden" id="ea_num" name="ea_num">
			<input type="hidden" id="eab_group" name="eab_group">
			<input type="hidden" id="ea_presentnum" name="ea_presentnum">
			
			</form>
			</center>
		</div>
		
	</body>
</html>