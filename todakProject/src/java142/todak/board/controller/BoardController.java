package java142.todak.board.controller;

import java.util.Enumeration;
import java.util.List;

import java142.todak.board.service.BoardService;
import java142.todak.board.vo.NoCheckVO;
import java142.todak.board.vo.NoticeVO;
import java142.todak.board.vo.SuLikeVO;
import java142.todak.board.vo.SuReplyVO;
import java142.todak.board.vo.SuggestionVO;
import java142.todak.common.ChaebunUtils;
import java142.todak.common.FileUploadUtil;
import java142.todak.common.Paging;
import java142.todak.common.VOPrintUtil;
import java142.todak.etc.utils.LoginSession;
import java142.todak.human.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/board")
public class BoardController {
   
   
   final static String FILEPATH1 =  "C://Users//BEE//Desktop//TodakProject//todakProject//WebContent//upload//board//notice";
   final static String FILEPATH2 =  "C://Users//BEE//Desktop//TodakProject//todakProject//WebContent//upload//board//suggestion";
   final static String DOWNLOADPATH1 = "upload/board/notice/";
   final static String DOWNLOADPATH2 = "upload/board/suggestion/";
   final static String NOTICE_GUBUN = "N";
   final static String SUGGESTION_GUBUN = "S";
   final static String SUREPLY_GUBUN = "R";
   final static String SULIKE_GUBUN = "L";
   final static String CHECK_GUBUN = "C";
   
   Logger logger = Logger.getLogger(BoardController.class);

   
   @Autowired
   private BoardService boardService;


   //좋아요수세기
   @RequestMapping(value="/countSuLike", method = RequestMethod.POST, produces = "application/json")
   @ResponseBody
   public ResponseEntity<String> countSuLike(@RequestBody SuLikeVO slvo){
      logger.info("(log)BoardController.countSuLike 진입"); 
      
      ResponseEntity<String> entity = null;
      String result = null;
      String bs_num = slvo.getBs_num();
      logger.info("글번호 bs_num >>> " + bs_num);
      
      try{
         List<SuLikeVO> countSuLike = boardService.countSuLike(slvo);
         result = countSuLike.get(0).getBsl_likeYN();
         
         entity = new ResponseEntity<String>(result, HttpStatus.OK);
         
      }catch(Exception e){
         e.printStackTrace();
         entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
      }
      logger.info("(log)BoardController.countSuLike 종료"); 
      
      return entity;
   }//end of selectSuReply
   
   //좋아요기능 구현
     @ResponseBody
     @RequestMapping(value="/checkLike", method = RequestMethod.POST, produces = "application/json")
      public ResponseEntity<String> checkLike(@RequestBody SuLikeVO slvo){
         logger.info("(log)BoardController.checkLike 진입"); 

         List<SuLikeVO> list = boardService.chaebunSuLike();
         
         if(list.size() == 1){
            String bsl_num = ChaebunUtils.cNum(list.get(0).getBsl_num(), SUREPLY_GUBUN);
            slvo.setBsl_num(bsl_num);
         }
         
         String bs_num = slvo.getBs_num();
         
         logger.info("좋아요 >>> " + slvo.getBsl_num());
         logger.info("글번호 bs_num >>> " + bs_num);
         
         ResponseEntity<String> entity = null;
        
         int result = 0;
         
         try{
               result = boardService.checkSuLike(slvo);
               if(result == 1){
                   entity = new ResponseEntity<String>("1", HttpStatus.OK);
               }else{
                  boardService.unCheckSuLike(slvo);
                  entity = new ResponseEntity<String>("0", HttpStatus.OK);
               }
            
         }catch(Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
         }
         logger.info("(log)BoardController.checkLike 종룐"); 
         return entity;
      }

      //비추수세기
      @RequestMapping(value="/countSuDislike", method = RequestMethod.POST, produces = "application/json")
      @ResponseBody
   public ResponseEntity<String> countSuDislike(@RequestBody SuLikeVO slvo){
      logger.info("(log)BoardController.countSuDislike 진입"); 
      
      ResponseEntity<String> entity = null;
      String result = null;
      String bs_num = slvo.getBs_num();
      logger.info("글번호 bs_num >>> " + bs_num);
      
      try{
         List<SuLikeVO> countSuDislike = boardService.countSuDislike(slvo);
         result = countSuDislike.get(0).getBsl_dislikeYN();
         
         entity = new ResponseEntity<String>(result, HttpStatus.OK);
         
      }catch(Exception e){
         e.printStackTrace();
         entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
      }
      logger.info("(log)BoardController.countSuDislike 종료"); 
      
      return entity;
   }//end of selectSuReply

