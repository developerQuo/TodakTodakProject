<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java142.todak.sponsor.vo.CharityVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>단체 정보</title>
		
		<link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
		
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<script>
			//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
			function sample4_execDaumPostcode() {
				new daum.Postcode({
					oncomplete: function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 도로명 조합형 주소 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if(data.buildingName !== '' && data.apartment === 'Y'){
						   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if(extraRoadAddr !== ''){
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
						if(fullRoadAddr !== ''){
							fullRoadAddr += extraRoadAddr;
						}

						// 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sc_addr').value = fullRoadAddr;
					}
				}).open();
			}
		</script>
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<!-- <script type="text/javascript"
				src="../js/jquery-1.11.0.min.js"></script> -->
		<script type="text/javascript">
			$(document).ready(function(){
				var enctype = 'application/x-www-form-urlencoded';
				$("#confirm").click(function(){
					var domain = $("#emailDomainSlctr").val();
					if (domain == 'bySelf'){
						domain = $("#emailDomain").val();
					}
					var email = $("#emailId").val() + '@' + domain;
					$("#sc_email").prop("value", email);
					
					var sc_registrationdate = $("#sc_registrationdate").prop("value");
					sc_registrationdate = sc_registrationdate.replace(/\-/g,'');
					$("#sc_registrationdate").prop("value", sc_registrationdate);
					

					var sc_amountingstart = $("#sc_amountingstart").prop("value");
					sc_amountingstart = sc_amountingstart.replace(/\-/g,'');
					$("#sc_amountingstart").prop("value", sc_amountingstart);
					

					var sc_amountingend = $("#sc_amountingend").prop("value");
					sc_amountingend = sc_amountingend.replace(/\-/g,'');
					$("#sc_amountingend").prop("value", sc_amountingend);
					
					executeFunc(enctype);
					
				});

				$("#emailDomainSlctr").change(function(){
					var domain = $("#emailDomainSlctr").val();
					if (domain == 'bySelf'){
						$("#emailDomain").val('');
						$("#emailDomain").prop("disabled", false);
					}else{
						$("#emailDomain").val($("#emailDomainSlctr").val());
						$("#emailDomain").prop("disabled", true);
					}
				});
				
			});
			5
			function executeFunc(enctype){
				//http://localhost:8088/Model2_MVC/KcmMemberServlet
				$("#registerForm").prop("method", "POST")
				.prop("enctype", enctype)
				.submit();
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
			$(function(){
				$("#sc_registrationdate").datepicker({
					showOn: "button",
			        //buttonImage: "images/calendar.gif",
				    buttonImageOnly: false,
					buttonText: "날짜 선택"
				});

				$("#sc_amountingstart").datepicker({
					showOn: "button",
			        //buttonImage: "images/calendar.gif",
				    buttonImageOnly: false,
					buttonText: "날짜 선택"
				});

				$("#sc_amountingend").datepicker({
					showOn: "button",
			        //buttonImage: "images/calendar.gif",
				    buttonImageOnly: false,
					buttonText: "날짜 선택"
				});
			});
			//]]>
		 </script>
         
         <h3><b>단체 정보</b></h3>
         <hr><br>
			<%
				CharityVO scvo = new CharityVO();
				String emailId = "";
				String emailDomain = "";
				String registrationdate = "";
				String amountingstart = "";
				String amountingend = "";
				List<CharityVO> charityList = (List<CharityVO>)request.getAttribute("charityList");
				if (charityList != null && !charityList.isEmpty()){
					scvo = charityList.get(0);
					int index = scvo.getSc_email().indexOf("@");
					emailId = scvo.getSc_email().substring(0, index);
					emailDomain = scvo.getSc_email().substring(index+1);
					registrationdate = new StringBuffer(scvo.getSc_registrationdate()).insert(6, "-").insert(4, "-").toString();
					amountingstart = new StringBuffer(scvo.getSc_amountingstart()).insert(6, "-").insert(4, "-").toString();
					amountingend = new StringBuffer(scvo.getSc_amountingend()).insert(6, "-").insert(4, "-").toString();
			%>
				<script type="text/javascript">
					// 업데이트인 경우
					$(document).ready(function(){
						$("#registerForm").prop("action", "/sponsor/updateCharity.td");
					});
				</script>
			<%
				}else{
			%>
				<script type="text/javascript">
					// 인서트인 경우
					$(document).ready(function(){
						$("#registerForm").prop("action", "/sponsor/insertCharity.td");
					});
				</script>
			<%		
				}
			%>
			<div class="inserttable_size">
				<form id="registerForm">
					<table class="insert_table" align="center" border="1">
						<tr>
							<td align="center" width="140" align="center" style="background-color:#eeeeee;color:white;">단체명</td>
							<td colspan="2" width="250">
								<input type="text" name="sc_name" id="sc_name" style="width:210px;" value=<%= scvo.getSc_name() %>>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">대표자</td>
							<td colspan="2">
								<input type="text" name="sc_ceo" id="sc_ceo" style="width:210px;" value=<%= scvo.getSc_ceo()%>>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">휴대폰번호</td>
							<td colspan="2">
								<input type="text" name="sc_hp" id="sc_hp" style="width:210px;" value=<%= scvo.getSc_hp() %>>&nbsp;&nbsp;<font size="2">* '-'구분자 없이 숫자 11자리</font>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">이메일</td>
							<td colspan="2"><input type="text" name="emailId" id="emailId" style="width:210px;" value=<%= emailId %>> @
								<input type="text" name="emailDomain" id="emailDomain" size="15" style="width:180px;" value=<%= emailDomain %>>
								<select name="emailDomainSlctr" id="emailDomainSlctr">
									<option value="bySelf">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="hanmail.net">hanmail.net</option>
								</select>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">소재지</td>
							<td colspan="2">
								<input type="text" name="sc_addr" id="sc_addr" size="50" value=<%= scvo.getSc_addr() %>>
								<input type="button" class="button" onclick="sample4_execDaumPostcode()" value="주소 찾기">
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">단체 등록번호</td>
							<td colspan="2">
								<input type="text" name="sc_registration" id="sc_registration" style="width:210px;" value=<%= scvo.getSc_registration() %>>&nbsp;&nbsp;<font size="2">* '-'구분자 없이 숫자 10자리</font>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">단체 등록일</td>
							<td><input type="text" name="sc_registrationdate" id="sc_registrationdate" size="13"  value=<%= registrationdate %>></td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">사업분야</td>
							<td>
								<select style="width:210px;" name="sc_bizfield" id="sc_bizfield" value=<%= scvo.getSc_bizfield() %>>
									<option value="41">문화관광</option>
									<option value="42">인권운동</option>
									<option value="43">취약계층지원</option>
									<option value="44">시민의식개선</option>
									<option value="45">환경보전</option>
									<option value="46">기타공익사업</option>
								</select>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">사업내용</td>
							<td colspan="2">
								<textarea name="sc_bizcontents" id="sc_bizcontents" rows="4" cols="60"><%= scvo.getSc_bizcontents() %></textarea>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">목표 모금액</td>
							<td colspan="2"><input type="text" name="sc_targetamount" id="sc_targetamount" style="width:210px;" value=<%= scvo.getSc_targetamount() %>>원</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">모금기간</td>
							<td><input type="text" name="sc_amountingstart" id="sc_amountingstart" size="13"  value=<%= amountingstart %>> ~
								<input type="text" name="sc_amountingend" id="sc_amountingend" size="13"  value=<%= amountingend %>></td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">은행</td>
							<td colspan="2">
								<select name="sc_bank" id="sc_bank" style="width:210px;">
									<option value="38">국민은행</option>
								</select>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">계좌번호</td>
							<td colspan="2">
								<input type="text" name="sc_accountnum" id="sc_accountnum" style="width:210px;" value=<%= scvo.getSc_accountnum() %>>&nbsp;&nbsp;<font size="2">* '-'구분자 없이 숫자 14자리</font>
							</td>
						</tr>
						<tr>
							<td align="center" style="background-color:#eeeeee;color:white;">예금주명</td>
							<td colspan="2"><input type="text" name="sc_depositor" id="sc_depositor" style="width:210px;" value=<%= scvo.getSc_depositor() %>></td>
						</tr>
						</table>
						<br>
						<div class="inserttable_align" align="right">
							<input type="hidden" id="sc_num" name="sc_num" value=<%= scvo.getSc_num() %>>
							<input type="hidden" id="sc_email" name="sc_email">
							<input type="reset" value="초기화" class="button" style="width:60px;">
							<input type="button" value="확인" class="button" id="confirm" style="width:60px;">
						</div>
				</form>
			</div>
         </div>
	</body>
</html>