<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java142.todak.board.controller.BoardController"  %>
<%@ page import="java142.todak.board.vo.NoticeVO"  %>
<%@ page import="java142.todak.board.vo.NoCheckVO"  %>
<%@ page import="java142.todak.common.DateUtil"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>CheckListNotice</title>
		
		<link href="/include/css/default.css" rel="stylesheet">
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#closeList").click(function(){
					
					window.close();
					
				});
				
			});
		</script>
	</head>
	<body>
         <div style="width:520px;min-height:200px;">
         	<br>
			<form>
				<div align="center">
					<table class="checklist_table">
						<colgroup>
							<col width="10%"/>
							<col width="25%"/>
							<col width="25%"/>
							<col width="40%"/>
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>성명</th>
								<th>부서</th>
								<th>확인날짜</th>
							</tr>
						</thead>
						<tbody>
		<%
					Object obj = request.getAttribute("cList");
					ArrayList<NoCheckVO> cList = (ArrayList<NoCheckVO>)obj;
					
					if(cList.size() > 0 ){
						for(int i = 0 ; i < cList.size() ; i ++ ){
						
							NoCheckVO ncvo = cList.get(i);
							String bn_checknum = ncvo.getBn_checknum();
							bn_checknum = bn_checknum.substring(bn_checknum.length() - 4, bn_checknum.length());
							String bn_checkdate = ncvo.getBn_checkdate();
							//System.out.println("bn_checkdate >>> : " +  bn_checkdate);	
							bn_checkdate = bn_checkdate.substring(0,10);
							
					
		%>
		
								<tr>
									<td  align ="center" ><%= bn_checknum %></td>
									<td  align ="center" ><%= ncvo.getHm_name() %></td>
									<td  align ="center" ><%= ncvo.getHm_deptnum() %></td>
									<td  align ="center" ><%= bn_checkdate %></td>
								</tr>
						
		<%
		
						}
					}else{
		%>
							<tr><td colspan="4" align="center">해당 공지사항을 확인한 직원이 존재하지 않습니다.</tr>
		<%
							
					
					}
		%>
						
						</tbody>
	
					</table>
					
					<br>
					<div align = "center">
						<input align="middle" type="button" class="button" 
							   id="closeList" name="closeList" value="확인" 
							   style="width:60px;">
					</div>
					
					
				</div>
			</form>
         
         </div>

	</body>
</html>