   //비추 기능 구현
     @ResponseBody
     @RequestMapping(value="/checkSuDislike", method = RequestMethod.POST, produces = "application/json")
      public ResponseEntity<String> checkSuDislike(@RequestBody SuLikeVO slvo){
         logger.info("(log)BoardController.checkSuDislike 진입"); 

         List<SuLikeVO> list = boardService.chaebunSuLike();
         
         if(list.size() == 1){
            String bsl_num = ChaebunUtils.cNum(list.get(0).getBsl_num(), SUREPLY_GUBUN);
            slvo.setBsl_num(bsl_num);
         }
         
         String bs_num = slvo.getBs_num();
         
         logger.info("좋아요 >>> " + slvo.getBsl_num());
         logger.info("글번호 bs_num >>> " + bs_num);
         
         ResponseEntity<String> entity = null;
        
         int result = 0;
         
         try{
               result = boardService.checkSuDislike(slvo);
               if(result == 1){
                   entity = new ResponseEntity<String>("1", HttpStatus.OK);
               }else{
                  boardService.unCheckSuDislike(slvo);
                  entity = new ResponseEntity<String>("0", HttpStatus.OK);
               }
            
         }catch(Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
         }
         logger.info("(log)BoardController.checkSuDislike 종룐"); 
         return entity;
      }

     
        
   //댓글 목록
   @RequestMapping(value="/all/{bs_num}.td")
   @ResponseBody
   public ResponseEntity<List<SuReplyVO>> selectSuReply(@PathVariable("bs_num") String  bs_num, SuReplyVO srvo){
      logger.info("(log)ReplyController.selectSuReply 진입"); 
      
      ResponseEntity<List<SuReplyVO>> entity = null;
      
      srvo.setBs_num(bs_num);
      
      logger.info("bs_num >>> " + srvo.getBs_num());
      try{
         
         entity = new ResponseEntity<>(boardService.selectSuReply(srvo), HttpStatus.OK);
         
      }catch(Exception e){
         e.printStackTrace();
         entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
      }
      logger.info("(log)ReplyController.selectSuReply 종료"); 
      
      return entity;
   }//end of selectSuReply 
   
   
   //댓글작성하기
     @RequestMapping(value="/replyInsert")
      public ResponseEntity<String> insertSuReply(@RequestBody SuReplyVO srvo){
         logger.info("(log)ReplyController.insertSuReply 진입"); 

         List<SuReplyVO> list = boardService.chaebunSuReply();
         if(list.size() == 1){
            String bsr_num = ChaebunUtils.cNum(list.get(0).getBsr_num(), SUREPLY_GUBUN);
            srvo.setBsr_num(bsr_num);
         }
         
         String bs_num = srvo.getBs_num();
         
         logger.info("댓글번호 >>> " + srvo.getBsr_num());
         logger.info("글번호 bs_num >>> " + bs_num);
         
         ResponseEntity<String> entity = null;
         int result;
         
         try{
               result = boardService.insertSuReply(srvo);
               if(result == 1){
                  entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
               }
            
            
         }catch(Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
         }
         logger.info("(log)ReplyController.insertSuReply 종룐"); 
         return entity;
      }

     //댓글 수정
      @RequestMapping(value="/update/{bsr_num}.td", method = {RequestMethod.PUT, RequestMethod.PATCH})
      @ResponseBody
      public ResponseEntity<String> updateSuReply(@PathVariable("bsr_num") String bsr_num, @RequestBody SuReplyVO srvo){
         logger.info("(log)ReplyController.replyUpdate 진입"); 
         ResponseEntity<String> entity = null;
         
         try{
            srvo.setBsr_num(bsr_num);
            int result = boardService.updateSuReply(srvo);
            if(result == 1){
               entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
            }else{
               entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
            }
            
         }catch(Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
      
         }
         logger.info("(log)ReplyController.replyUpdate 종료"); 
         return entity;
      }
      
      //건의사항 댓글 삭제하기
      @RequestMapping(value="/delete/{bsr_num}.td", method = {RequestMethod.PUT, RequestMethod.PATCH})
      @ResponseBody
      public ResponseEntity<String> deleteSuReply(@PathVariable("bsr_num") String bsr_num, @RequestBody SuReplyVO srvo){
         logger.info("(log)ReplyController.replyDelete 진입"); 
         ResponseEntity<String> entity = null;
         
         try{
            srvo.setBsr_num(bsr_num);
            int result = boardService.deleteSuReply(srvo);
            if(result == 1){
               entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
            }else{
               entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
            }         
            
         }catch(Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
      
         }
         logger.info("(log)ReplyController.replyDelete 종료"); 
         return entity;
      }
    /*--------------------------------------------*/
   
   //인덱스에서 공지사항으로 이동하기
   @RequestMapping("/moveSelectNotice")
   public String moveSelectNotice(@RequestParam("hm_empnum") String hm_empnum, Model model){
      
      model.addAttribute("hm_empnum",hm_empnum);
      return "redirect:/board/selectNotice.td";
   }
   
   
   
