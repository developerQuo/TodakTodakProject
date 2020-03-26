<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>   
<%@ page import="java142.todak.human.vo.CommVO"%>     
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	Object obj=request.getAttribute("comList");
	ArrayList aList = (ArrayList)obj;
	CommVO cvo=null;
	
	Object objCvo=request.getAttribute("cvo");
	CommVO pageVO=(CommVO)objCvo;
	
	int pageSize = pageVO.getPageSize();
	int groupSize = pageVO.getGroupSize();
	int curPage = pageVO.getCurPage();
	int totalCount = pageVO.getTotalCount();
	
	//System.out.println("pageSize"+pageSize);
	//System.out.println("groupSize"+groupSize);
	//System.out.println("curPage"+curPage);
	//System.out.println("totalCount"+totalCount);
	
	if(request.getParameter("curPage") != null)
	{
		curPage = Integer.parseInt(request.getParameter("curPage"));
	}
	String key=null;
	String sdate=pageVO.getStartdate();
	String edate=pageVO.getEnddate();
	
	long dayHour=0;
	long dayMinutes=0;
	long weekHour=0;
	long weekMinutes=0;
	long lastHour=0;
	long lastMinutes=0;
	long extraHour=0;
	long extraMinutes=0;
	String ser=pageVO.getHm_empnum();
	
