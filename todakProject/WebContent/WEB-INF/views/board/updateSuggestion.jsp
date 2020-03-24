<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java142.todak.board.controller.BoardController"  %>
<%@ page import="java142.todak.board.vo.SuggestionVO"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
		<meta charset="UTF-8">
		<title>건의사항 수정하기</title>
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="../include/js/common.js"></script>
		<script type="text/javascript" src="../webedit/dist/js/service/HuskyEZCreator.js" charset="utf-8"></script>
		<script type="text/javascript">
		var oEditors = [];
		 $(function(){
				//저장 버튼 클릭 시 처리 이벤트 
				nhn.husky.EZCreator.createInIFrame({
					fOnAppLoad : function() {
						//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
						oEditors.getById["bs_content"].exec("PASTE_HTML", [""]);
					},
					oAppRef : oEditors,
					elPlaceHolder : "bs_content", //textarea에서 지정한 id와 일치해야 합니다. 
					//SmartEditor2Skin.html 파일이 존재하는 경로
					sSkinURI : "../webedit/dist/SmartEditor2Skin.html",
					htParams : {
						// 툴바 사용 여부 (true:사용/ false:사용하지 않음),글씨체 포인트,정렬,색상등등
						bUseToolbar : true,
						// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseVerticalResizer : true,
						// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
						bUseModeChanger : true,
						fOnBeforeUnload : function() {
						}
					},
					fCreator : "createSEditor2"
				});
				
				
				
		 		$("#deleteSuggestion").click(function(){
		 			alert("글 삭제하기");
		 			var bs_num = $("#bs_num").val();
		 			$("#bs_num").val(bs_num);
		 			
		 			var hm_empnum = $("#hm_empnum").val();
		 			$("#hm_empnum").val(hm_empnum);

		 			$("#s_updateForm").attr({
		 				"method":"post",
		 				"action":"../board/deleteSuggestion.td"
		 			});
		 			
		 			$("#s_updateForm").submit();
		 		});
		 		
				$("#updateSuggestion").click(function() {
					alert("글 수정하기");
					
			        var bs_content = oEditors.getById['bs_content'].getIR();
			        var checkarr = ['<p>&nbsp;</p>','&nbsp;','<p><br></p>','<p></p>','<br>'];
			        if(jQuery.inArray(bs_content.toLowerCase(), checkarr) != -1){
			            alert("내용을 입력해 주십시오.");
			            oEditors.getById["bs_content"].exec('FOCUS');
			            return false;
			        }

					if(!$("#bs_title").val()) {
						console.log("if(!$('#bs_title').val())");
						alert("제목을 입력하세요");
						$("#bs_title").focus();
						return false;
						}

					
					else{
						var ext1 = $('#bs_image').val().split('.').pop().toLowerCase();
						if(ext1){
							if(jQuery.inArray(ext1,['gif','png','jpg','jpeg']) == -1 ) {
		                        alert('gif,png,jpg,jpeg 사진만 업로드 할 수 있습니다');
								return false;
							}
						}
						
						oEditors.getById["bs_content"].exec("UPDATE_CONTENTS_FIELD", []);
						$("#s_updateForm").submit();
						
						
						var hm_empnum = $("#hm_empnum").val();
						alert("hm_empnum >>> : " + hm_empnum);
						$("#s_updateForm").attr({
							"method":"POST",
							"action":"../board/updateSuggestion.td"
						});
						
						$("#s_updateForm").submit();
					}
				});
				
		 		$("#selectSuggestion").click(function(){
		 			alert("(log)목록으로 돌아가기");
		 			var hm_empnum = $("#hm_empnum").val();
		 			$("#hm_empnum").val(hm_empnum);
		 			
		 			$("#s_updateForm")
		 			.attr("action","../board/selectSuggestion.td")
		            .submit();
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
				 String hm_empnum = sManager.getUserID(session.getId());
	
				ArrayList<SuggestionVO> sList = (ArrayList<SuggestionVO>)request.getAttribute("updateList");
				SuggestionVO svo = sList.get(0);
	
	%>
			<div id="boardTit" align = "center"><h3>글쓰기</h3></div>
			<div align = "center">
				<form id="s_updateForm" name="s_updateForm" enctype="multipart/form-data" type="post">
					<div>
						<td><input type="hidden" name="hm_empnum" id="hm_empnum" value="<%=hm_empnum %>"></td>
						<td><input type="hidden" name="bs_num" id="bs_num" value="<%=svo.getBs_num() %>"></td>
					</div>
					<table id="boardWrite" >
						<tr>
							<td>글제목</td>
							<td><input type="text" name="bs_title" id="bs_title" size="80" value="<%=svo.getBs_title()%>"></td>
							
						</tr>
						<tr>
							<td>내용</td>
							<td height="200" width="800">
							<textarea name="bs_content" id="bs_content" rows="10" cols="70"><%=svo.getBs_content()%></textarea></td>
						</tr>
<%
					String bs_image = svo.getBs_image(); 
					if(bs_image != null){
	
%>
						<tr>
							<td>이미지</td>
							<td><img src="../<%=bs_image%>">
							<input type="file" name="bs_image" id="bs_image" value="<%=svo.getBs_image()%>"></td>
						</tr>
<%
					}else{
%>
						<tr>
							<td>이미지</td>
							<td><input type="file" name="bs_image" id="bs_image"></td>
						</tr>
<%
					}
%>
					</table>
					<table align = "center">
						<tr align="right">
							<div align="center">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" value="수정" class="but" id="updateSuggestion" name="updateSuggestion"/>
								<input type="button" value="삭제" class="but" id="deleteSuggestion" name="deleteSuggestion"/>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" value="목록" class="but" id="selectSuggestion" name="selectSuggestion"/>
							</div>
						</tr>
					</table>
						
				</form>
			</div>
         </div>
	</body>
</html>