   //건의사항 전체 출력하기
   @RequestMapping("/selectSuggestion")
   public String selectSuggestion(@ModelAttribute SuggestionVO svo, MemberVO mvo, Model model,HttpServletRequest request){
      
      logger.info("(log)BoardController.selectSuggestion 시작 >>> ");
      
      LoginSession sManager = LoginSession.getInstance();
      String sessionId = request.getSession().getId();
      String hm_empnum = sManager.getUserID(sessionId);
      logger.info("hm_empnum >>>> : " + hm_empnum); 
      
      
      int totalCnt = 0;
      String cPage = request.getParameter("curPage");
      String pageCtrl=request.getParameter("pageCtrl");
      
      logger.info("cPage >>>> " + cPage);
      
      if(svo.getFindIndex() == null){
         String key = request.getParameter("key");//검색에 관련된 내용을 쿼리스트링으로 받는 내용입니다.
         svo.setKeyword(key);
         String index = request.getParameter("index");//검색에 관련된 내용을 쿼리스트링으로 받는 내용입니다.
         svo.setFindIndex(index);
      }
      
      
      String findIndex = svo.getFindIndex();
      logger.info("FindIndex == " + findIndex);
      if(findIndex != null && findIndex.equals("hm_empnum")) {
         svo.setKeyword(hm_empnum);
         String e = "hm_empnum";
         model.addAttribute("findIndex",e);
      }

      logger.info("FindIndex == " + svo.getFindIndex());
      logger.info("keyword == " + svo.getKeyword());
      
      Paging.setPage(svo,cPage,pageCtrl);//페이징할 정보를 Paging클래스에 보내줍니다
      
      
      mvo.setHm_empnum(hm_empnum);
   
      List<SuggestionVO> suggestionList = null;
      suggestionList = boardService.selectSuggestion(svo);
      if(suggestionList.size() != 0){
         totalCnt=suggestionList.get(0).getTotalCount();//쿼리 조회한 리스트의 0번 인덱스에 담긴 totalCount값을 받아서 
         svo.setTotalCount(totalCnt);//vo에 담아줍니다.
      }
      svo.setN_hm_empnum(hm_empnum);
      
      model.addAttribute("suggestionList",suggestionList);
      model.addAttribute("i_svo",svo);
      
      String url = "board/selectSuggestion";
      
      logger.info("(log)BoardController.selectSuggestion 종료>>> ");
      
      return url;
      
   }
   
   //건의사항 상세 출력하기
   @RequestMapping("/searchSuggestion")
   public String searchSuggestion(@ModelAttribute SuggestionVO svo, Model model, SuLikeVO slvo, @RequestParam("hm_empnum") String hm_empnum){
      
      logger.info("(log)BoardController.searchSuggestion 시작 >>> ");

      List<SuggestionVO> suggestionDetail = null;
      suggestionDetail = boardService.searchSuggestion(svo);
      
      model.addAttribute("suggestionDetail",suggestionDetail);
      
      
      //좋아요유무 확인해서 출력하기
      String bs_num = svo.getBs_num();
      
      logger.info("hm_empnum >>>> : " + hm_empnum );
      
      slvo.setBs_num(bs_num);
      slvo.setHm_empnum(hm_empnum);
      
      
      List<SuLikeVO> beforeLike = null;
      beforeLike = boardService.beforeSuLike(slvo);
      String bsl_likeYN = "";
      bsl_likeYN = beforeLike.get(0).getBsl_likeYN();
      
      model.addAttribute("bsl_likeYN",bsl_likeYN);
      
      
      //비추 유무 확인해서 출력하기
      List<SuLikeVO> beforeSuDislike = null;
      beforeSuDislike = boardService.beforeSuDislike(slvo);
      String bsl_dislikeYN = "";
      bsl_dislikeYN = beforeSuDislike.get(0).getBsl_dislikeYN();
      
      model.addAttribute("bsl_dislikeYN",bsl_dislikeYN);
      
      String url = "board/searchSuggestion";
      
      logger.info("(log)BoardController.searchSuggestion 시작 >>> ");
      
      return url;
      
   }
   
   //건의사항 게시글 삭제하기
   @RequestMapping(value="/deleteSuggestion")
   public String deleteSuggestion(@ModelAttribute SuggestionVO svo, Model model){
      
      int result = 0;
      
      String hm_empnum = svo.getHm_empnum();
      
      result = boardService.deleteSuggestion(svo);
      
      if(result == 1){
         logger.info("삭제성공");
      }else{
         logger.info("삭제실패");
      }
      
      model.addAttribute("hm_empnum",hm_empnum);
      
      return "redirect:" + "/board/selectSuggestion.td";
   }
   