%>
<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>
		
	<script type="text/javascript">
	$(document).ready(function(){
		if('<%=sdate %>' != 'null'){
			$("#startday").val('<%=sdate %>');
			
		}
		if('<%=edate %>' != 'null'){
			$("#endday").val('<%=edate %>');
			
		}
		if('<%=pageSize %>' > 0){
			$("#pageCtrl").val('<%=pageSize %>');
		}
		$("#selectData").click(function(){
			if($("#endday").val()==null||$("#endday").val()==''){
				
				var sday=$("#startday").val();
				$("#endday").val(sday);
			}
			goPage(1);
		});
		$("#pageCtrl").change(function(){
			goPage(1);
		});
		$("#startday").datepicker({
	    	 dateFormat: 'yymmdd'
	    	,showMonthAfterYear:true             
	        ,yearSuffix: "년" 
	       	,changeYear: true //콤보박스에서 년 선택 가능
	        ,changeMonth: true //콤보박스에서 월 선택 가능       
	        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] 
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] 
	        ,dayNamesMin: ['일','월','화','수','목','금','토']
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
			,numberOfMonths: 1
			,onSelect: function(selected) {
			$("#endday").datepicker("option","minDate", selected)
			}
	    });
		$("#endday").datepicker({
	    	 dateFormat: 'yymmdd'
	    	,showMonthAfterYear:true             
	        ,yearSuffix: "년" 
	       	,changeYear: true //콤보박스에서 년 선택 가능
	        ,changeMonth: true //콤보박스에서 월 선택 가능       
	        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] 
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] 
	        ,dayNamesMin: ['일','월','화','수','목','금','토']
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
			,numberOfMonths: 1
			,onSelect: function(selected) {
			$("#startday").datepicker("option","maxDate", selected)
			}
	    });
		
		$(".goDetail").click(function(){
			alert("디테일 클릭됨!");
			$("#hm_empnum").val('<%=ser %>');
			alert($("#hm_empnum").val());
			var comnum=$(this).parents("tr").attr("data");
			alert("읽어온 값은"+comnum);
			console.log("읽어온 값은"+comnum);
			$("#hc_comnum").val(comnum);
			window.open("","pop","width=550, height=450");
			$("#detailForm").attr({
				"method":"get",
				"target":"pop",
				"action":"/human/changeComm.td"
			});
			$("#detailForm").submit();
		});
		
	});
	function goPage(page){
		$("#page").val(page);
		$("#hm_empnum").val('<%=ser %>');
		
		$("#selectDate").attr({
			"method":"get",
			"action":"/human/commuteALlRecord.td"
		});
		$("#selectDate").submit();
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
         
     <div class="container">   
		<form name="detailForm" id="detailForm" method="post">
			<input type="hidden" name="hc_comnum" id="hc_comnum">
			<input type="hidden" name="hm_empnum" id="hm_empnum">
		</form>
		
		<form id="selectDate" 
		      name="selectDate"
		      method="POST">
			<div class daySelect>
				<input type="text" name="startday" id="startday"> 
				<input type="text" name="endday" id="endday"> 
				<input type="button" value="조회" id="selectData"/>	
				<input type="hidden" name="hm_empnum" id="hm_empnum">
			</div>
			<select id="pageCtrl" name="pageCtrl">
							<option value="5">선택</option>
							<option value="1">1줄</option>
							<option value="10">10줄</option>
							<option value="20">20줄</option>
							<option value="30">30줄</option>
							<option value="50">50줄</option>
						</select>
		</form>
		<table border="1" align="center">
					<thead>
						<tr>
							<th>날짜</th>
							<th>출근시간</th>
							<th>퇴근시간</th>
							<th>일 근무 시간</th>
							
							<th>주 근무 시간</th>
							<th>남은 근무 시간</th>
							<th>추가 근무 시간</th>
							<th>일 근무 유형</th>
						</tr>
<%
					if(aList.size()>0){
						for(int i=0;i<aList.size();i++){
							cvo=(CommVO)aList.get(i);
							
							dayHour=TimeUnit.MINUTES.toHours(Integer.parseInt(cvo.getHc_dayhour()));
						    dayMinutes=TimeUnit.MINUTES.toMinutes(Integer.parseInt(cvo.getHc_dayhour()))
						    		   -TimeUnit.HOURS.toMinutes(dayHour);
							weekHour=TimeUnit.MINUTES.toHours(Integer.parseInt(cvo.getHc_weekhour()));
							weekMinutes=TimeUnit.MINUTES.toMinutes(Integer.parseInt(cvo.getHc_weekhour()))
						    		   -TimeUnit.HOURS.toMinutes(weekHour);
							lastHour=TimeUnit.MINUTES.toHours(Integer.parseInt(cvo.getHc_lasthour()));
							lastMinutes=TimeUnit.MINUTES.toMinutes(Integer.parseInt(cvo.getHc_lasthour()))
						    		   -TimeUnit.HOURS.toMinutes(lastHour);
							extraHour=TimeUnit.MINUTES.toHours(Integer.parseInt(cvo.getHc_extraworking()));
							extraMinutes=TimeUnit.MINUTES.toMinutes(Integer.parseInt(cvo.getHc_extraworking()))
						    		   -TimeUnit.HOURS.toMinutes(extraHour);		
							
							
							
%>						
						<tr data='<%=cvo.getHc_comnum() %>'>
							
							<th><%=cvo.getHc_date().substring(0,10) %></th>
							<th><%=cvo.getHc_workin().substring(11,16) %></th>
							<th><%=cvo.getHc_workout().substring(11,16) %></th>
							<th><%=dayHour+":"+dayMinutes %></th>
							
							<th><%=weekHour+":"+weekMinutes %></th>
							<th><%=lastHour+":"+lastMinutes %></th>
							<th><%=extraHour+":"+extraMinutes %></th>
							
							<th><span class="goDetail"><%=cvo.getHc_tanda() %></span></th>
						</tr>
<%
						}
		}
	
%>						
					</thead>	
			</table>			
				<jsp:include page="paging.jsp" flush="true">
				<jsp:param name="url" value="/human/commuteALlRecord.td"/>
				<jsp:param name="str" value=""/>
				<jsp:param name="pageSize" value="<%=pageSize%>"/>
				<jsp:param name="groupSize" value="<%=groupSize%>"/>
				<jsp:param name="curPage" value="<%=curPage%>"/>
				<jsp:param name="totalCount" value="<%=totalCount%>"/>
				<jsp:param name="key" value="<%=key%>"/>
				<jsp:param name="sdate" value="<%=sdate%>"/>
				<jsp:param name="edate" value="<%=edate%>"/>
				<jsp:param name="ser" value="<%=ser%>"/>
			</jsp:include>	
			</div>
	</body>
</html>