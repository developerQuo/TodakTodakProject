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
		
		String ser=pageVO.getSearch();
		
		int size=pageVO.getPageSize();
		
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
		
			<jsp:include page="paging.jsp" flush="true">
					<jsp:param name="url" value="/human/apptRecord.td"/>
					<jsp:param name="str" value=""/>
					<jsp:param name="pageSize" value="<%=pageSize%>"/>
					<jsp:param name="groupSize" value="<%=groupSize%>"/>
					<jsp:param name="curPage" value="<%=curPage%>"/>
					<jsp:param name="totalCount" value="<%=totalCount%>"/>
					<jsp:param name="ser" value="<%=ser%>"/>
			</jsp:include>
			</div>
	</body>
</html>