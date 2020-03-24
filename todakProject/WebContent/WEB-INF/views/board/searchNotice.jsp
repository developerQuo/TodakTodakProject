<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java142.todak.board.controller.BoardController"  %>
<%@ page import="java142.todak.common.FileReadUtil"  %>
<%@ page import="java142.todak.board.vo.NoticeVO"  %>
<%@ page import="java.util.ArrayList"  %>

<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>공지사항 상세보기 페이지</title>
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script	type="text/javascript">
		$(function(){
			
	 		$("#selectNotice").click(function(){
	 			var n_hm_empnum = $("#n_hm_empnum").val();
	 			$("#hm_empnum").val(n_hm_empnum);
	 			
	 			$("#searchNotice").attr({
	 				"method" : "post",
	 	 			"action" : "../board/selectNotice.td"
	 				
	 			});
	
	 			$("#searchNotice").submit();
	 		});
			$("#fileDown").click(function(){
	            var bn_file = $("#bn_file").val();               
	            $("#bn_file").val(bn_file);
	            alert("bn_file >>> : " + bn_file);
	            $("#searchNotice")
	            .attr("action","../board/downloadNotice.td")
	            .submit();
	         });
			
			
			$("#updateNotice").click(function(){
	            var bn_num = $("#bn_num").val();               
	            $("#bn_num").val(bn_num);

	            $("#searchNotice")
	            .attr("action","../board/moveUpdateNotice.td")
	            .submit();
	         });
			
	 		$("#deleteNotice").click(function(){
	 			var bn_num = $("#bn_num").val();
	 			$("#bn_num").val(bn_num);
	            alert("bn_num >>> : " + bn_num);
	 			$("#searchNotice")
	 			.attr("action","../board/deleteNotice.td")
	            .submit();
	 		});
	 		
			$("#checkNotice").click(function(){
	            var bn_num = $("#bn_num").val();               
	            $("#bn_num").val(bn_num);
	            
	 			var n_hm_empnum = $("#n_hm_empnum").val();
	 			$("#hm_empnum").val(n_hm_empnum);

				window.open("", "pop", "width=480, height=280");
				$("#searchNotice").attr({"action" : "../board/moveCheckNotice.td",
										 "target" : "pop",
										 "method":"post"});
				$("#searchNotice").submit();
				
				location.reload();
	         });
			
			$("#checkList").click(function(){
	 			var n_hm_empnum = $("#n_hm_empnum").val();
	 			$("#hm_empnum").val(n_hm_empnum);

				window.open("", "pop", "width=600, height=280");
				$("#searchNotice").attr({"action" : "../board/checkList.td", "method" : "post", "target":"pop" });
				$("#searchNotice").attr("target","pop");
				$("#searchNotice").submit();
				
				location.reload();
				
	         });
	 		
	    });
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
	         
	<%
			//n_hm_empnum는 현재 글을 보고 있는 사람의 empnum!
			String n_hm_empnum = sManager.getUserID(session.getId());
	
	  		Object obj = request.getAttribute("noticeSearchList");
			ArrayList<NoticeVO> sList = (ArrayList<NoticeVO>)obj;
			
			NoticeVO nvo = sList.get(0);
			String i_hm_empnum = nvo.getHm_empnum();
	
			System.out.println(n_hm_empnum + " : " + i_hm_empnum);
	%>
			
			
			
			<form name="searchNotice" id="searchNotice">
				<input type="hidden" id="bn_file" name="bn_file" value="<%=nvo.getBn_file() %>">
				<input type="hidden" id="bn_num" name="bn_num" value="<%=nvo.getBn_num() %>">
				<input type="hidden" id="hm_empnum" name="hm_empnum" value="<%=i_hm_empnum %>">
				<input type="hidden" id="n_hm_empnum" name="n_hm_empnum" value="<%=n_hm_empnum %>">
				<div align="center" id="searchNotice">
					<table>
						<colgroup>
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
						</colgroup>
						<tbody>
						<tr>
							<td class="ac">작성자</td>
							<td><%=nvo.getHm_name() %></td>
							<td class="ac">작성일</td>
							<td><%=nvo.getBn_insertdate().substring(0,10) %></td>
						</tr>
						<tr>
							<td class="ac">제목</td>
							<td colspan="3"><%=nvo.getBn_title() %></td>
						</tr>
						<tr class="ctr">
							<td class="ac">내용</td>
							<td colspan="3"><%=nvo.getBn_content() %></td>
						</tr>
	<%
					String bn_image = nvo.getBn_image();
					if(bn_image != null && bn_image.length() != 0){
	%>
	
					<tr class="ctr">
						<td class="ac">첨부사진</td>
						<td colspan="3"><img src="../<%=nvo.getBn_image() %>" border=0></td>					
					</tr>
	<%
					}
					
					String bn_file = nvo.getBn_file();
					
					if(bn_file != null && bn_file.length() != 0){
	%>
						<tr class="ctr">
							<td class="ac">다운로드파일</td>
							
							<td><%=bn_file %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="fileDown" name="fileDown" value="파일 다운로드">
							
							</td>
						</tr>
	<%
					}
	%>
					</tbody>
					</table>
					</div>
	<%
			if(i_hm_empnum.equals(n_hm_empnum)|| n_hm_empnum.equals("H000000000000")){
	
	%>
	
					<div align="center">
						<input align="left" type="button" value="확인자리스트" class="but" id="checkList" name="checkList"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input align="right" type="button" value="수정" class="but" id="updateNotice" name="updateNotice"/>
						<input align="right" type="button" value="삭제" class="but" id="deleteNotice" name="deleteNotice"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input align="right" type="button" value="목록" class="but" id="selectNotice" name="selectNotice"/>
					</div>
	<%
			}else{
	%>
	
					<div align="right">
						<input type="button" value="확인" id="checkNotice" name="checkNotice" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="목록" class="but" id="selectNotice" name="selectNotice"/>
					</div>
	<%
			}
	%>
			</form>
         </div>
	</body>
</html>