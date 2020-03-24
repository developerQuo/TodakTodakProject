
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.human.vo.MemberVO"%>      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
		Object obj=request.getAttribute("mvo");
		MemberVO mvo=(MemberVO)obj;
		String bposition=mvo.getHm_position();
		String bduty=mvo.getHm_duty();
		String bdept=mvo.getHm_deptnum();
		String bteam=mvo.getHm_teamnum();
		switch(bposition){
		case "임원":
			bposition="13";
			break;
		case "부장":
			bposition="14";
			break;
		case "과장":
			bposition="15";
			break;
		case "대리":
			bposition="16";
			break;
		case "사원":
			bposition="17";
			break;
	}
		switch(bduty){
		case "팀장":
			bduty="18";
			break;
		case "본부장":
			bduty="19";
			break;
		case "대표이사":
			bduty="20";
			break;
		case "없음":
			bduty="73";
			break;
	}
		switch(bdept){
		case "경영지원본부":
			bdept="00";
			break;
		case "전략기획본부":
			bdept="01";
			break;
		case "마케팅본부":
			bdept="02";
			break;
		case "나눔사업본부":
			bdept="03";
			break;
	}
		switch(bteam){
		case "인재경영팀":
			bteam="04";
			break;
		case "재무팀":
			bteam="05";
			break;
		case "관리팀":
			bteam="06";
			break;
		case "기획팀":
			bteam="07";
			break;
		case "소통협력팀":
			bteam="08";
			break;
		case "IT팀":
			bteam="09";
			break;
		case "홍보팀":
			bteam="10";
			break;
		case "배분팀":
			bteam="11";
			break;
		case "혁신사업팀":
			bteam="12";
			break;
		case "없음":
			bteam="73";
			break;
	}
		
%>
	<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>
		
	<script type="text/javascript">

	$(function(){
		$(".promotion").hide();
		$(".deptTransfer").hide();
		$(".notes").hide();
		
		$("#accept").click(function(){	
 			$("#apptMember")
 			.attr("action","/human/updateAppt.td")
            .submit();
		});
		$("#hpa_appointment").change(function(){
		
			if($("#hpa_appointment").val()=="68"){
				
				$(".promotion").show();
				$(".notes").show();
			}else{
				$(".promotion").hide();
			}
			if($("#hpa_appointment").val()=="69"){
				
				$(".deptTransfer").show();
				$(".notes").show();
			}else{
				$(".deptTransfer").hide();
			}
			if($("#hpa_appointment").val()=="67"){
				$(".promotion").hide();
				$(".deptTransfer").hide();
				$(".notes").hide();
			}
			if($("#hpa_appointment").val()=="74"){
				$(".promotion").hide();
				$(".deptTransfer").hide();
				$(".notes").show();
			}
		});
	    $("#hpa_appointmentdate").datepicker({
	    	 dateFormat: 'yymmdd'
	    	,showMonthAfterYear:true             
	        ,yearSuffix: "년" 
	       	,changeYear: true //콤보박스에서 년 선택 가능
	        ,changeMonth: true //콤보박스에서 월 선택 가능       
	        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] 
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] 
	        ,dayNamesMin: ['일','월','화','수','목','금','토']
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
	    });
	});



	</script>
