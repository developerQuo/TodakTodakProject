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
      <title>공지사항 상세보기</title>
      
      <link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
      
      <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
      <script   type="text/javascript">
      $(document).ready(function(){
         $("#fileDown").click(function(){
               console.log("(log)파일 다운로드");
               
               var bn_file = $("#bn_file").val();               
               $("#bn_file").val(bn_file);
               console.log("bn_file >>> : " + bn_file);
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
             $("#searchNotice")
             .attr("action","../board/deleteNotice.td")
               .submit();
          });
         $("#checkNotice").click(function(){
               var bn_num = $("#bn_num").val();               
               $("#bn_num").val(bn_num);
               
             var n_hm_empnum = $("#n_hm_empnum").val();
             $("#hm_empnum").val(n_hm_empnum);
			
         	var windowW = 480;  // 창의 가로 길이
	        var windowH = 280;  // 창의 세로 길이
	        var left = Math.ceil((window.screen.width - windowW)/2);
	        var top = Math.ceil((window.screen.height - windowH)/2);
	        
            window.open("", "pop", "l top="+top+", left="+left+", height="+windowH+", width="+windowW);
            $("#searchNotice").attr("action", "../board/moveCheckNotice.td");
            $("#searchNotice").attr("target","pop");
            $("#searchNotice").submit();
            
            location.reload();
            });
         
         $("#checkList").click(function(){

             var n_hm_empnum = $("#n_hm_empnum").val();
             $("#hm_empnum").val(n_hm_empnum);
             var windowW = 600;  // 창의 가로 길이
 	         var windowH = 280;  // 창의 세로 길이
 	         
 	         var left = Math.ceil((window.screen.width - windowW)/2);
 	         var top = Math.ceil((window.screen.height - windowH)/2);
 	         
            window.open("", "pop", "l top="+top+", left="+left+", height="+windowH+", width="+windowW);
            $("#searchNotice").attr("action", "../board/checkList.td");
            $("#searchNotice").attr("target","pop");
            $("#searchNotice").submit();
            
            location.reload();
                        });
          
          $("#selectNotice").click(function(){
             var n_hm_empnum = $("#n_hm_empnum").val();
             $("#hm_empnum").val(n_hm_empnum);
             
             $("#searchNotice").attr({
                "method" : "post",
                 "action" : "../board/selectNotice.td"
                
             });
   
             $("#searchNotice").submit();
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
           <h3><b>공지사항</b></h3>
           <hr><br><br>
            
   <%
         //n_hm_empnum는 현재 글을 보고 있는 사람의 empnum!
         String n_hm_empnum = sManager.getUserID(session.getId());
   
           Object obj = request.getAttribute("noticeSearchList");
         ArrayList<NoticeVO> sList = (ArrayList<NoticeVO>)obj;
         
         NoticeVO nvo = sList.get(0);
         String i_hm_empnum = nvo.getHm_empnum();
   
         //System.out.println(n_hm_empnum + " : " + i_hm_empnum);
   %>
         
         
         
         <form name="searchNotice" id="searchNotice">
            <input type="hidden" id="bn_file" name="bn_file" value="<%=nvo.getBn_file() %>">
            <input type="hidden" id="bn_num" name="bn_num" value="<%=nvo.getBn_num() %>">
            <input type="hidden" id="hm_empnum" name="hm_empnum" value="<%=i_hm_empnum %>">
            <input type="hidden" id="n_hm_empnum" name="n_hm_empnum" value="<%=n_hm_empnum %>">
            <div class="noticesearch_div" align="center" id="searchNotice">
               <table class="notice_search">
                  <colgroup>
                     <col width="20%" />
                     <col width="20%" />
                     <col width="20%" />
                     <col width="20%" />
                     <col width="20%" />
                  </colgroup>
                  <tbody>
                  <tr>
                     <td class="ac" style="border-right:2px solid #eeeeee;" align="center"><b>작성자</b></td>
                     <td colspan="2" style="border-right:2px solid #eeeeee;"><%=nvo.getHm_name() %></td>
                     <td class="ac" style="border-right:2px solid #eeeeee;" align="center"><b>작성일</b></td>
                     <td><%=nvo.getBn_insertdate().substring(0,10) %></td>
                  </tr>
                  <tr>
                     <td class="ac" style="border-right:2px solid #eeeeee;" align="center"><b>제목</b></td>
                     <td colspan="2" style="border-right:2px solid #eeeeee;"><%=nvo.getBn_title() %></td>
                      <td class="ac" align="center" style="border-right:2px solid #eeeeee;"><b>조회수</b></td>
                     <td class="ac"><%=nvo.getBn_hitnum() %></td>
                  </tr>
                  <tr class="ctr">
                     <td class="ac" style="border-right:2px solid #eeeeee;" align="center"><b>내용</b></td>
                     <td colspan="4">
                        <div style="min-height:300px;">
                           <%=nvo.getBn_content() %>
                        </div>
                     </td>
                  </tr>
   <%
               String bn_image = nvo.getBn_image();
               if(bn_image != null && bn_image.length() != 0){
   %>
   
               <tr class="ctr">
                  <td class="ac" style="border-right:2px solid #eeeeee;" align="center"><b>첨부사진</b></td>
                  <td colspan="5"><img src="../<%=nvo.getBn_image() %>" border=0></td>               
               </tr>
   <%
               }
               
               String bn_file = nvo.getBn_file();
               
               if(bn_file != null && bn_file.length() != 0){
   %>
                  <tr class="ctr">
                     <td class="ac" style="border-right:2px solid #eeeeee;" align="center"><b>다운로드파일</b></td>
                     
                     <td colspan="4">
                        <%=bn_file %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" class="button" id="fileDown" name="fileDown" value="파일 다운로드">
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
   
               <br>
               <div class="noticesearch_align" align="right">
                  <input align="left" type="button" value="확인자리스트" class="button" id="checkList" name="checkList"/>
                  &nbsp;&nbsp;
                  <input align="right" type="button" value="수정" class="button" id="updateNotice" name="updateNotice" style="width:60px;"/>
                  &nbsp;&nbsp;
                  <input align="right" type="button" value="삭제" class="button" id="deleteNotice" name="deleteNotice" style="width:60px;"/>
                  &nbsp;&nbsp;
                  <input align="right" type="button" value="목록" class="button" id="selectNotice" name="selectNotice" style="width:60px;"/>
               </div>
   <%
         }else{
   %>
               <br>
               <div class="noticesearch_align" align="right">
                  <input type="button" value="확인" class="button" id="checkNotice" name="checkNotice" style="width:60px;"/>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="button" value="목록" class="button" id="selectNotice" name="selectNotice" style="width:60px;"/>
               </div>
   <%
         }
   %>
         </form>
         </div>
   </body>
</html>