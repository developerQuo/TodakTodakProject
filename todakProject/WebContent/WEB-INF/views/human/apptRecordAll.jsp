<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>   
<%@ page import="java142.todak.human.vo.ApptVO"%>      
<%@ page import="java142.todak.human.vo.PagingVO"%>   
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<%
		Object obj=request.getAttribute("apptList");
		ArrayList aList = (ArrayList)obj;
		ApptVO apvo=null;
		Object obj2=request.getAttribute("apvo");
		
		ApptVO pageVO=(ApptVO)obj2;
		String key=pageVO.getKeyword();
		String ser=pageVO.getSearch();
		
		int Size=pageVO.getPageSize();
		
		int pageSize = pageVO.getPageSize();
		int groupSize = pageVO.getGroupSize();
		int curPage = pageVO.getCurPage();
		int totalCount = pageVO.getTotalCount();
		
		if(request.getParameter("curPage") != null)
		{
			curPage = Integer.parseInt(request.getParameter("curPage"));
		}
		
	%>
</head>
<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript">
	$(function(){
		if('<%=key %>' != 'null'){
			$("#keyword").val('<%=key %>');
			$("#search").val('<%=ser %>');
		}
		if('<%=Size %>' > 0){
			$("#pageCtrl").val('<%=Size %>');
		}
		$("#search").change(function(){
			if($("#search").val()=="all"){
				$("#keyword").val("전체목록을 조회");
			}else if($("#search").val()!="all"){
				$("#keyword").val("");
				$("#keyword").focus();
			}
		});
		$("#selectData").click(function(){
			if($("#search").val()!="all"){
				if(!chkSubmit($('#keyword'),"검색어를"))return;
			}
			goPage(1);
		});
		
		$("#pageCtrl").change(function(){
			goPage(1);
		});
		
	});

	function goPage(page){
		if($("#search").val()=="all"){
			$("#keyword").val("");
		}
		$("#page").val(page);
		$("#PageSearch").attr({
			"method":"get",
			"action":"/human/apptAllselect.td"
		});
		$("#PageSearch").submit();
	}
	function chkSubmit(v_item,v_msg){
		if(v_item.val().replace(/\s/g,"")==""){
			alert(v_msg+"확인해 주세요.");
			v_item.val("");
			v_item.focus();
			return false;
		}else{
			return true;
		}
	}
	</script>
	<body>
			<header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>

         <aside class="sidebar">
            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
         </aside>
         
     <div class="container"> 
				<table border="1" align="center">
					<thead>
						<tr>
							<th>발령번호</th>
							<th>이름</th>
							<th>발령일</th>
							<th>발령내용</th>
							<th>비고</th>
						</tr>
<%
					
					if(aList.size()>0)
					{
						for(int i=0;i<aList.size();i++){
							apvo=(ApptVO)aList.get(i);		
					
%>					
						<tr>
							<th><%=apvo.getHpa_tablenum()  %></th>
							<th><%=apvo.getHpa_name()  %></th>
							<th><%=apvo.getHpa_appointmentdate()  %></th>
<%
							if(apvo.getHpa_appointment().equals("승진")){							
%>							
							<th>
								<%=apvo.getHpa_appointment() %>&nbsp;&nbsp;
								이전 직위/직책<%=apvo.getHpa_bposition() %>/<%=apvo.getHpa_bduty() %><br>
								이후 직위/직책<%=apvo.getHpa_aposition() %>/<%=apvo.getHpa_aduty() %>
							</th>							
<%
							}
							if(apvo.getHpa_appointment().equals("부서이동")){
%>			
							<th>
								<%=apvo.getHpa_appointment() %>&nbsp;&nbsp;
								이전 부서/팀<%=apvo.getHpa_bdept() %>/<%=apvo.getHpa_bteam() %><br>
								이후 부서/팀<%=apvo.getHpa_adept() %>/<%=apvo.getHpa_ateam() %>
							</th>	
<%
							}
%>		
							<th><%=apvo.getHpa_contents() %></th>							
						</tr>	
<%
						}
					}
					if(aList.size()==0){
%>					
						<tr>
							<td colspan="5">조회된 정보가 없습니다.</td>
						</tr>
<%
					}
%>					
					</thead>
				</table>
			<div id="StatusSearch" name="StatusSearch">
			<form id="PageSearch" name="PageSearch">
				<input type="hidden" id="page" name="page" value="1"/>
			
				<table summary="검색">
				<tr>
					<td id="std1">
						<label>검색조건</label>
						<select id="search" name="search">
							<option value="all">전체</option>
							<option value="hpa_name">성명</option>
							<option value="hpa_empnum">사원번호</option>
						</select>
						<input type="text" name="keyword"
							id="keyword" value="검색어를 입력하세요"/>
						<input type="button" value="검색" id="selectData"/>	
					</td>
					<td id="std1">
						<select id="pageCtrl" name="pageCtrl">
							<option value="5">5줄</option>
							<option value="10">10줄</option>
							<option value="20">20줄</option>
							<option value="30">30줄</option>
							<option value="50">50줄</option>
						</select>
					</td>	
				</tr>
				</table>
			</form>
		</div>
			<jsp:include page="paging.jsp" flush="true">
					<jsp:param name="url" value="/human/apptAllselect.td"/>
					<jsp:param name="str" value=""/>
					<jsp:param name="pageSize" value="<%=pageSize%>"/>
					<jsp:param name="groupSize" value="<%=groupSize%>"/>
					<jsp:param name="curPage" value="<%=curPage%>"/>
					<jsp:param name="totalCount" value="<%=totalCount%>"/>
					<jsp:param name="key" value="<%=key%>"/>
					<jsp:param name="ser" value="<%=ser%>"/>
			</jsp:include>
			</div>
	</body>
</html>