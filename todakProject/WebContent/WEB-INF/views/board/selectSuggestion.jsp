<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.board.controller.BoardController"  %>
<%@ page import="java142.todak.board.vo.SuggestionVO"  %>
<%@ page import="java142.todak.human.vo.MemberVO"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
<%
      
      //System.out.println(sManager.getUserID(session.getId()));
      String user_ID = sManager.getUserID(session.getId());

      Object obj = request.getAttribute("suggestionList");
      ArrayList<SuggestionVO> sList = (ArrayList<SuggestionVO>)obj;
      //System.out.println("sList.size() >>> : " + sList.size() );
      
      Object obj2 = request.getAttribute("i_svo");
      SuggestionVO pvo =(SuggestionVO) obj2; //pvo ==> pageVO

      String key = pvo.getKeyword();//검색을위한 변수 받아옵니다.
      String index = pvo.getFindIndex();//검색을 위한 변수 받아옵니다.
      
      String n_hm_empnum = user_ID;
      int Size = pvo.getPageSize();
      int pageSize = pvo.getPageSize();
      int groupSize = pvo.getGroupSize();
      int curPage = pvo.getCurPage();
      int totalCount = pvo.getTotalCount();
      
      
      if(request.getParameter("curPage") != null){
         curPage = Integer.parseInt(request.getParameter("curPage"));
      }


