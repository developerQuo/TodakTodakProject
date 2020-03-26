<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java142.todak.sponsor.vo.CharityVO" %>
<%@ page import="java142.todak.etc.vo.PagingVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	String message = (String)request.getAttribute("message");
	////System.out.println(" message >>> " + message);
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
<%
	int pageSize = 10;
	int groupSize = 5;
	
	int curPage = 1;
	int totalCount = 0;
	
	PagingVO pvo = (PagingVO)request.getAttribute("pvo");
	if(pvo != null)
	{
		curPage = pvo.getCurPage();
		pageSize = pvo.getPageSize();
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>비영리단체</title>
		<link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<!-- 
		<script type="text/javascript" 
				src="/include/js/jquery-1.11.0.min.js" ></script> -->
		<script type="text/javascript">
			$(function(){
				$("#pageSize").val(<%=pageSize%>).prop("selected", true);
				/* 글쓰기 버튼 클릭 시 처리 이벤트 */
				$("#registerForm").click(function(){
					location.href = "/sponsor/moveIUCharity.td";
				});
				
				/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */
				$(".goDetail").click(function(){
					var sc_num = $(this).parents("tr").attr("data-num");
					$("#sc_num").val(sc_num);
					// 상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
					$("#detailForm").prop({
						"method" : "post",
						"action" : "/sponsor/selectCharity.td"
					}).submit();
				});

				/* 한페이지에 글사이즈 정하는 이벤트 */
				$("#pageSize").change(function(){
					var formName = '#f_search';
					var obj = this;
					var url = "/sponsor/selectCharity.td?selectFunc=''&message=''";
					submitMethod(formName, obj, url);
				});
				
				/* 키워드 검색 이벤트 */
				$("#searchData").click(function(){
					var formName = '#f_search';
					var obj = this;
					var url = "/sponsor/selectCharity.td?selectFunc=''&message=''";
					submitMethod(formName, obj, url);
				});
				
			});
			
			function submitMethod(formName, obj, url){
				var sm_num = $(obj).parents("tr").attr("data-num");
				$("#sm_num").val(sm_num);
				// 상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
				$(formName).prop({
					"method" : "post",
					"action" : url
				}).submit();
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
         
		<% //System.out.println(sManager.getUserID(session.getId())); %>
		<div class="context-container">
			<div id="boardTit"><h3><b>비영리단체</b></h3></div>
			<hr>
			<form name="detailForm" id="detailForm">
				<input type="hidden" name="sc_num" id="sc_num">
				<input type="hidden" name="selectFunc" id="selectFunc" value="search">
				<input type="hidden" name="message" id="message" value="">
			</form>
			<%-- =========== 검색기능 시작 (이 부분 전체 추가) =========== --%>
			<div class="table_align" id="boardSearch">
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
									<option value="sc_bizfield">사업분야</option>
									<option value="sc_bizcontents">사업내용</option>
									<option value="sc_name">단체명</option>
								</select>
								<input type="text" name="keyword" id="keyword" placeholder="검색어를입력하세요" />
								<input type="button" value="검색" class="button" id="searchData" />
							</td>
							<td id="btd2" style="width:165px;">
								<select id="pageSize" name="pageSize">
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
			<div class="table_size" id="charityList">
				<table class="table" summary="비영리단체 리스트">
					<colgroup>
						<col width = "10%" />
						<col width = "15%" />
						<col width = "10%" />
						<col width = "50%" />
						<col width = "15%" />
					</colgroup>
					<thead>
						<tr>
							<th>단체번호</th>
							<th>단체명</th>
							<th class="borcle">사업분야</th>
							<th>사업내용</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<%
							List<CharityVO> charityList = (List<CharityVO>)request.getAttribute("charityList");
							if (charityList != null && !charityList.isEmpty()){
								Iterator<CharityVO> iter = charityList.iterator();
								while(iter.hasNext()){
									CharityVO scvo = (CharityVO)iter.next();
									totalCount = (int)scvo.getTotalCount();
						%>
						<!-- 데이터 출력 -->
									<tr align="center" data-num="<%= scvo.getSc_num() %>">
										<td><%= scvo.getSc_num() %></td>
										<td><span class="goDetail"><%= scvo.getSc_name() %></span></td>
										<td><%= scvo.getSc_bizfield() %></td>
										<td><%= scvo.getSc_bizcontents() %></td>
										<td><%= new StringBuffer(scvo.getSc_registrationdate()).insert(6, "-").insert(4, "-").toString() %></td>
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
			<div class="table_align" id="charityBtn" align="right">
				<input type="button" value="단체등록" class="button" id="registerForm">
			</div>
			<%-- ================ 글쓰기 버튼 출력 종료 ================ --%>
			<jsp:include page="/WEB-INF/views/commons/paging.jsp" flush="true">
				<jsp:param name="url" value="/sponsor/selectCharity.td"/>
				<jsp:param name="str" value=""/>
				<jsp:param name="pageSize" value="<%=pageSize%>"/>
				<jsp:param name="groupSize" value="<%=groupSize%>"/>
				<jsp:param name="curPage" value="<%=curPage%>"/>
				<jsp:param name="totalCount" value="<%=totalCount%>"/>
			</jsp:include>
			<br>
		</div>
	</body>
</html>