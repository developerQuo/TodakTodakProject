<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java142.todak.board.controller.BoardController"  %>
<%@ page import="java142.todak.common.FileReadUtil"  %>
<%@ page import="java142.todak.board.vo.SuggestionVO"  %>
<%@ page import="java.util.ArrayList"  %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta charset="UTF-8"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0, 
                              maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
      <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
      <title>댓글</title>
      <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
      <script   type="text/javascript">
      $(function(){
         /*기본 덧글 목록 불러오가*/
         var bs_num = $("#bs_num").val();
         
         var n_hm_empnum = $("#n_hm_empnum").val();
         
          
         listAll(bs_num);
         
         /*덧글 내용 저장 이벤트*/
         $("#replyInsert").click(function(){
            //작성자 이름에 대한 입력여부 검사
            
            if(!$("#bsr_content").val()) {
               alert("내용을 입력하세요");
               $("#bsr_content").focus();
               return false;
            }else{
               
               var insertUrl = "/board/replyInsert.td";
                  /*글 저장을 위한 Post방식의 Ajax 연동 처리*/
                  $.ajax({
                     url:insertUrl, //전송 url
                     type:"post",
                     headers : {"Content-Type" : "application/json",
                              "X-HTTP-Method-Override" : "POST"   
                     },
                     dataType:"text",
                     data : JSON.stringify({
                        bs_num:bs_num,
                        hm_empnum:n_hm_empnum,
                        bsr_content:$("#bsr_content").val()
                     
                     }),
                     
                     error : function(){ //실행 시 오류가 발생하였을 경우
                        alert("시스템 오류 발생, 관리자에게 문의하세요");
                        
                     },
                     
                     success : function(resultData){
                        if(resultData == "SUCCESS"){
                           alert("댓글 등록이 완료되었습니다");
                           dataReset();
                           listAll(bs_num);
                        }
                     }
                  });
               }
            });
         
         /*수정 버튼 클릭시 수정 폼 출력*/
         $(document).on("click", ".update_form", function(){
            $(".reset_btn").click();
            var conText = $(this).parents("li").children().eq(1).html();
            console.log("conText: " + conText);
            
            $(this).parents("li").find("input[type='button']").hide();
            $(this).parents("li").children().eq(0).html();
            
            var conArea = $(this).parents("li").children().eq(1);
            conArea.html("");
            
            var data="<textarea name='content' id='content' cols=60' rows='3'>"+conText+"</textarea>";
            data+="<input type='button' class='update_btn' value='수정완료' style='float:right;'>";
            data+="<input type='button' class='reset_btn' value='수정취소' style='float:right;'>";
            conArea.html(data);
            
         });
         
         /*초기화 버튼*/
         $(document).on("click",".reset_btn",function(){
            var conText = $(this).parents("li").find("textarea").html();
            $(this).parents("li").find("input[type='button']").show();
            var conArea = $(this).parents("li").children().eq(1);
            conArea.html(conText);
         });
         
         /*글 수정을 위한 Ajax 연동 처리 */
         $(document).on("click",".update_btn",function(){
            var bsr_num = $(this).parents("li").attr("data-num");
            var bsr_content =  $("#content").val();
            if(!$("#content").val()) {
               alert("댓글 내용을 입력하세요");
               $("#bsr_content").focus();
               return false;
            }else{
               $.ajax({
                  url:'/board/update/' +  bsr_num + ".td",
                  type:'put',
                  headers:{
                        "Content-Type" : "application/json",
                        "X-HTTP-Method-Override" : "PUT"},
                        data:JSON.stringify({
                           bsr_content:bsr_content,
                           hm_empnum:n_hm_empnum}),
                        dataType:'text',
                        success:function(result){
                           console.log("result: " + result);
                           if(result == 'SUCCESS'){
                              alert("수정 되었습니다");
                              listAll(bs_num);
                           }else if(result == 'FAIL'){
                               alert("댓글을 수정할 권한이 없습니다.");
                               listAll(bs_num);
                           }
                        }
                     });
                  }
               });
         
         /*글 삭제를 위한 Ajax 연동 처리 */
         $(document).on("click", ".delete_btn", function(){
            var bsr_num = $(this).parents("li").attr("data-num");
            $.ajax({
               url:'/board/delete/' +  bsr_num + ".td",
               type:'put',
               headers:{
                     "Content-Type" : "application/json",
                     "X-HTTP-Method-Override" : "PUT"},
                     data:JSON.stringify({
                        bsr_num:bsr_num,
                        hm_empnum:n_hm_empnum}),
                     dataType:'text',
                     success:function(result){
                        console.log("result: " + result);
                        if(result == 'SUCCESS'){
                           alert("삭제되었습니다");
                           listAll(bs_num);
                        }else if(result == 'FAIL'){
                            alert("댓글을 삭제할 권한이 없습니다.");
                            listAll(bs_num);
                        }
                     }
                  });
            });
      });//end of function

      //리스트 요청 함수
      function listAll(bs_num){
         $("#comment_list").html("");
         var url = "/board/all/" + bs_num + ".td";
         $.getJSON(url, function(data){
            console.log(data.length);
            
            $(data).each(function(){
               var bsr_num = this.bsr_num;
               var hm_empnum = this.hm_empnum;
               var bsr_content = this.bsr_content;
               var bsr_insertdate = this.bsr_insertdate
               addNewItem(bsr_num,hm_empnum,bsr_content,bsr_insertdate);
            });
            
         }).fail(function(){
            alert("덧글 목록을 불러오는데 실패, 잠시 후 다시 시도해주세용");
         });
      }//end of listAll
      
      /*새로운 글을 화면에 추가하기 위한 함수*/
      function addNewItem(bsr_num,hm_empnum,bsr_content,bsr_insertdate){
         //새로운 글이 추가될 li 태그 객체
         var new_li = $("<li>");
         new_li.attr("data-num", bsr_num);
         new_li.addClass("comment_item");
         
         //작성자 정보가 지정될 <p>태그
         var writer_p =$("<p>");
         writer_p.addClass("writer");
         
         //작성일시
         var date_span = $("<span>");
         date_span.html(bsr_insertdate.substr(0,10) + " ");
   
         //수정하기 버튼
         var up_input = $("<input>");
         up_input.attr({"type" : "button", "value" : "수정하기", "class" : "button", "style" : "float:right;"});
         up_input.addClass("update_form");
         
         //삭제하기 버튼
         var del_input = $("<input>");
         del_input.attr({"type" : "button", "value": "삭제하기", "class" : "button", "style" : "float:right;"});
         del_input.addClass("delete_btn");
         
         //내용
         var content_p = $("<p>");
         content_p.addClass("con");
         content_p.html(bsr_content);
         
         //조립하기
         writer_p.append(date_span).append(up_input).append(del_input)
         new_li.append(writer_p).append(content_p);
         $("#comment_list").append(new_li);
      }
      
      /*input 태그들에 대한 초기화 함수*/
      function dataReset(){
         $("#bsr_content").val("");
      }
      

      
      </script>
   </head>
   <body>   
      <div id="replyContainer" align="center">
         <h1></h1>
         <div class="reply" id="comment_form" align="center">
            <div>
            	<table class="reply_table">
            		<colgroup>
						<col width="30%"/>
						<col width="40%"/>
						<col width="30%"/>
					</colgroup>
            		<tr>
            			<td align="center">
                  			<label for="bsr_content">댓글내용</label>
                  		</td>
                  		<td align="center">
                 	 		<textarea name="bsr_content" id="bsr_content" cols="60" rows="3"></textarea>
                 	 	</td>
                 	 	<td align="center">
                  			<input type="button" class="button" id="replyInsert" 
                  				   value="저장하기" style="width:70px;height:70px;"/>
                  		</td>
                  	</tr>
            	</table>
            	<br><br>
            </div>
   		      	<div class="reply" align="center">
            		<ul class="reply" id="comment_list"></ul>
         		</div>
         </div>
         
         <br><br>
         
      </div>
   </body>
</html>