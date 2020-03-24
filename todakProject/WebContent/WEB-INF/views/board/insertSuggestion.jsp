<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.board.controller.BoardController"  %>
<%@ page import="java142.todak.human.vo.MemberVO"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
		<meta charset="UTF-8">
		<title>건의사항 작성</title>
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="../include/js/common.js"></script>
		<script type="text/javascript" src="../webedit/dist/js/service/HuskyEZCreator.js" charset="utf-8"></script>
		<script type="text/javascript">
		var oEditors = [];
		 $(function(){
				//저장 버튼 클릭 시 처리 이벤트 
				nhn.husky.EZCreator.createInIFrame({
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
					
					fOnAppLoad : function() {
						//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
						oEditors.getById["bs_content"].exec("PASTE_HTML", [""]);
					},
					
					fCreator : "createSEditor2"
				});
				
				$("#insertSuggestion").click(function() {
					alert("글 작성하기");
					
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
						$("#n_writeForm").submit();
						
						
						var hm_empnum = $("#hm_empnum").val();
						alert("hm_empnum >>> : " + hm_empnum);
						$("#su_writeForm").attr({
							"method":"POST",
							"action":"../board/insertSuggestion.td"
						});
						
						$("#su_writeForm").submit();
					}
				});
				
		 		$("#selectSuggestion").click(function(){
		 			alert("(log)목록으로 돌아가기");
		 			var hm_empnum = $("#hm_empnum").val();
		 			$("#hm_empnum").val(hm_empnum);
		 			
		 			$("#su_writeForm")
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
         
         <div class="context-container">
	         	
	<%
				 String hm_empnum = sManager.getUserID(session.getId());
	
	%>
			<h3><b>글쓰기</b></h3>
			<hr>
			<br><br>
			<div align = "center">
				<form id="su_writeForm" name="su_writeForm" enctype="multipart/form-data" type="post">
					<table id="boardWrite" >
						<tr>
							<td>글제목</td>
							<td><input type="text" name="bs_title" id="bs_title" size="80"></td>
							<td><input type="hidden" name="hm_empnum" id="hm_empnum" value="<%=hm_empnum %>"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td height="200" width="800">
							<textarea name="bs_content" id="bs_content" rows="10" cols="70"></textarea></td>
						</tr>
						<tr>
							<td>첨부파일</td>
							<td><input type="file" name="bs_image" id="bs_image"></td>
						</tr>
					</table>
					<table align = "center">
						<tr align="right">

								<input align = "right" type="button" value="저장" class="but" id="insertSuggestion" name="insertSuggestion" />
								&nbsp; &nbsp;
								<input align = "right" type="button" value="목록" class="but" id="selectSuggestion" name="selectSuggestion"/>		

						</tr>
					</table>
						
				</form>
			</div>
         </div>
	</body>
</html>