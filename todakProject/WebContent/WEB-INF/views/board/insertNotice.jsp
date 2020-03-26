<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java142.todak.board.vo.NoticeVO"  %>
<%@ page import="java142.todak.human.vo.MemberVO"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html >
	<html>
	<head>
		<meta charset="UTF-8">
		<title>글쓰기 화면</title>
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="../webedit/dist/js/service/HuskyEZCreator.js" charset="utf-8"></script>
		<script type="text/javascript">
		var oEditors = [];
		 $(function(){
				//저장 버튼 클릭 시 처리 이벤트 
				nhn.husky.EZCreator.createInIFrame({
					oAppRef : oEditors,
					elPlaceHolder : "bn_content", //textarea에서 지정한 id와 일치해야 합니다. 
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
						oEditors.getById["bn_content"].exec("PASTE_HTML", [""]);
					},
					
					fCreator : "createSEditor2"
				});
				
				$("#insertNotice").click(function() {
					alert("글 작성하기");
					
			        var bn_content = oEditors.getById['bn_content'].getIR();
			        var checkarr = ['<p>&nbsp;</p>','&nbsp;','<p><br></p>','<p></p>','<br>'];
			        if(jQuery.inArray(bn_content.toLowerCase(), checkarr) != -1){
			            alert("내용을 입력해 주십시오.");
			            oEditors.getById["bn_content"].exec('FOCUS');
			            return false;
			        }

					if(!$("#bn_title").val()) {
						console.log("if(!$('#bn_title').val())");
						alert("제목을 입력하세요");
						$("#bn_title").focus();
						return false;
						}

					
					else{
						var ext1 = $('#bn_image').val().split('.').pop().toLowerCase();
						if(ext1){
							if(jQuery.inArray(ext1,['gif','png','jpg','jpeg']) == -1 ) {
		                        alert('gif,png,jpg,jpeg 사진만 업로드 할 수 있습니다');
								return false;
							}
						}
						 
						 var ext2 = $('#bn_file').val().split('.').pop().toLowerCase();
						 if(ext2){
							 if(jQuery.inArray(ext2,['hwp','pdf','doc','xlsx','xls','xml']) == -1 ) {
	                           alert('hwp,pdf,doc,xlsx,xls,xml 파일만 업로드 할 수 있습니다');
								return false;
							}
						 }
						
						oEditors.getById["bn_content"].exec("UPDATE_CONTENTS_FIELD", []);
						$("#n_writeForm").submit();
						
						//공개범위 조정하기
						var rangeIndex = $("#rangeIndex").val();
						
						if(rangeIndex == 98){
							alert("전체공개 rangeIndex >>> " + rangeIndex);
							$("#bn_deptnum").val(rangeIndex);
							$("#bn_divnum").val(rangeIndex);
						}else{
							if(rangeIndex <= 3){
								alert("본부공개 rangeIndex >>> " + rangeIndex);
								$("#bn_deptnum").val("98");
								$("#bn_divnum").val(rangeIndex);
							}else{
								alert("3. rangeIndex >>> " + rangeIndex);
								$("#bn_deptnum").val(rangeIndex);
								
								if(rangeIndex < 7) $("#bn_divnum").val("00")
								else if(rangeIndex < 10) $("#bn_divnum").val("01"); 
								else if(rangeIndex < 11) $("#bn_divnum").val("02"); 
								else if(rangeIndex < 12) $("#bn_divnum").val("03");
								else if(rangeIndex < 17) $("#bn_divnum").val("98");
							}
						}

						
						
						var hm_empnum = $("#hm_empnum").val();
						alert("hm_empnum >>> : " + hm_empnum);
						$("#n_writeForm").attr({
							"method":"POST",
							"action":"../board/insertNotice.td"
						});
						
						$("#n_writeForm").submit();
					}
				});
				
		 		$("#selectNotice").click(function(){
		 			alert("(log)목록으로 돌아가기");
		 			var hm_empnum = $("#hm_empnum").val();
		 			$("#hm_empnum").val(hm_empnum);
		 			
		 			$("#n_writeForm")
		 			.attr("action","../board/selectNotice.td")
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
				 Object obj =  request.getAttribute("mList");
				 ArrayList<MemberVO> mvo = (ArrayList<MemberVO>)obj;
				 
				 String hm_duty = mvo.get(0).getHm_duty();
				 String hm_deptnum = mvo.get(0).getHm_deptnum();
			     String hm_name = mvo.get(0).getHm_name();
				 
				 String hm_empnum = sManager.getUserID(session.getId());
				 //System.out.println( hm_duty + hm_empnum + hm_deptnum + hm_name);
	
	%>
			<div id="boardTit" align = "center"><h3>글쓰기</h3></div>
			<div align = "center">
				<form id="n_writeForm" name="n_writeForm" enctype="multipart/form-data">
					<table id="boardWrite" >
						<tr>
							<td>작성자</td>
							<td><input type="text" name="hm_name" id="hm_name" value="<%=hm_name%>" readonly>
							<input type="hidden" name="hm_duty" id="hm_duty" value="<%=hm_duty %>">
							<input type="hidden" name="hm_deptnum" id="hm_deptnum" value="<%=hm_deptnum %>">
							<input type="hidden" name="hm_empnum" id="hm_empnum" value="<%=hm_empnum %>">
							</td>
							
							<td align="right">
								<label>게시글 공개 범위</label>
								<select id="rangeIndex" name="rangeIndex">
									<option value="98">전체공지</option>
									<option value="00" style="font-weight:bold">경영지원본부</option>
									<option value="04">인재경영팀</option>
									<option value="05">재무팀</option>
									<option value="06">관리팀</option>
									<option value="01" style="font-weight:bold">전략기획본부</option>
									<option value="07">기획팀</option>
									<option value="08">소통협력팀</option>
									<option value="09">IT팀</option>
									<option value="02" style="font-weight:bold">마케팅본부</option>
									<option value="10">홍보팀</option>
									<option value="03" style="font-weight:bold">나눔사업본부</option>
									<option value="11">배분팀</option>
									<option value="12">혁신사업팀</option>
								</select>
								<input type="hidden" name="bn_divnum" id="bn_divnum" >
								<input type="hidden" name="bn_deptnum" id="bn_deptnum" >
							</td>
						</tr>
						<tr>
							<td>글제목</td>
							<td><input type="text" name="bn_title" id="bn_title" size="80"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td height="200" width="800">
							<textarea name="bn_content" id="bn_content" rows="10" cols="70"></textarea></td>
						</tr>
						<tr>
							<td>이미지</td>
							<td><input type="file" name="bn_image" id="bn_image"></td>
						</tr>
						<tr>
							<td>첨부파일</td>
							<td><input type="file" name="bn_file" id="bn_file"></td>
						</tr>
					</table>
						<input align = "right" type="button" value="저장" class="but" id="insertNotice" name="insertNotice" />
						<input align = "right" type="button" value="목록" class="but" id="selectNotice" name="selectNotice"/>
				</form>
			</div>
         </div>
	</body>
</html>