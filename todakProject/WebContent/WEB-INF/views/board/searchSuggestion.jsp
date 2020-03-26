<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java142.todak.board.controller.BoardController"  %>
<%@ page import="java142.todak.common.FileReadUtil"  %>
<%@ page import="java142.todak.board.vo.SuggestionVO"  %>
<%@ page import="java142.todak.board.vo.SuLikeVO"  %>
<%@ page import="java.util.ArrayList"  %>

<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>건의사항 상세보기</title>
		
		<link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script	type="text/javascript">
		$(document).ready(function(){
			
			var bs_num = $("#bs_num").val();
			countLike(bs_num);
			countDislike(bs_num)
			
	        var bsl_likeYN = $("#bsl_likeYN").val();
	        beforeCheck(bsl_likeYN);
	        
	        var bsl_dislikeYN = $("#bsl_dislikeYN").val();
	        beforeDisCheck(bsl_dislikeYN);
	        
			$("#fileDown").click(function(){
	            var bs_image = $("#bs_image").val();               
	            $("#bs_image").val(bs_image);
	            $("#searchSuggestion")
	            .attr("action","../board/downloadSuggestion.td")
	            .submit();
	         });
			
			
			$("#updateSuggestion").click(function(){
	            var bs_num = $("#bs_num").val();               
	            $("#bs_num").val(bs_num);

	            $("#searchSuggestion")
	            .attr("action","../board/moveUpdateSuggestion.td")
	            .submit();
	         });
			
	 		$("#deleteSuggestion").click(function(){
	 			var bs_num = $("#bs_num").val();
	 			$("#bs_num").val(bs_num);
	 			$("#searchSuggestion")
	 			.attr("action","../board/deleteSuggestion.td")
	            .submit();
	 		});
	 		
	 		$("#selectSuggestion").click(function(){
	 			var hm_empnum = $("#hm_empnum").val();
	 			$("#hm_empnum").val(hm_empnum);
	 			
	 			$("#searchSuggestion")
	 			.attr("action","../board/selectSuggestion.td")
	            .submit();
	 		});
	 		
			//좋아요 미리 표시하기
	        function beforeCheck(bsl_likeYN){
		        if(bsl_likeYN == 1) {
		            $("#like").prop("src", "../resources/like.png");
		        }else{
		            $("#like").prop("src", "../resources/unLike.png");
		        }
	        }
			


	        //좋아요 갯수세기
	        function countLike(bs_num){
	        	
	        	var countLike = $("countLike");
	        	
  	        	$.ajax({
	        		url : '../board/countSuLike.td',
	        		type : 'post',
	        		headers : {"Content-Type" : "application/json",
                        "X-HTTP-Method-Override" : "POST"   
          			},	
          			dataType : 'text',
          			data : JSON.stringify({
          				bs_num : $("#bs_num").val()
          			}),
          			
                    error : function(){ //실행 시 오류가 발생하였을 경우
                        alert("시스템 오류 발생, 관리자에게 문의하세요");
                        
                     },
                     
	                success : function(data){
	                    if(data >= 0) {
	                    	 $("#likeCount").html(data);

	                    }else{
	                        alert("추천수를 불러오는데 오류가 발생함");
	                    }
	                }
	        	});
	        
	        }
	       
	        
	        //좋아요 눌렀을때
	        $(".like").on("click", function () {
	            var that = $(".like");

	            $.ajax({
	                url :'../board/checkLike.td',
	                type :'POST',
	                headers : {"Content-Type" : "application/json",
                        "X-HTTP-Method-Override" : "POST"   
              			},	
                        dataType:"text",
                        data : JSON.stringify({
                        	bs_num : $("#bs_num").val() ,
                        	hm_empnum : $("#n_hm_empnum").val()
                        }),
                
                     error : function(){ //실행 시 오류가 발생하였을 경우
                         alert("시스템 오류 발생, 관리자에게 문의하세요");
                         
                      },
                      
	                success : function(data){
	                    that.prop('bs_num',data);
	                    if(data==1) {
	                        $('#like').prop("src","../resources/like.png");
	                        countLike(bs_num)
	                    }
	                    else{
	                        $('#like').prop("src","../resources/unLike.png");
	                        countLike(bs_num)
	                    }


	                }
	            });
	        });
	        
	        
			//비추 미리 표시하기
	        function beforeDisCheck(bsl_dislikeYN){
		        if(bsl_dislikeYN == 1) {
		            $("#dislike").prop("src", "../resources/dislike.png");
		        }else{
		            $("#dislike").prop("src", "../resources/unDislike.png");
		        }
	        }
			
	        //비추 갯수세기
	        function countDislike(bs_num){
	        	
	        	var countDislike = $("countDislike");
	        	
  	        	$.ajax({
	        		url : '../board/countSuDislike.td',
	        		type : 'post',
	        		headers : {"Content-Type" : "application/json",
                        "X-HTTP-Method-Override" : "POST"   
          			},	
          			dataType : 'text',
          			data : JSON.stringify({
          				bs_num : $("#bs_num").val()
          			}),
          			
                    error : function(){ //실행 시 오류가 발생하였을 경우
                        alert("시스템 오류 발생, 관리자에게 문의하세요");
                        
                     },
                     
	                success : function(data){
	                    if(data >= 0) {
	                    	 $("#dislikeCount").html(data);

	                    }else{
	                        alert("추천수를 불러오는데 오류가 발생함");
	                    }
	                }
	        	});
	        
	        }
	        
	        //비추 눌렀을때
	        $(".dislike").on("click", function () {
	            var that = $(".dislike");

	            $.ajax({
	                url :'../board/checkSuDislike.td',
	                type :'POST',
	                headers : {"Content-Type" : "application/json",
                        "X-HTTP-Method-Override" : "POST"   
              			},	
                        dataType:"text",
                        data : JSON.stringify({
                        	bs_num : $("#bs_num").val() ,
                        	hm_empnum : $("#n_hm_empnum").val()
                        }),
                
                     error : function(){ //실행 시 오류가 발생하였을 경우
                         alert("시스템 오류 발생, 관리자에게 문의하세요");
                         
                      },
                      
	                success : function(data){
	                    that.prop('bs_num',data);
	                    if(data==1) {
	                        $('#dislike').prop("src","../resources/dislike.png");
	                        countDislike(bs_num)
	                    }
	                    else{
	                        $('#dislike').prop("src","../resources/unDislike.png");
	                        countDislike(bs_num)
	                    }


	                }
	            });
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
         	<h3><b>건의사항</b></h3>
	  		<hr><br><br>
	         
	<%
			//n_hm_empnum는 현재 글을 보고 있는 사람의 empnum!
			String n_hm_empnum = sManager.getUserID(session.getId());
	
	  		Object obj = request.getAttribute("suggestionDetail");
			ArrayList<SuggestionVO> sList = (ArrayList<SuggestionVO>)obj;
			
			SuggestionVO svo = sList.get(0);
			String i_hm_empnum = svo.getHm_empnum();
	
			//System.out.println(n_hm_empnum + " : " + i_hm_empnum);
			
			String bsl_likeYN = (String)request.getAttribute("bsl_likeYN");
			String bsl_dislikeYN = (String)request.getAttribute("bsl_dislikeYN");
			
	%>
			<div class="suggestionsearch_div">
				<form name="searchSuggestion" id="searchSuggestion">
					<input type="hidden" id="bsl_likeYN" name="bsl_likeYN" value="<%=bsl_likeYN %>">
					<input type="hidden" id="bsl_dislikeYN" name="bsl_dislikeYN" value="<%=bsl_dislikeYN %>">
					<input type="hidden" id="bs_image" name="bs_image" value="<%=svo.getBs_image() %>">
					<input type="hidden" id="bs_num" name="bs_num" value="<%=svo.getBs_num() %>">
					<input type="hidden" id="hm_empnum" name="hm_empnum" value="<%=i_hm_empnum %>">
					<input type="hidden" id="n_hm_empnum" name="n_hm_empnum" value="<%=n_hm_empnum %>">
					<div align="center" id="searchNotice">
						<table class="suggestion_search">
							<colgroup>
								<col width="28%"/>
								<col width="28%"/>
								<col width="28%"/>
								<col width="16%"/>
							</colgroup>
								<tbody>
								<tr>
									<td class="ac" style="border-right:2px solid #eeeeee;" align="center"><b>작성일</b></td>
									<td style="border-right:2px solid #eeeeee;"><%=svo.getBs_insertdate().substring(0,10) %></td>
									<td class="ac" style="border-right:2px solid #eeeeee;" align="center"><b>조회수</b></td>
									<td class="ac" ><%=svo.getBs_hitnum() %></td>
								</tr>
								<tr>
									<td class="ac" class="ac" style="border-right:2px solid #eeeeee;" align="center"><b>제목</b></td>
									<td colspan="4"><%=svo.getBs_title() %></td>
								</tr>
								<tr class="ctr">
									<td class="ac" class="ac" style="border-right:2px solid #eeeeee;" align="center"><b>내용</b></td>
									<td colspan="4">
										<div style="min-height:300px;">
											<%=svo.getBs_content() %>
										</div>
									</td>
								</tr>
	<%
							String bs_image = svo.getBs_image();
							if(bs_image != null && bs_image.length() != 0){
	%>
			
							<tr class="ctr">
								<td class="ac" style="border-right:2px solid #eeeeee;" align="center"><b>첨부사진</b></td>
								<td><img src="../<%=svo.getBs_image() %>" border=0></td>					
								<td align="center">
									<input type="button" class="button" id="fileDown" 
										   name="fileDown" value="이미지 다운로드">
								</td>
							</tr>
	<%
							}
	%>
		
							</tbody>
						</table>
						</div>
	
				</form>
				<form id="like_form">
					<div style="text-align: right;" align="center">
			            <table id="likeTable" align="center">
			                <tr>
				                <td><span id="likeCount"></span></td>
				                <td><a class="btn btn-outline-dark like"><img id="like" src="" width="30" ></a></td>
				                <td><a class="btn btn-outline-dark dislike"><img id="dislike" src="" width="30" ></a></td>
				             	<td><span id="dislikeCount"></span></td>
			             	</tr>
			            </table>
		              </div>
		         </form>
	<%
				if(i_hm_empnum.equals(n_hm_empnum)|| n_hm_empnum.equals("H000000000000")){
		
	%>
						
						<br>
						<div class="suggestionsearch_align" align="center">
							<input align="right" type="button" value="수정" class="button" id="updateSuggestion" name="updateSuggestion"/>
							<input align="right" type="button" value="삭제" class="button" id="deleteSuggestion" name="deleteSuggestion"/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input align="right" type="button" value="목록" class="button" id="selectSuggestion" name="selectSuggestion" style="width:60px;"/>
						</div>
	<%
				}else{
	%>
						
						<br>					
						<div class="suggestionsearch_align" align="right">
							<input type="button" value="목록" class="button" id="selectSuggestion" name="selectSuggestion" style="width:60px;"/>
						</div>
	<%
				}
	%>
	
	           <br><br>
	           <jsp:include page="replySuggestion.jsp"></jsp:include>
           </div>
         </div>
	</body>
</html>