<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.scheduler.controller.SchedulerController" %>
<%@ page import="java142.todak.scheduler.vo.CommuteVO" %>
<%@ page import="java.util.ArrayList"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>출퇴근시간창</title>
		
		<link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
			$(function(){
				
<%
				String lastHourMessage = (String)request.getAttribute("lastHourMessage");
				if(lastHourMessage != null){
%>
			 		console.log('<%=lastHourMessage%>');
			
<%
				}
%>

				$("#closeGoWork").click(function(){
					
					window.close();
					
				});

			});
		</script>
	</head>
	<body>
         <div>
         	<br><br>
			<form>
				<div class="gowork_size" align="center">
					<table class="gowork">
						<colgroup>
							<col width="10%"/>
							<col width="15%"/>
							<col width="15%"/>
							<col width="15%"/>
							<col width="15%"/>
							<col width="15%"/>
							<col width="15%"/>
						</colgroup>
						<thead>
							<tr>
								<th>성명</th>
								<th>부서</th>
								<th>날짜</th>
								<th>출근시간</th>
								<th>퇴근시간</th>
								<th>남은근무시간</th>
								<th>추가근무시간</th>
							</tr>
						</thead>
						<tbody>
<%
		Object obj = request.getAttribute("selectCommute");
		String message = (String)request.getAttribute("message");
		if(obj == null){

%>

			<tr><td colspan="6" align="center"><%=message %></td></tr>

<%
		}else{
			ArrayList<CommuteVO> cList = (ArrayList<CommuteVO>)obj;
			CommuteVO cvo = cList.get(0);
			String hc_workin = cvo.getHc_workin().substring(11, 16);
			String hc_workout = cvo.getHc_workout();
			
			//퇴근버튼 클릭시에만 퇴근 시간이 기록됨
			if(hc_workout == null ) {
				
				hc_workout = "-";
				
			}else{
				hc_workout = hc_workout.substring(11, 16);
			}
			
			//남은 근무시간을 기록함
			String hc_lasthour = cvo.getHc_lasthour();
			if(Integer.parseInt(hc_lasthour) > 0 ){
				int lastHour = Integer.parseInt(hc_lasthour) / 60;
				int lastMin =  Integer.parseInt(hc_lasthour) % 60;
				hc_lasthour = lastHour + "시간 " + lastMin + "분";
			}else{
				hc_lasthour = "0시간 0분";
			}
			
			//초과 근무시간을 기록
			String hc_extraworking = cvo.getHc_extraworking();
			if(hc_extraworking == null){
				hc_extraworking  = "-";
				
			}else{
				int lastHour = Integer.parseInt(hc_extraworking) / 60;
				int lastMin =  Integer.parseInt(hc_extraworking) % 60;
				hc_extraworking = lastHour + "시간 " + lastMin + "분";
			}
			
%>
								<tr>
									<td  align ="center" ><%= cvo.getHm_name() %></td>
									<td  align ="center" ><%= cvo.getHm_deptnum() %></td>
									<td  align ="center" ><%= cvo.getHc_date().substring(0, 10) %></td>
									<td  align ="center" ><%= hc_workin %></td>
									<td  align ="center" ><%= hc_workout %></td>
									<td  align ="center" ><%= hc_lasthour %></td>
									<td  align ="center" ><%= hc_extraworking %></td>
								</tr>
									
								<tr><td colspan="7" align="center"><%=message %></td></tr>

<%
		}

%>
						
						</tbody>
	
					</table>
						<div class="gowork_align">

									<input align="middle"  type="button" class="button" 
										   id="closeGoWork" name="closeGoWork" value="확인" style="width:70px;">

					  	</div>
				</div>
			</form>
         
         </div>
	</body>
</html>