%>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>건의사항</title>
      <link href="/include/css/default.css" rel="stylesheet">	
      <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
      <script type="text/javascript">
      $(function(){
               if('<%=Size%>' > 0){
                  $("#pageCtrl").val('<%=Size %>');
               }
               
               $("#findIndex").change(function(){
                  if($("#findIndex").val()=="all"){
                     $("#keyword").val("전체목록을 조회");
                  }else if($("#findIndex").val()!="all"){
                     $("#keyword").val("");
                     $("#keyword").focus();
                  }
               });

               
               $("#pageCtrl").change(function(){
                  goPage(1);
               });
               
               
                $("#findSuggestion").click(function(){
                   var keyword = $("#keyword").val();
                   $("#keyword").val(keyword);

                   var findIndex = $("#findIndex").val();
                   $("#findIndex").val(findIndex);
                   
                   if(keyword == "검색어를 입력하세요" && keyword == "null"){
                      alert("검색어를 입력하세요");
                      return false;
                   }
                   gopage(1);
                });
                
               function goPage(page){
                  if($("#findIndex").val()=="all"){
                     $("#keyword").val("");
                  }
                  $("#page").val(page);
                   $("#su_search").attr({
                      "method":"get",
                      "action":"../board/selectSuggestion.td"
                   });
                   $("#su_search").submit();
               }
            
               $("#writeSuggestion").click(function(){
                  $("#searchForm").attr({
                     "method" : "post",
                     "action" : "../board/moveWriteSuggestion.td"
                  });
         
                  $("#searchForm").submit();
                  
               });
                $(".goSearch").click(function(){
                   var bs_num = $(this).parents("tr").attr("data");
                   
                   $("#bs_num").val(bs_num);
         
                   $("#searchForm").attr({
                      "method":"post",
                      "action":"../board/searchSuggestion.td"
                   });
                   
                   $("#searchForm").submit();
                });
                
                
                var selfCheck = $("input:checkbox[id='selectCheckForm']").is(":checked") ;
                $("#selectCheck").change(function(){
                   if($("#selectCheck").is(":checked") == true ) {
                      $("#selectCheckForm").attr({
                         "method":"post",
                         "action":"../board/selectSuggestion.td"
                      });
                      
                      $("#selectCheckForm").submit();

                   }else if($("#selectCheck").is(":checked") != true){
               
                      goPage(1);
                   }
                      
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
            <div id="boardContainer">
            <div id="boardTit"><h3><b>건의사항</b></h3></div>
            <hr>
               <form id="searchForm" name="searchForm" method="POST">
                  <input type="hidden" name="bs_num" id="bs_num">   
                  <input type="hidden" name="hm_empnum" id="hm_empnum" value="<%=user_ID%>">   
               </form>
      <%-- ==================체크박스 기능================== --%>
            <div class="table_align" align="right">
               <form id="selectCheckForm" name="selectCheckbox" method="POST">
                  <input type="hidden" name="hm_empnum" value="<%=user_ID%>">   
                  <input type="hidden" name="findIndex" value="hm_empnum" >
<%

               
                  String findIndex = (String)request.getAttribute("findIndex");
                  //System.out.println("findIndex >>> : " + findIndex);
                  if(findIndex==null){
%>
                     <input type="checkbox" id="selectCheck"   name="selectCheck">
                     <label for="selectCheck">작성한 게시글 보기</label>
<%
                  }else{

%>
                     <input type="checkbox" id="selectCheck"   name="selectCheck" checked="checked">
                     <label for="selectCheck">작성한 게시글 보기</label>
<%
                  }
%>
               </form>
            </div>

               <%-- ==================검색 기능 시작=================== --%>
               <div class="table_align" id="suggestionSearch">

                  <form id="su_search" name="su_search" align ="left">
                  
                        <table summary ="검색">
                           <colgroup>
                              <col width=70%></col>
                              <col width=30%></col>
                           </colgroup>
                           <tr>
                              <td id="btd1">
                                 <label>검색조건</label>
                                 <select class="findIndex" name="findIndex">
                                    <option value="all">전체</option>
                                    <option value="bs_title">제목</option>
                                    <option value="bs_content">내용</option>
                                 </select>
                                 <input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" />
                                 <input type="button" value="검색" class="button" style="width:40px;" name="findSuggestion" id="findSuggestion"/>
                                 <input type="hidden" name="hm_empnum" value="<%=user_ID%>">
                              </td>
                               <td id="std1">
                                 <select id="pageCtrl" name="pageCtrl">
                                    <option value="5">5줄</option>
                                    <option value="10">10줄</option>
                                    <option value="20">20줄</option>
                                    <option value="30">30줄</option>
                                    <option value="50">50줄</option>
                                 </select>
                              </td>   
                           </tr>
                     </table>
                  </form>
               </div>
               
               <%-- =====================검색 기능 종료 ================= --%>
            <div class="table_size" id="suggestionList" align ="center">
               <form name="suggestionForm" id="suggestionForm">
                  <table class="table" summary ="게시판리스트">
                     <colgroup> 
                        <col width="10%" />
                        <col width="49%"/>
                        <col width="7%"/>
                        <col width="7%"/>
                        <col width="7%"/>
                        <col width="7%"/>
                        <col width="13%"/>
                     </colgroup>
                     <thead>
                        <tr>
                           <th>글번호</th>
                           <th>글제목</th>
                           <th>댓글</th>
                           <th>추천</th>
                           <th>비추천</th>
                           <th>조회수</th>
                           <th>작성일</th>
                        </tr>
                     </thead>
                     <tbody>
         <%
         if(sList.size() == 0 ){
         %>
                           <tr>
                              <td colspan="7" align="center">
                                	등록된 게시글이 존재하지 않습니다.
                              </td>
                           </tr>
         <%
               }else{
                  for(int i = 0 ; i < sList.size() ; i ++){
                  SuggestionVO svo = sList.get(i);   
                  
         %>
                                 <tr data="<%= svo.getBs_num() %>">
                                    <td align = "center" ><%= svo.getBs_num().substring(7, 11) %></td>
                                    <td align = "left"><span class="goSearch"><%= svo.getBs_title() %></span></td>
                                    <td align = "center"><%= svo.getBsr_num() %> </td>
                                    <td align = "center"><%= svo.getBsl_likeYN() %> </td>
                                    <td align = "center"><%= svo.getBsl_dislikeYN() %> </td>
                                    <td align = "center"><%= svo.getBs_hitnum() %> </td>
                                    <td align = "center"><%= svo.getBs_insertdate().substring(0,10) %></td>
                                 </tr>
         <%
                  }
               }   
         %>
                        </tbody>
                     </table>
                  </div>
   
                     <div class="table_align" id="boardBut" align="right">
                        <input type="button" value="글쓰기" class="button" style="width:50px;" id="writeSuggestion" name="writeSuggestion">
                     </div>
                     
                     <jsp:include page="paging.jsp" flush="true">
                        <jsp:param name="url" value="../board/selectSuggestion.td"/>
                        <jsp:param name="str" value=""/>
                        <jsp:param name="n_hm_empnum" value="<%=user_ID%>"/>
                        <jsp:param name="pageSize" value="<%=pageSize%>"/>
                        <jsp:param name="groupSize" value="<%=groupSize%>"/>
                        <jsp:param name="curPage" value="<%=curPage%>"/>
                        <jsp:param name="totalCount" value="<%=totalCount%>"/>
                        <jsp:param name="key" value="<%=key%>"/>
                        <jsp:param name="index" value="<%=index%>"/>   
                     </jsp:include>
                     <br>
               </form>   
            </div>
         </div>
         </div>
   </body>
</html>