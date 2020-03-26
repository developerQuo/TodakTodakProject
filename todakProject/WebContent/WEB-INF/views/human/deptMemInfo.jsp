<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>     
<%@ page import="java142.todak.human.vo.MemberVO"%>    
 <%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	Object obj=request.getAttribute("memberList");
	ArrayList aList=(ArrayList)obj;
	Object obj2=request.getAttribute("mvo");
	MemberVO pvo=(MemberVO) obj2;
	
	String key=pvo.getKeyword();
	String ser=pvo.getSearch();
	
	int Size=pvo.getPageSize();
	//System.out.println(">>>>>>>>>>>>>>>"+key);
	//System.out.println("<<<<<<<<<<<<<<<"+ser);
	
	
	int pageSize = pvo.getPageSize();
	int groupSize = pvo.getGroupSize();
	int curPage = pvo.getCurPage();
	int totalCount = pvo.getTotalCount();
	
	if(request.getParameter("curPage") != null)
	{
		curPage = Integer.parseInt(request.getParameter("curPage"));
	}
%>
<title>부서 사원정보</title>
	<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$(".goDetail").click(function(){
		
				var empnum=$(this).parents("tr").attr("data");
				alert("읽어온 값은"+empnum);
				console.log("읽어온 값은"+empnum);
				$("#hm_empnum").val(empnum);
				window.open("","pop","width=980, height=680");
				$("#detailForm").attr({
					"method":"get",
					"target":"pop",
					"action":"/human/reference.td"
				});
				$("#detailForm").submit();
		});
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
			var str1=$("#search").val();
			var str2=$("#keyword").val();
			alert("값은"+str1);
			alert("값은"+str2);
			$("#page").val(page);
			$("#PageSearch").attr({
				"method":"get",
				"action":"/human/deptReference.td"
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

</head>
	<body>
	<header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>

         <aside class="sidebar">
            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
         </aside>
         
     <div class="container">  
		<form name="detailForm" id="detailForm">
			<input type="hidden" name="hm_empnum" id="hm_empnum">
		</form>
	<div id="memberList">
		<table summary="사원 현황 조회">
			<table border="1" align="center">
			
			<thead>	
				<tr>
					<th>사원번호</th>
					<th>성명</th>
					<th>부서</th>
					<th>직위</th>
					<th>직책</th>
					<th>생년월일</th>
					<th>입사일</th>
					<th>핸드폰</th>
					<th>내선번호</th>
					<th>이메일</th>
					<th>구분</th>	
				</tr>
<%

			if(aList.size()!=0)
			{
				MemberVO mvo=null;
				for(int i=0;i<aList.size();i++){
					mvo=(MemberVO)aList.get(i);
%>
				<tr data='<%=mvo.getHm_empnum() %>'>
					
					<td><%=mvo.getHm_empnum() %></td>
					<td><span class="goDetail"><%=mvo.getHm_name() %></span></td>
					<td><%=mvo.getHm_deptnum() %></td>
					<td><%=mvo.getHm_position() %></td>
					<td><%=mvo.getHm_duty() %></td>
					<td><%=mvo.getHm_birth() %></td>
					<td><%=mvo.getHm_hiredate() %></td>
					<td><%=mvo.getHm_hp() %></td>
					<td><%=mvo.getHm_extensionnum() %></td>
					<td><%=mvo.getHm_email() %></td>
					<td><%=mvo.getHm_employmenttype() %></td>
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
							<option value="hm_name">성명</option>
							<option value="hm_position">직위</option>
							<option value="hm_deleteYN">재직 상태</option>
							<option value="hm_employmenttype">고용 형태</option>
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
			<jsp:param name="url" value="/human/deptReference.td"/>
			<jsp:param name="str" value=""/>
			<jsp:param name="pageSize" value="<%=pageSize%>"/>
			<jsp:param name="groupSize" value="<%=groupSize%>"/>
			<jsp:param name="curPage" value="<%=curPage%>"/>
			<jsp:param name="totalCount" value="<%=totalCount%>"/>
			<jsp:param name="key" value="<%=key%>"/>
			<jsp:param name="ser" value="<%=ser%>"/>
		</jsp:include>
		
	</div>
	</div>
	</body>
	
</html>