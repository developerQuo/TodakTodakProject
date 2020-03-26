<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java142.todak.board.controller.BoardController"  %>
<%@ page import="java142.todak.board.vo.NoticeVO"  %>
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
      
      Object obj2 = request.getAttribute("i_nvo");
      NoticeVO pvo =(NoticeVO) obj2; //pvo ==> pageVO
      
      String key = pvo.getKeyword();//검색을위한 변수 받아옵니다.
      String index = pvo.getFindIndex();//검색을 위한 변수 받아옵니다.
      
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
      <title>공지사항</title>
      
      <link rel="stylesheet" type="text/css" href="/include/css/default.css"/>
      
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
         
         $("#findNotice").click(function(){
             var keyword = $("#keyword").val();
             $("#keyword").val(keyword);

             var findIndex = $("#findIndex").val();
             $("#findIndex").val(findIndex);
             
             if(keyword == "전체" && findIndex == ("bn_divnum" || "bn_deptnum")){
                console.log("전체를 기타로 인식하기");
                $("#keyword").val("기타");
             }
             
             if(keyword == "검색어를 입력하세요" && keyword == "null"){
                alert("검색어를 입력하세요");
                return false;
             }
             
             goPage(1);
         });

         
         $("#pageCtrl").change(function(){
            goPage(1);
         });
         
         function goPage(page){
            if($("#findIndex").val()=="all"){
               $("#keyword").val("");
            }
            $("#page").val(page);
            $("#no_search").attr({
               "method":"get",
               "action":"../board/selectNotice.td"
            });
            $("#no_search").submit();
         }
         
         $("#writeNotice").click(function(){
            var hm_empnum = $("#hm_empnum").val();
             $("#hm_empnum").val(hm_empnum);
             
            var hm_deptnum = $("#hm_deptnum").val();
             $("#hm_deptnum").val(hm_deptnum);
             
            var hm_duty = $("#hm_duty").val();
             $("#hm_duty").val(hm_duty);

             $("#searchForm").attr({
                "method":"post",
                "action":"../board/moveWriteNotice.td"
             });
             
             $("#searchForm").submit();
            
         });
         
          $(".goSearch").click(function(){
             var bn_num = $(this).parents("tr").attr("data");
             
             $("#bn_num").val(bn_num);
   
             $("#searchForm").attr({
                "method":"post",
                "action":"../board/searchNotice.td"
             });
             
             $("#searchForm").submit();
          });
          
          var selfCheck = $("input:checkbox[id='selectCheckForm']").is(":checked") ;

          
          $("#selectCheck").change(function(){
          if($("#selectCheck").is(":checked") == true ) {
             $("#selectCheckForm").attr({
                "method":"get",
                "action":"../board/selectNotice.td"
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
            
   <%
   
   %>
            <div id="boardContainer">
            <div id="boardTit"><h3><b>공지사항</b></h3></div>
            <hr>
               <form id="searchForm" name="searchForm" method="POST">
                  <input type="hidden" name="bn_num" id="bn_num">   
                  <input type="hidden" name="hm_empnum" id="hm_empnum" value="<%=user_ID%>">   
               </form>
                  <%-- ==================체크박스 기능================== --%>
            <div class="table_align" align ="right">
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
               <div class="table_align" id="noticeSearch">
               
                  <form id="no_search" name="no_search" align ="left">
                        <table summary ="검색">
                           <colgroup>
                              <col width="70%"></col>
                              <col width="30%"></col>
                           </colgroup>
                           <tr>
                              <td id="btd1">
                                 <label>검색조건</label>
                                 <select class="findIndex" name="findIndex">
                                    <option value="all">전체</option>
                                    <option value="bn_title">제목</option>
                                    <option value="bn_content">내용</option>
                                    <option value="hm_name">작성자</option>
                                    <option value="bn_deptnum">부서</option>
                                    <option value="bn_divnum">본부</option>
                                 </select>
                                 <input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" />
                                 <input type="button" class="button" style="width:40px" value="검색" name="findNotice" id="findNotice"/>
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
            <div id="boardList" align ="center">
               <form name="selectForm" id="selectForm">
                  <div class="table_size">
                     <table class="table" summary ="게시판리스트">
                        <colgroup> 
                           <col width="10%"/>
                           <col width="15%"/>
                           <col width="45%"/>
                           <col width="10%"/>
                           <col width="10%"/>
                           <col width="10%"/>
                        </colgroup>
                        <thead>
                           <tr>
                              <th>글번호</th>
                              <th>대상</th>
                              <th>글제목</th>
                              <th>조회수</th>
                              <th>작성일</th>
                              <th>작성자 </th>
                           </tr>
                        </thead>
                        <tbody>
            <%
                    Object obj = request.getAttribute("noticeList");
                  ArrayList<NoticeVO> sList = (ArrayList<NoticeVO>)obj;
                  //System.out.println("sList.size() >>> : " + sList.size());
                  if(sList.size() == 0 ){
            %>
                              <tr>
                                 <td colspan = "6" align = "center">
                                    등록된 게시글이 존재하지 않습니다.</td>
                              </tr>
            <%
                  }else{
                     for(int i = 0 ; i < sList.size() ; i ++){
                      NoticeVO nvo = sList.get(i);   
                     
                      String range = nvo.getBn_deptnum();
                      
                      if(range.equals("기타")){
                         range = nvo.getBn_divnum();
                         
                      }
                      range = range.replace("기타", "전체");
            
            %>
                                    <tr data="<%= nvo.getBn_num() %>">
                                    <td align = "center" ><%=nvo.getBn_num().substring(7)%></td>
                                       <td align = "center" ><%= range %></td>
                                       <td align = "left"><span class="goSearch"><%= nvo.getBn_title() %></span></td>
                                       <td align = "center" ><%= nvo.getBn_hitnum() %></td>
                                       <td align = "center"><%= nvo.getBn_insertdate().substring(0, 10) %></td>
                                       <td align = "center"><%= nvo.getHm_name() %></td>
                                    </tr>
            <%
                     }
                  }
            %>
                           </tbody>
      
                     </table>
                  </div>
   <%
                  Object obj3 = request.getAttribute("writerQualified");
                  ArrayList<MemberVO> mList = (ArrayList<MemberVO>)obj3;
                  
                  MemberVO mvo = mList.get(0);
                  String hm_duty = mvo.getHm_duty();
                  String hm_deptnum = mvo.getHm_deptnum();
                  String hm_name =  mvo.getHm_name();
                  
                  //System.out.println("hm_duty >>> : " + hm_duty);
                  //System.out.println("hm_deptnum >>> : " + hm_deptnum);
                  //System.out.println("hm_name >>> : " + hm_name);
                  
                  
                  if(!(hm_duty.equals("73")||hm_duty.equals("67"))){
   
   %>         
                     <div class="table_align" id="boardBut" align="right">
                        <input type="button" value="글쓰기" class="button" id="writeNotice" name="writeNotice">
                        <input type="hidden" value="hm_duty" id="hm_duty" value=<%=hm_duty %>>
                        <input type="hidden" value="hm_deptnum" id="hm_deptnum" value=<%=hm_deptnum %>>
                     </div>
   <%
                  }
   %>
                  <br>
                  <div class="paging">
                     <jsp:include page="paging.jsp" flush="true">
                        <jsp:param name="url" value="../board/selectNotice.td"/>
                        <jsp:param name="str" value=""/>
                        <jsp:param name="n_hm_empnum" value="<%=user_ID%>"/>
                        <jsp:param name="pageSize" value="<%=pageSize%>"/>
                        <jsp:param name="groupSize" value="<%=groupSize%>"/>
                        <jsp:param name="curPage" value="<%=curPage%>"/>
                        <jsp:param name="totalCount" value="<%=totalCount%>"/>
                        <jsp:param name="key" value="<%=key%>"/>
                        <jsp:param name="index" value="<%=index%>"/>   
                     </jsp:include>
                  </div>
                  <br>
               </form>   
            </div>
         </div>
         </div>
   </body>
</html>