   //건의사항 게시글 수정페이지로 이동
   @RequestMapping(value="/moveUpdateSuggestion")
   public String moveUpdateSuggestion(@ModelAttribute SuggestionVO svo, Model model){
      logger.info("(log)BoardController.moveUpdateSuggestion 시작 >>> ");
      
      List<SuggestionVO> updateList = null;
      String url = null;
      String bs_num = svo.getBs_num();
      logger.info("bs_num >>> : " + bs_num);
      updateList = boardService.searchSuggestion(svo);
      
      model.addAttribute("updateList",updateList);
      
      
      if(updateList.size() == 1){
         url = "board/updateSuggestion";
      }else{
         model.addAttribute("hm_empnum",svo.getHm_empnum());
         url = "redirect:" + "/board/selectSuggestion.td";
      }
      
      logger.info("(log)BoardController.updateSearchSuggestion 종료 >>> ");
      return  url;
   }
   
   
   //건의사항 게시글 수정하기
   @RequestMapping(value="/updateSuggestion", method=RequestMethod.POST)
   public String updateSuggestion(@ModelAttribute SuggestionVO svo, Model model, HttpServletRequest request){
      logger.info("(log)BoardController.updateSuggestion 시작 >>> ");
      int result = 0;
      String hm_empnum = null;
      
      FileUploadUtil fuu = new FileUploadUtil();
      boolean bFlag = false;
      bFlag = fuu.fileUpload(request, FILEPATH2);
      
      logger.info("bFlag >>> : " + bFlag );
         
      if(bFlag){
         
         Enumeration<String> en = fuu.getFileNames();
         
         String fileName = en.nextElement();
         
         if(fileName != null){
            fileName = fileName.replaceAll(DOWNLOADPATH2, "");
         }

         
         if(fileName != null){
            String bs_image = DOWNLOADPATH2 + fileName;
            svo.setBs_image(bs_image);
         }else{
            svo.setBs_image("");
         }
         
         String bs_image = svo.getBs_image();
   
         logger.info("이미지이름 >>>> " + bs_image);
         
         String bs_title = fuu.getParameter("bs_title");
         String bs_content = fuu.getParameter("bs_content");
         String bs_num = fuu.getParameter("bs_num");
         hm_empnum = fuu.getParameter("hm_empnum");
         
         
         
         logger.info(bs_num + "" + bs_title + "" +bs_content + "" + hm_empnum);
         
         svo.setBs_num(bs_num);
         svo.setBs_title(bs_title);
         svo.setBs_content(bs_content);
         svo.setBs_image(bs_image);
         svo.setHm_empnum(hm_empnum);
      

         VOPrintUtil.suggestionVOPrint(svo);
      
      }else{
         logger.info("multipart 수정 실패");
      }
   
      result = boardService.updateSuggestion(svo);
      
      if(result == 1){
         logger.info("수정성공");
      }else{
         logger.info("수정실패");
      }
      
      String bs_num = svo.getBs_num();
      model.addAttribute("hm_empnum",hm_empnum);
      
      
      return "redirect:" + "/board/searchSuggestion.td?bs_num=" + bs_num;
   }
   
   //건의사항 파일다운로드 함수
   @RequestMapping(value="/downloadSuggestion")
   public String downloadSuggestion(@ModelAttribute SuggestionVO svo, Model model){
      logger.info("(log)BoardController.downloadSuggestion 시작 >>> ");

      String bs_image = svo.getBs_image();
      
      bs_image = bs_image.replace(DOWNLOADPATH2, "");
      
      logger.info("bs_image >>> " + bs_image);
      
      model.addAttribute("fileName" ,bs_image);
      model.addAttribute("FilePath", FILEPATH2 );
      
      logger.info("(log)BoardController.downloadSuggestion 종료 >>> ");
      return "board/fileDownload";
   }

   //건의사항 작성으로 이동하기
   @RequestMapping("/moveWriteSuggestion")
   public String moveWriteSuggestion(){
      logger.info("(log)BoardController.moveWriteSuggestion 진입 >>> ");

      return "board/insertSuggestion";
   }
   
   //건의사항 작성
   @RequestMapping("/insertSuggestion")
   public String insertSuggestion(@ModelAttribute SuggestionVO svo, Model model,HttpServletRequest request){
      logger.info("(log)BoardController.insetSuggestion 시작 >>> ");
      logger.info("(log)BoardController.cheabunSuggestion 시작 >>> ");
      
      String bs_num = "";
      List<SuggestionVO> list = null;
      list = boardService.cheabunSuggestion();
      bs_num = list.get(0).getBs_num();
      
      svo.setBs_num(ChaebunUtils.cNum2(bs_num, SUGGESTION_GUBUN));
      logger.info("(log)BoardController.cheabunSuggestion 종료  : bs_num >>> " + ChaebunUtils.cNum2(bs_num, SUGGESTION_GUBUN));

      
      String url =  null;
      
      
      FileUploadUtil fuu = new FileUploadUtil();
      boolean bFlag = false;
      bFlag = fuu.fileUpload(request, FILEPATH2);
      logger.info("bFlag >>> : " + bFlag );
      
      if(bFlag){
         
         Enumeration<String> en = fuu.getFileNames();
         
         String fileName = en.nextElement();
         
         if(fileName != null){
            String bs_image = DOWNLOADPATH2 + fileName;
            svo.setBs_image(bs_image);
         }else{
            svo.setBs_image("");
         }
         
         String    hm_empnum = fuu.getParameter("hm_empnum");
         String    bs_title   =  fuu.getParameter("bs_title");
         String    bs_content = fuu.getParameter("bs_content");
         
         svo.setHm_empnum(hm_empnum);
         svo.setBs_title(bs_title);
         svo.setBs_content(bs_content);
         
         int result = 0;
         result = boardService.insertSuggestion(svo);
         
         if(result == 1){
            
            logger.info("작성 성공!");
            url = "redirect:/board/selectSuggestion.td";
            model.addAttribute("hm_empnum",hm_empnum);
         }else{
            logger.info("작성 실패!");
            url = "redirect:/board/writeSuggestion.td";
         }

      }else{
         logger.info("파일업로드실패");
         url = "redirect:/board/writeSuggestion.td";
      }
      
      
      logger.info("(log)BoardController.insetSuggestion 종료 >>> ");
      return url;
   }
   