</head>
	<body>
		<form   name="apptMember"
		  			id="apptMember"
		 		    method="POST">
			<div>
				<table border="0">
					<tr><th><h4>인사발령</h4></th></tr>
				</table>
			</div>
			<div style="height: 200px; width: 735px; border:1px solid black;">		
			
					<tr>
						<td align="center">발령구분
							<SELECT name = "hpa_appointment" id="hpa_appointment">
							<OPTION VALUE="67">== 선택  ==</OPTION>
							<OPTION VALUE="68">승진</OPTION>
						    <OPTION VALUE="69">부서이동</OPTION>
						    <OPTION VALUE="74">퇴사</OPTION>
							</SELECT>
						</td>
						<td>
							 발령일자<input type="text" name="hpa_appointmentdate" id="hpa_appointmentdate" size="12" />
						</td>
						<div class="promotion">
						<table border="0">
						
					</tr>
					
						
								<tr>	
									<td>
										현재직위 : <%=mvo.getHm_position() %>&nbsp;&nbsp;&nbsp;
									</td>
									<td>
											발령직위 :
											<SELECT name = "hpa_aposition" id="hpa_aposition">
												<OPTION VALUE="67">== 선택  ==</OPTION>
												<OPTION VALUE="13">임원</OPTION>
												<OPTION VALUE="14">부장</OPTION>
												<OPTION VALUE="15">과장</OPTION>
												<OPTION VALUE="16">대리</OPTION>
												<OPTION VALUE="17">사원</OPTION>
											</SELECT>
									</td>
								</tr>
								<tr>	
									<td>
										현재직책 : <%=mvo.getHm_duty() %>&nbsp;&nbsp;&nbsp;
									</td>
									<td>
											발령직책 :
											<SELECT name = "hpa_aduty" id="hpa_aduty">
												<OPTION VALUE="67">==선택==</OPTION>
												<OPTION VALUE="18">팀장</OPTION>
												<OPTION VALUE="19">본부장</OPTION>
												<OPTION VALUE="20">대표이사</OPTION>
												<OPTION VALUE="73">없음</OPTION>
											</SELECT>
									</td>
								</tr>
							    
						</table>	
					</div>		
						<div class="deptTransfer">
							<table border="0">
								<tr>	
									<td>
										현재부서 : <%=mvo.getHm_deptnum() %>&nbsp;&nbsp;&nbsp;
									</td>
									<td>
										발령부서 :
											<SELECT name = "hpa_adept" id="hpa_adept">
												<OPTION VALUE="67">== 선택  ==</OPTION>
												<OPTION VALUE="00">경영지원본부</OPTION>
												<OPTION VALUE="01">전략기획본부</OPTION>
												<OPTION VALUE="02">마케팅본부</OPTION>
												<OPTION VALUE="03">나눔사업본부</OPTION>
											</SELECT>
									</td>
								</tr>
								<tr>	
									<td>
										현재팀 : <%=mvo.getHm_teamnum() %>&nbsp;&nbsp;&nbsp;
									</td>
									<td>
											발령팀 :
											<SELECT name = "hpa_ateam" id="hpa_ateam">
												<OPTION VALUE="67">== 선택  ==</OPTION>
												<OPTION VALUE="04">인재경영팀</OPTION>
												<OPTION VALUE="05">재무팀</OPTION>
												<OPTION VALUE="06">관리팀</OPTION>
												<OPTION VALUE="07">기획팀</OPTION>
												<OPTION VALUE="08">소통협력팀</OPTION>
												<OPTION VALUE="09">IT팀</OPTION>
												<OPTION VALUE="10">홍보팀</OPTION>
												<OPTION VALUE="11">배분팀</OPTION>
												<OPTION VALUE="12">혁신사업팀</OPTION>
												<OPTION VALUE="73">없음</OPTION>
											</SELECT>
									</td>
								</tr>
							</table>		
						</div>
						<div class="notes">
							 <tr>	
									<td>
										비고:
									</td>
									<td>
										<textarea rows="5" cols="50" name="hpa_contents" id="hpa_contents"></textarea>
									</td>
								</tr>	
						</div>
				</div>		
		
		
		 		    <input type="hidden" name="hpa_empnum" id="hpa_empnum" value="<%=mvo.getHm_empnum() %>"/>
		 		    <input type="hidden" name="hpa_name" id="hpa_name" value="<%=mvo.getHm_name() %>"/>
		 		    <input type="hidden" name="hpa_bposition" id="hpa_bposition" value="<%=bposition%>"/>
		 		    <input type="hidden" name="hpa_bduty" id="hpa_bduty" value="<%=bduty%>"/>
		 		    <input type="hidden" name="hpa_bdept" id="hpa_bdept" value="<%=bdept%>"/>
		 		    <input type="hidden" name="hpa_bteam" id="hpa_bteam" value="<%=bteam %>"/>
		   </form>
			<div>
				
			</div>
			<div>
				<table border="1">
						<colgroup>
								<col width="120px"/>
								<col width="120px"/>
								<col width="120px"/>
								<col width="120px"/>
								<col width="120px"/>
								<col width="120px"/>
						</colgroup>
						<thead>
								<tr>
									<th>사원번호</th>
									<th>성명</th>
									<th>직급</th>
									<th>직책</th>
									<th>부서</th>
									<th>팀</th>
								</tr>
						</thead>
						<tbody>
								<tr>
									<td align="center"><%=mvo.getHm_empnum() %></td>
									<td align="center"><%=mvo.getHm_name() %></td>
									<td align="center"><%=mvo.getHm_position() %></td>
									<td align="center"><%=mvo.getHm_duty() %></td>
									<td align="center"><%=mvo.getHm_deptnum() %></td>
									<td align="center"><%=mvo.getHm_teamnum() %></td>
									<input type="button" value="발령등록" name="accept" id="accept">
								</tr>
						</tbody>
				</table>	
			</div>
	</body>
</html>