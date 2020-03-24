<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collection" %>

<%
	/**********************************
	전달해야 할 변수
	***********************************/
	String	url = null;
	String	str = null;
	String keyword=null;
	String search=null;
	String ctrl=null;
	String startday=null;
	String endday=null;
	String empnum = null;
	url = request.getParameter("url");
	str = request.getParameter("str");
	keyword=request.getParameter("key");
	search=request.getParameter("ser");
	ctrl=request.getParameter("pageSize");
	startday=request.getParameter("sdate");
	endday=request.getParameter("edate");
	
	
	
	if(str != null)
	{
		str = str + "&";
	}
%>

<%
	/**********************************
	페이지 네비게이션 관련 변수
	***********************************/
	// 한페이지에 보여질 게시물의 수
	int pageSize = 0;
	
	// 그룹의 크기
	int groupSize = 0;
	
	// 전체 게시물의 개수
	int totalCount = 0;
	
	//현재 페이지
	int curPage = 0;
	
	// 전체 페이지의 개수
	int pageCount = 0;
	
	if(request.getParameter("pageSize") != null)
	{
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
	}
	
	if(request.getParameter("groupSize") != null)
	{
		groupSize = Integer.parseInt(request.getParameter("groupSize"));
	}
	
	if(request.getParameter("curPage") != null)
	{
		curPage = Integer.parseInt(request.getParameter("curPage"));
	}
	
	if(request.getParameter("totalCount") != null)
	{
		totalCount = Integer.parseInt(request.getParameter("totalCount"));
	}
	
	// 전체게시물수와 페이지크기를 가지고 전체 페이지 개수를 계산함.
	// 소수점에 따라 계산상의 오류가 없도록 한것임.

	pageCount = (int)Math.ceil(totalCount / (pageSize+0.0));
	
	// 현재그룹 설정
	int curGroup = (curPage-1) / groupSize;
	int linkPage = curGroup * groupSize;
%>
<p align="center">
<%
	// 첫번째 그룹인 아닌경우
	if(curGroup > 0) {
%>
	<a href="<%=url%>?<%=str%>curPage=1&key=<%=keyword %>&ser=<%=search%>&pageCtrl=<%=ctrl%>&startday=<%=startday%>&endday=<%=endday%>">◁◁</a>&nbsp;&nbsp;&nbsp;
	<a href="<%=url%>?<%=str%>curPage=<%=linkPage%>&key=<%=keyword %>&ser=<%=search%>&pageCtrl=<%=ctrl%>&startday=<%=startday%>&endday=<%=endday%>">◀</a>&nbsp;&nbsp;&nbsp;
<%
	}
	else
	{
%>
◁◁&nbsp;&nbsp;&nbsp;◀&nbsp;&nbsp;&nbsp;
<%
	}
	
	// 다음 링크를 위해 증가시킴
	linkPage++;
	
	int loopCount = groupSize;
	// 그룹범위내에서 페이지 링크만듬.
	while((loopCount > 0) && (linkPage <= pageCount))
	{
		if(linkPage == curPage)
		{
%>
	<%=linkPage%>
<%
		}
		else
		{
%>
	[<a href="<%=url%>?<%=str%>curPage=<%=linkPage%>&key=<%=keyword %>&ser=<%=search%>&pageCtrl=<%=ctrl%>&startday=<%=startday%>&endday=<%=endday%>"><%=linkPage%></a>]&nbsp;
<%
		}
		
		linkPage++;
		loopCount--;
	}
	
	// 다음그룹이 있는 경우
	if(linkPage <= pageCount)
	{
%>
	<a href="<%=url%>?<%=str%>curPage=<%=linkPage%>&key=<%=keyword %>&ser=<%=search%>&pageCtrl=<%=ctrl%>&startday=<%=startday%>&endday=<%=endday%>">▶</a>&nbsp;&nbsp;&nbsp;
	<a href="<%=url%>?<%=str%>curPage=<%=pageCount%>&key=<%=keyword %>&ser=<%=search%>&pageCtrl=<%=ctrl%>&startday=<%=startday%>&endday=<%=endday%>">▷▷</a>&nbsp;&nbsp;&nbsp;
<%
	}
	else
	{
%>
	&nbsp;&nbsp;&nbsp;▶&nbsp;&nbsp;&nbsp;▷▷
<%
	}
%>
</p>