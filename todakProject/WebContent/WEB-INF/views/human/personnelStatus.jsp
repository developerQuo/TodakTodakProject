<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.ArrayList" %>     
 <%@ page import="java142.todak.human.vo.MemberVO"%>
 <%@ page import="java142.todak.human.vo.StatusVO"%>  
  <%@ page import="java142.todak.human.vo.PagingVO"%> 
  <%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<%	
		Object obj=request.getAttribute("memberList");
		ArrayList aList =(ArrayList) obj;
		
		Object obj2=request.getAttribute("hvo");
		MemberVO pvo=(MemberVO) obj2;
		
		Object obj3=request.getAttribute("svo");
		StatusVO stvo=(StatusVO) obj3;
		
		String tCnt=stvo.getHs_total();
		String cCnt=stvo.getHs_current();
		String rCnt=stvo.getHs_regular();
		String conCnt=stvo.getHs_constract();
		
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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>사원 현황</title>
	
	<link rel="stylesheet" href="/include/css/commons/humanTable.css">
	
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
			$("#deptCommRecord").click(function(){				
				$.ajax({
					url:"/human/deptAuthority.td",
					type:"POST",
					error:function(){
						alert('시스템 오류 입니다. 관리자에게 문의 하세요');
					},
					success:function(resultData){
						if(resultData==false){
							alert("권한이 불충분 합니다!");
						}
						if(resultData==true){
							
							$("#PageSearch")
				 			.attr("action","/human/selectAllcommRecord.td")
				            .submit();
						}
					}
				});
			});
			
		});
	
		function goPage(page){
			if($("#search").val()=="all"){
				$("#keyword").val("");
			}
			$("#page").val(page);
			$("#PageSearch").attr({
				"method":"get",
				"action":"/human/select.td"
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
         
     <div class="context-container">
     
     <h3><b>사원 현황</b></h3>
     <hr>
        
     <div class="total">
    	 <table>
    	 	<colgroup>
            	<col width=10%></col>
                <col width=10%></col>
                <col width=10%></col>
                <col width=10%></col>
            </colgroup>
			<thead>	
				<tr>
					<th>총인원</th>
					<th>현재인원</th>
					<th>정규직</th>
					<th>계약직</th>
				</tr>
			</thead>
			<tbody>	
				<tr>
					<th><%=tCnt %></th>
					<th><%=cCnt %></th>
					<th><%=rCnt %></th>
					<th><%=conCnt %></th>
					
				</tr>
			</tbody>	
		</table>
       </div>
       <br><br>
       <div class="table_align" id="StatusSearch" name="StatusSearch">
			<form id="PageSearch" name="PageSearch">
				<input type="hidden" id="page" name="page" value="1"/>
				<table summary="검색">
					<colgroup>
						<col width="70%"></col>
						<col width="30%"></col>
					</colgroup>
					<tr>
						<td id="std1">
							<label>검색조건</label>
							<select id="search" name="search" >
								<option value="all">전체</option>
								<option value="hm_name">성명</option>
								<option value="hm_deptnum">부서명</option>
								<option value="hm_position">직위</option>
								<option value="hm_deleteYN">재직 상태</option>
								<option value="hm_employmenttype">고용 형태</option>
							</select>
							<input type="text" name="keyword"
								id="keyword" value="검색어를 입력하세요"/>
							<input type="button" value="검색" class="button" id="selectData"/>	
						</td>
						<td id="std1" style="width:165px;"><b>한페이지에</b>
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
       <div class="table_size" id="memberList">

		<table class="table" align="center" summary="사원 현황 조회">
			
			<thead>	
				<tr>
					<th>사원번호</th>
					<th>성명</th>
					<th>부서</th>
					<th>팀</th>
					<th>직위</th>
					<th>생년월일</th>
					<th>입사일</th>
					<th>핸드폰</th>
					<th>내선번호</th>
					<th>이메일</th>
					<th>구분</th>
					<th>상태</th>		
				</tr>
<%

			
	
			if(aList.size()!=0)
			{
				MemberVO mvo=(MemberVO)aList.get(0);
				for(int i=0;i<aList.size();i++){
					mvo=(MemberVO)aList.get(i);
%>
				<tr>
					<td><%=mvo.getHm_empnum() %></td>
					<td><%=mvo.getHm_name() %></td>
					<td><%=mvo.getHm_deptnum() %></td>
					<td><%=mvo.getHm_teamnum() %></td>
					<td><%=mvo.getHm_position() %></td>
					<td><%=mvo.getHm_birth() %></td>
					<td><%=new StringBuffer(mvo.getHm_hiredate()).insert(6, "-").insert(4, "-").toString() %></td>
					
					<td><%=new StringBuffer(mvo.getHm_hp()).insert(3, "-").insert(8, "-").toString() %></td>
					
					<td><%=mvo.getHm_extensionnum() %></td>
					<td><%=mvo.getHm_email() %></td>
					<td><%=mvo.getHm_employmenttype() %></td>
					<td><%=mvo.getHm_deleteYN() %></td>
				</tr>
<%
			
				}
			}
			if(aList.size()==0){
%>									
					<tr><td colspan="5">조회된 정보가 없습니다.</td>
<%
			}
%>
				
			</thead>
		</table>	
		
	</div>
	
	<div class="table_align" align="right">
 			<input type="button" name="deptCommRecord" class="button" id="deptCommRecord" value="사원 출퇴근 기록 조회/변경">
 	</div>
	
	<jsp:include page="paging.jsp" flush="true">
		<jsp:param name="url" value="/human/select.td"/>
		<jsp:param name="str" value=""/>
		<jsp:param name="pageSize" value="<%=pageSize%>"/>
		<jsp:param name="groupSize" value="<%=groupSize%>"/>
		<jsp:param name="curPage" value="<%=curPage%>"/>
		<jsp:param name="totalCount" value="<%=totalCount%>"/>
		<jsp:param name="key" value="<%=key%>"/>
		<jsp:param name="ser" value="<%=ser%>"/>
	</jsp:include>
	<br>
	</div>
	</body>
</html>