   //공지사항 게시글 목록  및 검색
   @RequestMapping("/selectNotice") 
   public String selectBoardNotice(@ModelAttribute NoticeVO nvo, MemberVO mvo, Model model, HttpServletRequest request ) {
      
      logger.info("(log)BoardController.selectNotice 시작 >>> ");
      LoginSession sManager = LoginSession.getInstance();
      String sessionId = request.getSession().getId();
      String hm_empnum = sManager.getUserID(sessionId);
      logger.info(hm_empnum);
      int totalCnt = 0;
      String cPage = request.getParameter("curPage");
      String pageCtrl=request.getParameter("pageCtrl");
      
      if(nvo.getFindIndex() == null){
         String key=request.getParameter("key");//검색에 관련된 내용을 쿼리스트링으로 받는 내용입니다.
         nvo.setKeyword(key);
         String index=request.getParameter("index");//검색에 관련된 내용을 쿼리스트링으로 받는 내용입니다.
         nvo.setFindIndex(index);
      }
      
      
      String findIndex = nvo.getFindIndex();
      logger.info("FindIndex == " + findIndex);
      if(findIndex != null && findIndex.equals("hm_empnum")) {
         nvo.setKeyword(hm_empnum);
         String e = "hm_empnum";
         model.addAttribute("findIndex",e);
      }

      logger.info("FindIndex == " + nvo.getFindIndex());
      logger.info("keyword == " + nvo.getKeyword());
      
      MemberVO i_mvo = new MemberVO();
      
      //로그인한 사람 정보 받아오기
      mvo.setHm_empnum(hm_empnum);
      
      if(mvo.getHm_empnum().isEmpty()){
         mvo.setHm_empnum(nvo.getHm_empnum());
      }
      
      String[] check_hm_empnum = mvo.getHm_empnum().split(",");
      
      i_mvo.setHm_empnum(check_hm_empnum[0]);
      List<MemberVO> writerQualified = null;
      writerQualified =  boardService.selectWrite(i_mvo);
      
      MemberVO _mvo = writerQualified.get(0);
      String check_empnum = _mvo.getHm_empnum();
      nvo.setCheck_empnum(check_empnum);
      
      String c_hm_deptnum = _mvo.getHm_deptnum();
      logger.info("부서번호 받아오기" + c_hm_deptnum);
      String check_divnum = c_hm_deptnum.substring(0, 2);
      String check_deptnum = "";
      
      if(c_hm_deptnum.length() > 2) check_deptnum = c_hm_deptnum.substring(2, 4);
      else check_deptnum = "98";
      
      logger.info("check_divnum >>> : " + check_divnum);
      logger.info("check_deptnum >>> : " + check_deptnum);
   
      //얘는 왜 넣었던걸까?ㅎ
      if(findIndex == null) nvo =  new NoticeVO();
   
      //admin계정에 무조건 권한주기
      if(hm_empnum.equals("H000000000000")) {
         nvo.setFindIndex("admin");
         logger.info("FindIndex == " + nvo.getFindIndex());
      }else{
         nvo.setCheck_divnum(check_divnum);
         nvo.setCheck_deptnum(check_deptnum);
         
      }
      
      logger.info("로그인한 사람의 부서 정보 가져오기  >>> : " + nvo.getCheck_divnum() +  " " + nvo.getCheck_deptnum());
      
       logger.info("cPage >>>> " + cPage);
         
       Paging.setPage(nvo,cPage,pageCtrl);//페이징할 정보를 Paging클래스에 보내줍니다
       
      System.out.println("null...>>> : " + nvo.getCurPage() + " : " + nvo.getPageSize());
      
      List<NoticeVO> noticeSelectList = null;
      noticeSelectList = boardService.selectNotice(nvo);
      
         if(noticeSelectList.size() != 0){
             totalCnt=noticeSelectList.get(0).getTotalCount();//쿼리 조회한 리스트의 0번 인덱스에 담긴 totalCount값을 받아서 
             nvo.setTotalCount(totalCnt);//vo에 담아줍니다.
          }
         nvo.setN_hm_empnum(hm_empnum);
          
      
      model.addAttribute("noticeList", noticeSelectList);
      model.addAttribute("writerQualified", writerQualified);
       model.addAttribute("i_nvo",nvo);
      
      logger.info("(log)BoardController.listNotice 종료");
      return "board/selectNotice";
   }
   
   
   //공지사항 게시글 입력
   @RequestMapping("/insertNotice")
   public String insertNotice(@ModelAttribute NoticeVO nvo, MemberVO mvo, 
                                       Model model, HttpServletRequest request){
      logger.info("(log)BoardController.insertNotice 시작 >>> ");
      logger.info("request.getContentType() >>> : " + request.getContentType());
      logger.info("(log)BoardController.chaebunNotice 시작 >>> ");

      String bn_num = "";
      List<NoticeVO> list = null;
      NoticeVO nvo_Bn_num = null;
      
      list = boardService.chaebunNotice();
      nvo_Bn_num = list.get(0);
      bn_num = nvo_Bn_num.getBn_num();
      bn_num = ChaebunUtils.cNum2(bn_num, NOTICE_GUBUN);
      logger.info(" bn_num : " + bn_num);

      String url = "";
      
      FileUploadUtil fuu = new FileUploadUtil();
      boolean bFlag = false;
      bFlag = fuu.fileUpload(request, FILEPATH1);
      logger.info("bFlag >>> : " + bFlag );
      if(bFlag){
         
         Enumeration<String> en = fuu.getFileNames();
         
         String firstFile =  en.nextElement();
         String secondFile =  en.nextElement();
         
         logger.info("firstFile >>> : " + firstFile);
         logger.info("secondFile >>> : " + secondFile);

         
         if(secondFile == null && firstFile != null){
            
            nvo.setBn_image(DOWNLOADPATH2 + firstFile);
            nvo.setBn_file("");
            logger.info("1.파일명 >>> : " +  nvo.getBn_file());
            logger.info("1.이미지명 >>> : " +  nvo.getBn_image());
      
         }else if(firstFile == null && secondFile != null){
            nvo.setBn_file(secondFile);
            nvo.setBn_image("");
            logger.info("2.파일명 >>> : " +  nvo.getBn_file());
            logger.info("2.이미지명 >>> : " +  nvo.getBn_image());
      
         }else if(firstFile == null && secondFile == null){
            nvo.setBn_file("");
            nvo.setBn_image("");
            logger.info("3.파일명 >>> : " +  nvo.getBn_file());
            logger.info("3.이미지명 >>> : " +  nvo.getBn_image());
         
         }else{
            nvo.setBn_file(secondFile);
            nvo.setBn_image(DOWNLOADPATH2 + firstFile);
            logger.info("4.파일명 >>> : " +  nvo.getBn_file());
            logger.info("4.이미지명 >>> : " +  nvo.getBn_image());
         }

         String bn_file = nvo.getBn_file();
         String bn_image = nvo.getBn_image();
   
         logger.info("파일이름 >>>> " + bn_file);
         logger.info("이미지이름 >>>> " + bn_image);
         
         String bn_title = fuu.getParameter("bn_title");
         String hm_name = fuu.getParameter("hm_name");
         String hm_empnum = fuu.getParameter("hm_empnum");
         
         String bn_content = fuu.getParameter("bn_content");
         String hm_duty = fuu.getParameter("hm_duty");
         
         String bn_divnum   = fuu.getParameter("bn_divnum");
         String bn_deptnum = fuu.getParameter("bn_deptnum");
         
         logger.info(hm_empnum + "" + bn_num + "" + bn_title + "" + hm_name + "" +bn_content + "" + bn_deptnum +"" + hm_duty);
         
         nvo.setHm_empnum(hm_empnum);
         nvo.setBn_num(bn_num);
         nvo.setBn_title(bn_title);
         nvo.setHm_name(hm_name);
         nvo.setBn_content(bn_content);
         nvo.setBn_image(bn_image);
         nvo.setBn_file(bn_file);
         nvo.setBn_deptnum(bn_deptnum);
         
         if(bn_deptnum == null) nvo.setBn_divnum("");
         else nvo.setBn_divnum(bn_divnum);
         
         nvo.setHm_duty(hm_duty);
         
         model.addAttribute("hm_empnum",hm_empnum);
         
         VOPrintUtil.noticeVOPrint(nvo);
      
      }else{
         logger.info("multipart 전송 실패");
         url = "/board/writeNotice.td";
         return "redirect:" + url;
      }
      
      int result = boardService.insertNotice(nvo);
   
      System.out.println("iFlag >>> " + result );
      if(result > 0){
         logger.info("글 작성 성공!");
         
         url = "/board/selectNotice.td";
      }else{ 
         logger.info("글 작성 오류 발생 !"); 
      }


      logger.info("(log)BoardController.insertNotice 종료 ");
      return "redirect:" + url;
   }
   
