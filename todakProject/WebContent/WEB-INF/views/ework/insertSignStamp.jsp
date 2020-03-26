<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<% 
	String user_id = sManager.getUserID(session.getId());
	//System.out.println(user_id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>서명 및 도장 등록</title>
		<link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
		<script type="text/javascript"
				src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
			var es_filedir = "";
		
			$(document).ready(function() {
				console.log("제이쿼리");
				
				$.ajax({
					type:"POST",
					url:"/eworkForm/selectSignStamp.td",
					data:{
						hm_empnum:"<%=user_id%>"
					},
					success:whenSuccess,
					error:whenError
				});
				
				$('#insert_button').click(function() {
					console.log("등록 버튼 클릭");
					
					var file = $('#file').val();
					console.log("file >>> : " + file);
					
					if(!file) {
						console.log("if(!file) 진입 >>> ");
					
						alert("파일을 선택해 주세요.");
						$('#file').focus();
						return;
						
					}
					
					var ext = $('#file').val().split('.').pop().toLowerCase();
 					if(jQuery.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
 						alert('gif, png, jpg, jpeg 파일만 업로드 할 수 있습니다');
 						return;
 					}
 					
 					$('#signstamp_form')
 					.attr("action", "/ework/insertSignStamp.td")
 					.submit();
 					
				});
				
				$('#file').change(function() {
					console.log("파일이름 textbox에 넣어주기");
					
					var file_dir = $('#file').val();
					console.log("file_dir >>> : " + file_dir);
					
					var start = file_dir.lastIndexOf("\\")+1;
					console.log("start >>> : " + start);
					var end = file_dir.length;
					console.log("end >>> : " + end);
					var file_name = file_dir.substring(start, end);
					console.log("file_name >>> : " + file_name);
					
					$('#file_name').attr("value",file_name);
					
				});
				
			});
			
			//-------------------- js --------------------
			
			function whenSuccess(data) {
				console.log("성공");
				
				console.log(data);
				es_filedir = $(data).find("filedir").text();
				console.log("es_filedir >>> : " + es_filedir);
				
				if(es_filedir == "") {
					console.log("if(es_filedir == '') 진입 >>> ");
					
					$('#img').attr("src", null);
					$('#image').attr("value", null);
					
				} else {
					console.log("if(es_filedir == '')-else 진입 >>> ");
					
					$('#img').attr("src", "..//" + es_filedir);
					$('#image').attr("value", "..//" + es_filedir);
					
				}
				
				console.log($('#image').val());
				
			}
			
			function whenError() {
				console.log("실패");
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
		
	        <h3><b>서명 및 도장</b></h3>
	        <hr>	
			<center>
			<br><br><br><br>
			<form id="signstamp_form" name="signstamp_form"
				  method="POST" enctype="multipart/form-data" >
			
				<table id="signstamp_table">
					<colgroup>
						<col width="150pt"/>
						<col width="350pt"/>
					</colgroup>
					<tbody>
						<tr>
							<td>사원번호</td>
							<td>
								<input type="text" id="hm_empnum" name="hm_empnum" value="<%=user_id %>" size="21">
							</td>
							<td rowspan="2">
								<div style="margin:15px; border:1px solid #c0c0c0;">
									<img id="img" alt="이미지를 등록하세요" width="100px" height="100px">
									<input type="hidden" id="image" name="image">
								</div>
							</td>
						</tr>
						<tr>
							<td>이미지 파일</td>
							<td>
								<input type="text" id="file_name" class="file_textbox" size="21" readonly>
								<input type="button" value="찾아보기" class="button" onclick="document.all.file.click();">
								<input type="file" id="file" name="file" style="display:none;">
							</td>
						</tr>
						<tr>
						<div id="eworkB">
							<td align="right" colspan="2">
								<input type="button" class="button" id="insert_button" 
									   name="insert_button" value=" 등록 "></td>
							<td></td>
						</div>
					</tr>
					</tbody>
				</table>
			
			</form>
			</center>
			
		</div>
	</body>
</html>