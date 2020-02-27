<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java142.todak.sponsor.vo.MemberVO" %>
<%@ page import="java142.todak.sponsor.vo.SponsorshipVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	String message = (String)request.getAttribute("message");
	//System.out.println(" message >>> " + message);
	if (message != null){
		%>
		<script type="text/javascript">
			var message = '<%= message %>';
			if (message != null && message != ''){
				alert(message);
			}
		</script>
		<%
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>비영리후원인 조회</title>
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<!-- 
		<script type="text/javascript" 
				src="/include/js/jquery-1.11.0.min.js" ></script> -->
		<script type="text/javascript">
			$(function(){
				/* 글쓰기 버튼 클릭 시 처리 이벤트 */
				$("#registerForm").click(function(){
					location.href = "/sponsor/moveIUMember.td";
				});
				
				/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */
				$(".goDetail").click(function(){
					var sm_num = $(this).parents("tr").attr("data-num");
					$("#sm_num").val(sm_num);
					// 상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
					$("#detailForm").prop({
						"method" : "post",
						"action" : "/sponsor/selectMember.td"
					}).submit();
				});
			});
		</script>
	</head>
	<body>
         <header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>
		
		<section class="body">
	         <aside class="sidebar">
	            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
	         </aside>
	
			<% System.out.println(sManager.getUserID(session.getId())); %>
			<div class="context-container">
				<div id="boardTit"><h3>후원인목록</h3></div>
				<form name="detailForm" id="detailForm">
					<input type="hidden" name="sm_num" id="sm_num">
					<input type="hidden" name="selectFunc" id="selectFunc" value="search">
					<input type="hidden" name="message" id="message" value="">
				</form>
				<%-- =========== 검색기능 시작 (이 부분 전체 추가) =========== --%>
				<div id="boardSearch">
					<form id="f_search" name="f_search">
						<table summary="검색">
							<colgroup>
								<col width="70%"></col>
								<col width="30%"></col>
							</colgroup>
							<tr>
								<td id="btd1">
									<label>검색조건</label>
									<select id="search" name="search">
										<option value="all">전체</option>
										<option value="sm_num">후원인번호</option>
										<option value="sm_name">후원인이름</option>
										<option value="sm_insertdate">가입일</option>
									</select>
									<input type="text" name="keyword" id="keyword" value="검색어를입력하세요" />
									<input type="button" value="검색" id="searchData" />
								</td>
								<td id="btd2">한페이지에
									<select id="pageSize" name="pageSize">
										<option value="5">5줄</option>
										<option value="10">10줄</option>
										<option value="20">20줄</option>
										<option value="30">30줄</option>
										<option value="50">50줄</option>
										<option value="100">100줄</option>
									</select>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<%-- ================== 검색기능 종료 ================== --%>
				<%-- =================== 리스트 시작 =================== --%>
				<div id="memberList">
					<table summary="후원인리스트">
						<colgroup>
							<col width = "10%" />
							<col width = "10%" />
								<%-- 
							<col width = "10%" />
							<col width = "60%" />
								--%>
							<col width = "10%" />
						</colgroup>
						<thead>
							<tr>
								<th>후원인번호</th>
								<th>후원인명</th>
								<%-- 
								<th>최근후원일</th>
								<th>총 후원금액</th> 
								--%>
								<th>가입일</th>
							</tr>
						</thead>
						<tbody>
							<%
								List<MemberVO> memberList = (List<MemberVO>)request.getAttribute("memberList");
								//List<SponsorshipVO> sponsorshipList = (List<SponsorshipVO>)request.getAttribute("sponsorshipList");
								if (memberList != null && !memberList.isEmpty()
										//&&	sponsorshipList != null && !sponsorshipList.isEmpty()
									){
									Iterator<MemberVO> iter = memberList.iterator();
									while(iter.hasNext()){
										MemberVO smvo = iter.next();
							%>
							<!-- 데이터 출력 -->
										<tr align="center" data-num="<%= smvo.getSm_num() %>">
											<td><%= smvo.getSm_num() %></td>
											<td><span class="goDetail"><%= smvo.getSm_name() %></span></td>
								<%-- 
											<td><%= smvo.getSm_bizfield() %></td>
											<td><%= smvo.getSm_bizcontents() %></td>
								--%>
											<td><%= new StringBuffer(smvo.getSm_insertdate()).insert(6, "-").insert(4, "-").toString() %></td>
										</tr>
							<%
									}
								}else{
							%>
									<tr>
										<td colspan="5" align="center">등록된 게시물이 존재하지 않습니다.</td>
									</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
				<%-- =================== 리스트 종료 =================== --%>
				
				<%-- ================ 글쓰기 버튼 출력 시작 ================ --%>
				<div id="memberBtn">
					<input type="button" value="후원인등록" id="registerForm">
				</div>
				<%-- ================ 글쓰기 버튼 출력 종료 ================ --%>
				
			</div>
		</section>
	</body>
</html>