   //공지사항 글쓰기 폼으로 이동하기
   @RequestMapping(value="/moveWriteNotice")
   public String moveWriteNotice(@ModelAttribute MemberVO mvo, Model model){
      logger.info("(log)BoardController.moveWriteNotice 시작 >>> ");
      List<MemberVO> mList = null;
      mList = boardService.selectWrite(mvo);

      model.addAttribute("mList", mList);


      return "board/insertNotice";
   }
   
   //공지사항 게시글 상세보기
   @RequestMapping(value="/searchNotice")
   public String searchNotice(@ModelAttribute NoticeVO nvo, Model model){
      logger.info("(log)BoardController.searchNotice 시작 >>> ");
      
      List<NoticeVO> noticeSearchList = null;
      String url = null;
      String bn_num = nvo.getBn_num();
      logger.info("bn_num >>> : " + bn_num);
      noticeSearchList =    boardService.searchNotice(nvo);
      
      VOPrintUtil.noticeVOPrint(nvo);
      
      model.addAttribute("noticeSearchList",noticeSearchList);
      
      if(noticeSearchList.size() == 1){
         url = "/board/searchNotice";
      }else{
         url = "redirect:" + "/board/selectNotice.td";
      }
      
      return  url;
   }

   //파일다운로드 함수
   @RequestMapping(value="/downloadNotice")
   public String downloadNotice(@ModelAttribute NoticeVO nvo, Model model){
      logger.info("(log)BoardController.downloadNotice 시작 >>> ");

      String bn_file = nvo.getBn_file();
      
      logger.info("bn_file >>> " + bn_file);
      
      model.addAttribute("fileName" ,bn_file);
      model.addAttribute("FilePath", FILEPATH1 );
      
      logger.info("(log)BoardController.downloadNotice 종료 >>> ");
      return "board/fileDownload";
   }

