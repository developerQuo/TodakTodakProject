<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.ework.vo.ProposalVO" %>
<%@ page import="java142.todak.ework.vo.AuthPersonVO" %>
<%@ page import="java142.todak.human.vo.MemberVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<% 
	String user_id = sManager.getUserID(session.getId());
	//System.out.println(user_id);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>기안서 상세 조회</title>
		
		<script type="text/javascript"
			src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
			
		<link href="/include/css/default.css" rel="stylesheet">
			
		<script type="text/javascript">
			$(document).ready(function() {
				console.log("제이쿼리");
				
				$('#approval_button').click(function() { //승인
					console.log("$('#approval_button').click(function()");
					
					if(confirm("승인 하시겠습니까?")) {
						console.log("OK");
						
						<%--var draft_num = <%=draft.etEai_recentnum()%>;--%>
						
						
					
						$('#search_form')
						.attr("action", "/ework/approval.td")
						.submit();
					}
					
				});
					
				$('#sub_button').click(function() { //대결
					console.log("$('#approval_button').click(function()");
					
					if(confirm("대결 하시겠습니까?")) {
						console.log("OK");
						
						$('#search_form')
						.attr("action", "/ework/substitute.td")
						.submit();
						
					}
					
				});
					
				$('#return_button').click(function() { //반려
					console.log("$('#approval_button').click(function()");
					
					if(confirm("반려 하시겠습니까?")) {
						console.log("OK");
						
						$('#search_form')
						.attr("action", "/ework/return.td")
						.submit();
						
					}
					
				});
				
				$('#move_list').click(function() {
					console.log("목록으로 이동");
					
					$('#move_list')
					.attr("href", "/ework/selectAuthBox.td");
					
				});
				
			});
		
			function group(eab_group) {
				var group = '';
				
				if(eab_group == '21') group = "휴가계";
				if(eab_group == '22') group = "품의서";
				if(eab_group == '23') group = "기안서";
				
				return group;
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
			
			function authorization(eai_auth) {
				console.log("function authorization(eai_auth) 시작 >>> ");
				console.log("eai_auth >>> : " + eai_auth);
				
				var auth = "";
				
				if(eai_auth == "null") auth = "기안"
				else if(eai_auth == '61') auth = "승인"
				else if(eai_auth == '62') auth = "반려";
				else if(eai_auth == '63') auth = "대결";
				else if(eai_auth == '64') auth = "전결";
				else auth = '';
				
				return auth;
			}
		</script>
		
		<style type="text/css">
			.slash {
  				background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="0" y1="100%" x2="100%" y2="0" stroke="gray" /></svg>');}
			
		</style>
	</head>
	<body>
	<%
	Object obj = request.getAttribute("list_proposal");
	//System.out.println("obj >>> : " + obj);
	
	Object obj2 = request.getAttribute("list_person");
	//System.out.println("obj2 >>> : " + obj2);
	
	Object obj3 = request.getAttribute("list_names");
	//System.out.println("obj3 >>> : " + obj3);
	
	Object obj4 = request.getAttribute("list_subname");
	//System.out.println("obj4 >>> : " + obj4);
	
	Object obj5 = request.getAttribute("list_presentnum");
	//System.out.println("obj5 >>> : " + obj5);
	
	String ea_presentnum = "";
	
	if(obj5!=null) {
		//System.out.println("if(obj5!=null) 진입 >>> ");
		
		ArrayList<String> list_presentnum = (ArrayList<String>) obj5;
		//System.out.println("list_presentnum >>> : " + list_presentnum);
		ea_presentnum = list_presentnum.get(0);
		//System.out.println("ea_presentnum >>> : " + ea_presentnum);
		
	}
	
	AuthPersonVO draft = null; //기안자
	AuthPersonVO first = null; //1차 결재자
	AuthPersonVO second = null; //2차 결재자
	AuthPersonVO third = null; //3차 결재자
	AuthPersonVO substitute = null; //대결자
	
	String draft_name = "";
	String first_name = "";
	String second_name = "";
	String third_name = "";
	String substitute_name = "";

	
	if(obj != null && obj2!=null) {
		//System.out.println("if(obj != null && obj2!=null) 진입 >>> ");
		
		List<ProposalVO> list_proposal = (List<ProposalVO>) obj;
		//System.out.println("list_proposal >>> : " + list_proposal);
		
		ProposalVO pvo = list_proposal.get(0);
		//System.out.println("pvo >>> : " + pvo);	
		
		
		
		List<AuthPersonVO> list_person = (List<AuthPersonVO>) obj2;
		//System.out.println("list_person >>> : " + list_person);
		
		for(int i=0; i<list_person.size(); i++) {
			
			AuthPersonVO apvo = list_person.get(i);
			//System.out.println("apvo >>> : " + apvo);
			
			String eai_sequence = apvo.getEai_sequence();
			String eai_substitutenum = apvo.getEai_substitutenum();
			
			//System.out.println("getEai_num >>> : " + apvo.getEai_num());
			//System.out.println("getEa_num >>> : " + apvo.getEa_num());
			//System.out.println("getEai_recentnum >>> : " + apvo.getEai_recentnum());
			//System.out.println("getEai_position >>> : " + apvo.getEai_position());
			//System.out.println("getEai_auth >>> : " + apvo.getEai_auth());
			//System.out.println("getEai_filedir >>> : " + apvo.getEai_filedir());
			//System.out.println("getEai_subsitutenum >>> : " + eai_substitutenum);
			//System.out.println("getEai_substituteYN >>> : " + apvo.getEai_substituteYN());
			//System.out.println("getEai_sequence >>> : " + apvo.getEai_sequence());		
			
			if(eai_sequence != null && eai_sequence.indexOf("0") != -1 && eai_substitutenum == null) {
				//System.out.println("if(eai_sequence != null && eai_sequence.indexOf('0') != -1 && eai_substitutenum == null) 진입 >>> ");
				
				draft = apvo;
				//System.out.println("draft >>> : " + draft);
				//String hm_empnum = draft.getEai_recentnum();
				////System.out.println("hm_empnum >>> : " + hm_empnum);
				
			} else if(eai_sequence != null && eai_sequence.indexOf("1") != -1 && eai_substitutenum == null) {
				//System.out.println("else if(eai_sequence != null && eai_sequence.indexOf('1') != -1 && eai_substitutenum == null) 진입 >>> ");
				
				first = apvo;
				//System.out.println("first >>> : " + first);
				
			} else if(eai_sequence != null && eai_sequence.indexOf("2") != -1 && eai_substitutenum == null) {
				//System.out.println("else if(eai_sequence != null && eai_sequence.indexOf('2') != -1 && eai_substitutenum == null) 진입 >>> ");
				
				second = apvo;
				//System.out.println("second >>> : " + second);
				
			} else if(eai_substitutenum != null) {
				//System.out.println("else if(eai_substitutenum != null) 진입 >>> ");
				
				substitute = apvo;
				//System.out.println("substitute >>> : " + substitute);
				
			} else if(eai_sequence != null && eai_sequence.indexOf("3") != -1 && eai_substitutenum == null) {
				//System.out.println("else if(eai_sequence != null && eai_sequence.indexOf('3') != -1 && "
// 																				 + "eai_substitutenum == null) 진입 >>> ");
				
				third = apvo;
				//System.out.println("third >>> : " + third);
				
			}
			
		}
		
		if(obj3!=null && obj4!=null) {
			//System.out.println("if(obj3!=null && obj4!=null) 진입 >>> ");
			
			List<MemberVO> list_names = (List<MemberVO>) obj3;
			//System.out.println("list_names >>> : " + list_names);
			
			List<MemberVO> list_subname = (List<MemberVO>) obj4;
			//System.out.println("list_subname >>> : " + list_subname);
			
			for(int i=0; i<list_names.size(); i++) {

				MemberVO mvo_name = list_names.get(i);
				//System.out.println("mvo_name >>> : " + mvo_name);
				//System.out.println("mvo_name.getHm_empnum() >>> : " + mvo_name.getHm_empnum());
				
				//System.out.println("draft.getEai_recentnum() >>> : " + draft.getEai_recentnum());
				
				if(mvo_name!=null) {

					//System.out.println("if(mvo_name!=null) 진입 >>> ");	
					
					if(draft!=null) {
						//System.out.println("if(draft!=null) 진입 >>> ");
						if(mvo_name.getHm_empnum().indexOf(draft.getEai_recentnum()) != -1) {
							
							draft_name = mvo_name.getHm_name();
							//System.out.println("draft_name >>> : " + draft_name);
							
						} 
					}
					
					if(first!=null) {
						//System.out.println("if(first!=null) 진입 >>> ");
						if(mvo_name.getHm_empnum().indexOf(first.getEai_recentnum()) != -1) {
							
							first_name = mvo_name.getHm_name();
							//System.out.println("first_name >>> : " + first_name);
							
						} 
					}
					
					if(second!=null) {
						//System.out.println("if(second!=null) 진입 >>> ");
						if(mvo_name.getHm_empnum().indexOf(second.getEai_recentnum()) != -1) {
							
							second_name = mvo_name.getHm_name();
							//System.out.println("second_name >>> : " + second_name);
							
						}
					}
					
					if(third!=null) {
						//System.out.println("if(third!=null) 진입 >>> ");
						if(mvo_name.getHm_empnum().indexOf(third.getEai_recentnum()) != -1) {
							
							third_name = mvo_name.getHm_name();
							//System.out.println("third_name >>> : " + third_name);
							
						}
					}
					
				}
				
			}
			
			
			for(int i=0; i<list_subname.size(); i++) {
				
				MemberVO mvo_subname = list_subname.get(i);
				//System.out.println("mvo_subname >>> : " + mvo_subname);
				//System.out.println("mvo_subname.getHm_empnum() >>> : " + mvo_subname.getHm_empnum());
				
				if(substitute!=null) {
					//System.out.println("if(substitute!=null) 진입 >>> ");
					if(mvo_subname.getHm_empnum().indexOf(substitute.getEai_recentnum()) != -1) {
						
						substitute_name = mvo_subname.getHm_name();
						//System.out.println("substitute_name >>> : " + substitute_name);
						
					}
				}
				
			}
			
		
		}
		
	%>
		
		<header class="header"> 
	       <%@ include file="/WEB-INF/views/commons/header.jsp" %>
	    </header>

	    <aside class="sidebar">
	       <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
	    </aside>
	    
		<div class="context-container">
			<br>
				<!-- ============================================================================================== -->
				<div class="authdetail_align">
				<% 
					if(draft!=null && first==null && substitute==null && second==null && third==null) {
						
						//if(draft.getEai_recentnum().equals(user_id)) {

				%>
						 <%=draft_name %>(<script>document.write(position("<%=draft.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=draft.getEai_auth() %>"));</script></b> 
				<%
						//}
						
					} else if(draft!=null && first!=null && substitute==null && second==null && third==null) {

						//if(draft.getEai_recentnum().equals(user_id) || first.getEai_recentnum().equals(user_id)) {
				%>
						 <%=draft_name %>(<script>document.write(position("<%=draft.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=draft.getEai_auth()%>"));</script></b> - 
						 <%=first_name %>(<script>document.write(position("<%=first.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=first.getEai_auth()%>"));</script></b> 
				<%
						//}
					} else if(draft!=null && first!=null && substitute!=null && second==null && third==null) {
			
						//if(draft.getEai_recentnum().equals(user_id) || first.getEai_recentnum().equals(user_id) ||
																			//second.getEai_recentnum().equals(user_id)) {
				%>
						 <%=draft_name %>(<script>document.write(position("<%=draft.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=draft.getEai_auth()%>"));</script></b> - 
						 <%=first_name %>(<script>document.write(position("<%=first.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=first.getEai_auth()%>"));</script></b> -
						 <%=substitute_name %>(<script>document.write(position("<%=substitute.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=substitute.getEai_auth()%>"));</script></b>
				<%
						//}
					}  else if(draft!=null && first!=null && substitute==null && second!=null && third==null) {
			
						//if(draft.getEai_recentnum().equals(user_id) || first.getEai_recentnum().equals(user_id) ||
																			//second.getEai_recentnum().equals(user_id)) {
				%>
						 <%=draft_name %>(<script>document.write(position("<%=draft.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=draft.getEai_auth()%>"));</script></b> - 
						 <%=first_name %>(<script>document.write(position("<%=first.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=first.getEai_auth()%>"));</script></b> -
						 <%=second_name %>(<script>document.write(position("<%=second.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=second.getEai_auth()%>"));</script></b>
				<%
						//}
					} else if(draft!=null && first!=null && substitute!=null && second!=null && third==null) {

						//if(draft.getEai_recentnum().equals(user_id) || first.getEai_recentnum().equals(user_id) ||
										//second.getEai_recentnum().equals(user_id) || third.getEai_recentnum().equals(user_id)) {
				%>
						<%=draft_name %>(<script>document.write(position("<%=draft.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=draft.getEai_auth()%>"));</script></b> - 
						<%=first_name %>(<script>document.write(position("<%=first.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=first.getEai_auth()%>"));</script></b> -
						<%=substitute_name %>(<script>document.write(position("<%=substitute.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=substitute.getEai_auth()%>"));</script></b> - 
						<%=second_name %>(<script>document.write(position("<%=second.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=second.getEai_auth()%>"));</script></b>
				<%
						//}
					} else if(draft!=null && first!=null && second!=null && third!=null && substitute!=null) {

						//if(draft.getEai_recentnum().equals(user_id) || first.getEai_recentnum().equals(user_id) ||
										//second.getEai_recentnum().equals(user_id) || third.getEai_recentnum().equals(user_id) ||
																					//substitute.getEai_recentnum().equals(user_id)) {
				%>
						<%=draft_name %>(<script>document.write(position("<%=draft.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=draft.getEai_auth()%>"));</script></b> - 
						<%=first_name %>(<script>document.write(position("<%=first.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=first.getEai_auth()%>"));</script></b> -
						<%=substitute_name %>(<script>document.write(position("<%=substitute.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=substitute.getEai_auth()%>"));</script></b> - 				   				  
						<%=second_name %>(<script>document.write(position("<%=second.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=second.getEai_auth()%>"));</script></b> -  				  
						<%=third_name %>(<script>document.write(position("<%=third.getEai_position() %>"));</script>) 
						 				  <b><script>document.write(authorization("<%=third.getEai_auth()%>"));</script></b>
				<%
						//}
					}
				%>
				</div>
				<!-- ============================================================================================== -->
		<br><br>
		<div class="authdetail_div" id="detail_div">
			<br><br>
			<table align="center">
				<colgroup>
					<col width="1200px"/>
				</colgroup>
				<tr>
					<td>
						<table id="signstamp_table" border="1" align="right">
							<colgroup>
								<col width="90px"/>
								<col width="90px"/>
								<col width="90px"/>
								<col width="90px"/>
							</colgroup>
							<tr align="center">
								<td>기안</td>
								<td>1차</td>
								<td>2차</td>
								<td>3차</td>
							</tr>
							<tr height="90px" align="center">
					<%
						if(draft!=null) {

							//System.out.println("if(draft!=null) 진입 >>> ");

							if((draft.getEai_filedir() == null))	{
								//System.out.println("if((draft.getEai_filedir() == null) || (first == null)) 진입 >>> ");
					%>
								<td class="slash"></td>
					<%
							} else {
					%>
								<td>
									<img alt="이미지 없음" src="../<%=draft.getEai_filedir() %>" style="width:70px;height:70px;">
								</td>
					<%
							}
						} else {
					%>
								<td></td>
					<%
						}
	
						if(first!=null) {
							
							//System.out.println(" if(first!=null) 진입 >>> ");
				
							if((first.getEai_filedir() == null))	{
					%>
								<td class="slash"></td>
					<%
							} else {
					%>
								<td>
									<img alt="이미지 없음" src="../<%=first.getEai_filedir() %>" style="width:70px;height:70px;">
								</td>
					<%
							}
						} else {
							//System.out.println(" if(first!=null)-else 진입 >>> ");
					%>
							<td></td>
					<%
						}
							
							if(second!=null) {
								
								//System.out.println("if(second!=null) 진입 >>> ");
							
								if((second.getEai_filedir() == null))	{
									//System.out.println("if((second.getEai_filedir() == null) || (second == null)) 진입 >>> ");
					%>
									<td class="slash"></td>
					<%
								} else {
					%>
									<td>
										<img alt="이미지 없음" src="../<%=second.getEai_filedir() %>" style="width:70px;height:70px;">
									</td>
					<%
								}
							} else {
								//System.out.println("if(second!=null)-else 진입 >>> ");
					%>
									<td></td>
					<%
							}
							
	
						if(third!=null) {

							//System.out.println(" if(third!=null) 진입 >>> ");
							
							if((third.getEai_filedir() == null))	{
								//System.out.println("if((third.getEai_filedir() == null) || (third == null)) 진입 >>> ");
					%>
								<td class="slash"></td>
					<%
							} else {
					%>
								<td>
									<img alt="이미지 없음" src="../<%=third.getEai_filedir() %>" style="width:70px;height:70px;">
								</td>
					<%
							}
						} else {
							//System.out.println(" if(third!=null)-else 진입 >>> ");
					%>
								<td></td>
					<%		
						}
					%>
							</tr>
							<tr align="center">
					<%
						if(draft != null && draft_name != "") {
					%>
								<td>
									<%=draft_name %>(<script>document.write(position(<%=draft.getEai_position() %>));</script>)
								</td>
					<%	
						} else {
					%>
								<td></td>
					<%
						}
					
						if(first != null && first_name != "") {
					%>
								<td>
									<%=first_name %>(<script>document.write(position(<%=first.getEai_position() %>));</script>)
								</td>
					<%
						} else {
					%>
							<td></td>
					<%
						}
					
					//	if(substitute == null) {

							if(second != null && second_name != "") {			
				
					%>
								<td>
									<%=second_name %>(<script>document.write(position(<%=second.getEai_position() %>));</script>)
								</td>
					<%
							} else {
					%>
								<td></td>
					<%
							}
							
					//	} else {
				
					//	}
						
						if(third != null && third_name!= "") {
					%>
								<td>
									<%=third_name %>(<script>document.write(position(<%=third.getEai_position() %>));</script>)
								</td>
					<%
						} else {
					%>
							<td></td>
					<%
						}
					%>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br><br>
			<center>
			<form id="search_form" name="search_form" method="POST">
					<table class="auth_detail" id="detail_proposal" cellpadding="10">
						<colgroup>
							<col width="100px"/>
							<col width="200px"/>
						</colgroup>
						<tr>
							<td>서류번호</td>
							<td>
								<%=pvo.getEp_num()%>
							</td>
						</tr>
						<tr>
							<td>결재번호</td>
							<td>
								<%=pvo.getEa_num()%>
								<input type="hidden" id="ea_num" name="ea_num" value="<%=pvo.getEa_num()%>">
							</td>
						</tr>
						<tr>
							<td>제목</td>
							<td>
								<%=pvo.getEp_title() %>
							</td>
						</tr>
						<tr>
							<td>사원번호</td>
							<td>
								<%=pvo.getHm_empnum() %>
							</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td>
								<%=pvo.getEp_writer() %>
							</td>
						</tr>
						<tr>
							<td>직급</td>
							<td>
								<script type="text/javascript">
										document.write(position(<%=pvo.getHm_position()%>));
								</script>
							</td>
						</tr>
						<tr>
							<td>결재기간</td>
							<td>
						<%
							String eap_startdate = pvo.getEp_startdate();
							//System.out.println("eap_startdate >>> : " + eap_startdate);
							String startdate_year = eap_startdate.substring(0,4);
							//System.out.println("startdate_year >>> : " + startdate_year);
							String startdate_month = eap_startdate.substring(4,6);
							//System.out.println("startdate_month >>> : " + startdate_month);
							String startdate_day = eap_startdate.substring(6,8);
							//System.out.println("startdate_day >>> : " + startdate_day);
							
							String eap_enddate = pvo.getEp_enddate();
							//System.out.println("eap_enddate >>> : " + eap_enddate);
							String enddate_year = eap_enddate.substring(0,4);
							//System.out.println("enddate_year >>> : " + enddate_year);
							String enddate_month = eap_enddate.substring(4,6);
							//System.out.println("enddate_month >>> : " + enddate_month);
							String enddate_day = eap_enddate.substring(6,8);
							//System.out.println("enddate_day >>> : " + enddate_day);
						%>
								<%=startdate_year%>.<%=startdate_month%>.<%=startdate_day%> ~
								<%=enddate_year%>.<%=enddate_month%>.<%=enddate_day%>
							</td>
						</tr>
						<tr>
							<td>분류</td>
							<td>
								<script type="text/javascript">
										document.write(group(<%=pvo.getEp_group()%>));
								</script>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div name="ep_content" id="ep_content"
									 style="overflow:auto; width:600px; height:270px; 
									 		border-top:1px solid; border-bottom:1px solid; 
									 		border-left:1px solid; border-right:1px solid; padding:10px;">
									<%=pvo.getEp_content()%>
								</div>
								<!-- <textarea name="ep_content" id="ep_content" title="내용"
								style="width: 100%; height: 400px; padding: 0; margin: 0;"></textarea> -->
							</td>
						</tr>
					</table>
					
					<input type="hidden" id="hm_empnum" name="hm_empnum" value="<%=user_id%>">
					
					</form>
				</center>
		</div>
		<br>
				<%
					if(ea_presentnum.equals(user_id)) {
						//System.out.println("if(ea_presentnum.equals(user_id)) 진입 >>> ");
				%>
						<div class="authdetail_align" id="buttons" align="right">

							<input type="button" id="return_button" class="button" style="width:50px;" value=" 반려 ">&nbsp;
							<input type="button" id="sub_button" class="button" style="width:50px;" value=" 대결 ">&nbsp;
							<input type="button" id="approval_button" class="button" style="width:50px;" value=" 승인 ">

						</div>
				<%		
					}
				%>		
				<br><br>
				
		<%
			} else {
		%>
				<script type="text/javascript">
					alert("데이터가 없습니다.");
					history.back();
				</script>
		<%
			}
		%>
			<br><br>
		</div>
	</body>
</html>