   //공지사항 게시글 수정페이지로 이동
   @RequestMapping(value="/moveUpdateNotice")
   public String moveUpdateNotice(@ModelAttribute NoticeVO nvo, Model model){
      logger.info("(log)BoardController.updateSearchNotice 시작 >>> ");
      
      List<NoticeVO> updateList = null;
      String url = null;
      String bn_num = nvo.getBn_num();
      logger.info("bn_num >>> : " + bn_num);
      updateList = boardService.searchNotice(nvo);
      
      model.addAttribute("updateList",updateList);
      
      
      if(updateList.size() == 1){
         url = "board/updateNotice";
      }else{
         url = "redirect:" + "/board/selectNotice.td";
      }
      
      logger.info("(log)BoardController.updateSearchNotice 종료 >>> ");
      return  url;
   }
   
   //공지사항 게시글 수정하기
      @RequestMapping(value="/updateNotice", method=RequestMethod.POST)
      public String updateNotice(@ModelAttribute NoticeVO nvo, Model model, HttpServletRequest request){
         logger.info("(log)BoardController.updateNotice 시작 >>> ");
         int result = 0;
         
         FileUploadUtil fuu = new FileUploadUtil();
         boolean bFlag = false;
         bFlag = fuu.fileUpload(request, FILEPATH1);
         
         logger.info("bFlag >>> : " + bFlag );
         
         if(bFlag){
            
            Enumeration<String> en = fuu.getFileNames();
            
            String firstFile =  en.nextElement();
            String secondFile =  en.nextElement();
            
            logger.info("firstFile >>> : " + firstFile);
            logger.info("secondFile >>> : " + secondFile);
            
            if(firstFile != null){
               firstFile = firstFile.replaceAll(DOWNLOADPATH1, "");
            }

            
            if(secondFile == null && firstFile != null){
               
               nvo.setBn_image(DOWNLOADPATH1 + firstFile);
               nvo.setBn_file("");
               logger.info("1.파일명 >>> : " +  nvo.getBn_file());
               logger.info("1.이미지명 >>> : " +  nvo.getBn_image());
         
            }else if(firstFile == null && secondFile != null){
               nvo.setBn_file(secondFile);
               nvo.setBn_image("");
               logger.info("2.파일명 >>> : " +  nvo.getBn_file());
               logger.info("2.이미지명 >>> : " +  nvo.getBn_image());
         
            }else if(firstFile == null && secondFile == null){
               nvo.setBn_file("");
               nvo.setBn_image("");
               logger.info("3.파일명 >>> : " +  nvo.getBn_file());
               logger.info("3.이미지명 >>> : " +  nvo.getBn_image());
            
            }else{
               nvo.setBn_file(secondFile);
               nvo.setBn_image(DOWNLOADPATH1 + firstFile);
               logger.info("4.파일명 >>> : " +  nvo.getBn_file());
               logger.info("4.이미지명 >>> : " +  nvo.getBn_image());
            }

            String bn_file = nvo.getBn_file();
            String bn_image = nvo.getBn_image();
      
            logger.info("파일이름 >>>> " + bn_file);
            logger.info("이미지이름 >>>> " + bn_image);
            
            String bn_title = fuu.getParameter("bn_title");
            String bn_content = fuu.getParameter("bn_content");
            String bn_num = fuu.getParameter("bn_num");
            
            logger.info(bn_num + "" + bn_title + "" +bn_content + "");
            
            nvo.setBn_num(bn_num);
            nvo.setBn_title(bn_title);
            nvo.setBn_content(bn_content);
            nvo.setBn_image(bn_image);
            nvo.setBn_file(bn_file);
         

            VOPrintUtil.noticeVOPrint(nvo);
         
         }else{
            logger.info("multipart 수정 실패");
         }
      
         result = boardService.updateNotice(nvo);
         
         if(result == 1){
            logger.info("수정성공");
         }else{
            logger.info("수정실패");
         }
         
         String bn_num = nvo.getBn_num();
         
         return "redirect:" + "/board/searchNotice.td?bn_num=" + bn_num;
      }

      
   //공지사항 게시글 삭제하기
   @RequestMapping(value="/deleteNotice")
   public String deleteNotice(@ModelAttribute NoticeVO nvo, Model model){
      
      int result = 0;
      
      String hm_empnum = nvo.getHm_empnum();
      
      result = boardService.deleteNotice(nvo);
      
      if(result == 1){
         logger.info("삭제성공");
      }else{
         logger.info("삭제실패");
      }
      
      model.addAttribute("hm_empnum",hm_empnum);
      
      return "redirect:" + "/board/selectNotice.td";
   }

   
   //공지사항 확인 폼으로 이동하기
   @RequestMapping(value="/moveCheckNotice")
   public String moveCheckNotice(@ModelAttribute MemberVO mvo, NoticeVO nvo, Model model){
      logger.info("(log)BoardController.moveWriteNotice 시작 >>> ");
      List<MemberVO> mList = null;
      mList = boardService.selectWrite(mvo);
      
      List<NoticeVO> checkList = null;
      String bn_num = nvo.getBn_num();
      logger.info("bn_num >>> : " + bn_num);
      
      model.addAttribute("mList", mList);
      model.addAttribute("bn_num",bn_num);
      
   
      
      return "board/checkNotice";
   }
   
   
   //공지사항 게시글 확인
   @RequestMapping("/checkNotice")
   public String checkNotice(@ModelAttribute NoCheckVO ncvo, Model model){
      logger.info("(log)BoardController.checkNotice 시작 >>> ");
      logger.info("(log)BoardController.chaebunNoCheck 시작 >>> ");

      
      
      String bn_checknum = "";
      String message = "";
      List<NoCheckVO> list = null;
      
      list = boardService.chaebunNoCheck();
      
      NoCheckVO _ncvo = list.get(0);
      bn_checknum = _ncvo.getBn_checknum();
      bn_checknum = ChaebunUtils.cNum(bn_checknum, CHECK_GUBUN);
      logger.info(" bn_checknum >>> : " + bn_checknum);

      String bn_num   = ncvo.getBn_num();
      String hm_empnum = ncvo.getHm_empnum();
      String hm_name   = ncvo.getHm_name();
      String hm_deptnum = ncvo.getHm_deptnum();
      
      ncvo.setBn_num(bn_num);
      ncvo.setBn_checknum(bn_checknum);
      ncvo.setHm_deptnum(hm_deptnum);
      ncvo.setHm_name(hm_name);
      ncvo.setHm_empnum(hm_empnum);
      
      VOPrintUtil.noCheckVOPrint(ncvo);
      
      int iFlag = boardService.checkNotice(ncvo);
      
      if(iFlag == 1){
         
         message = hm_name + "님 해당 공지사항 확인 완료";
         
      }else if(iFlag == 0 ){
         message = hm_name + "님은 해당 공지사항을 이미 확인하셨습니다.";
      }else{
         message = "공지사항 확인 오류 발생";
      }
   
      model.addAttribute("message",message);
      System.out.println("iFlag >>> " + iFlag );

      logger.info("(log)BoardController.insertNotice 종료 ");
      
      return "board/checkNotice";
   }
   
   //공지사항 확인자 리스트 출력하기
   @RequestMapping(value="/checkList")
   public String checkList(@ModelAttribute NoCheckVO ncvo, Model model){
      logger.info("(log)BoardController.moveCheckList 시작  >>>");
      
      System.out.println(ncvo.getBn_num());
      
      List<NoCheckVO> cList = null;
      cList = boardService.checkList(ncvo);
      
      model.addAttribute("cList", cList);
      
      logger.info("(log)BoardController.moveCheckList 종료  >>>");
      return "board/checkListNotice";
   }
   
}//end of class