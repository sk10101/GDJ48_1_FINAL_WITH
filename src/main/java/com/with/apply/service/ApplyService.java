package com.with.apply.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.apply.dao.ApplyDAO;
import com.with.board.dto.BoardDTO;

@Service
public class ApplyService {

Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired ApplyDAO dao;
	
	//내가 참가한 모임
	public ModelAndView myApplyList(HashMap<String, String> params, String loginId) {
			logger.info("내가 참여한 목록 요청");
		   ModelAndView mav = new ModelAndView("redirect:/myApplyList");
		   
		   // 페이징 처리
		   HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
		   int page = Integer.parseInt(params.get("page"));
		   String option = params.get("option");
		   String word = params.get("word");
		  
		   
		   map.put("page", page); // page 입력
		   map.put("loginId", loginId);
		   // 검색어를 입력했을 때
		   if(word != "") {   
               if(word.indexOf("모집")== 0 || word.indexOf("모") == 0 || word.indexOf("모집중") == 0) {
                  word = "0";
               }else if(word.indexOf("마")== 0 || word.indexOf("마감")== 0) {
                  word = "1";
               }
			   
			   map.put("word", word); // 검색어 입력
			   map.put("option", option); // 검색 옵션 입력
		   }
		   
		   
		   ArrayList<BoardDTO> myApplyList = pagination(map);
		   logger.info("게시글의 개수 : "+ myApplyList.size());
		   mav.addObject("myApplyList",myApplyList);
		   mav.addObject("map",map);
		   
		   return mav;
		
	}
	
	private ArrayList<BoardDTO> pagination(HashMap<String, Object> map) {
		int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
		
		int page = (int) map.get("page");
		String option = (String) map.get("option");
		String word = (String) map.get("word");
		
		logger.info("보여줄 페이지 : " + map.get("page"));
		logger.info("검색 옵션 / 검색어 : " + map.get("option") + " / " + map.get("word"));
		
		ArrayList<BoardDTO> myApplyList = new ArrayList<BoardDTO>();
		
		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = 0;
		// 한 페이지에 보여줄 게시글의 수 map 에 입력
		map.put("cnt", cnt);
		ArrayList<BoardDTO> allCount = dao.allCount(map);
		allCnt = allCount.size();
		logger.info("allCnt : " + allCnt);
		
		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if(allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			allCnt = 1;
		}
		
	
		
		int pages = allCnt%cnt != 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		logger.info("pages : " + pages);
		
		if (page > pages) {
			page = pages;
		}
		
		map.put("pages", pages); // 최대 페이지 수
		int offset = cnt * (page-1);
		logger.info("offset : "+offset);
		
		map.put("offset", offset);
		map.put("currPage", page); // 현재 페이지
		
		myApplyList = dao.myApplyList(map);
		
	
		logger.info("페이징 체크포인트");
		return myApplyList;
	}

	
	
	
	//배달 신청자 리스트 
		public ModelAndView deliApplyList(HashMap<String, String> params) {
				logger.info("배달 참가 목록 요청");
			   ModelAndView mav = new ModelAndView("myPage/deliApplyList");
			   
			   // 페이징 처리
			   HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
			   int page = Integer.parseInt(params.get("page"));
			   String option = params.get("option");
			   String word = params.get("word");
			   String board_idx = params.get("board_idx");
			   logger.info(board_idx);

			   map.put("board_idx", board_idx);
			   map.put("page", page); // page 입력
			   // 검색어를 입력했을 때
			   if(word != "" && word != " ") {
					map.put("word", word); // 검색어 입력
					map.put("option", option); // 검색 옵션 입력
				}
		
			   ArrayList<BoardDTO> deliApplyList = delipagination(map);
			   logger.info("게시글의 개수 : "+ deliApplyList.size());
			   mav.addObject("deliApplyList",deliApplyList);
			   mav.addObject("map",map);
			 
			   return mav;
			
		}
		
		
		
		private ArrayList<BoardDTO> delipagination(HashMap<String, Object> map) {
			int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
			
			int page = (int) map.get("page");
			String option = (String) map.get("option");
			String word = (String) map.get("word");
			
			logger.info("배달 보여줄 페이지 : " + map.get("page"));
			logger.info("검색 옵션 / 검색어 : " + map.get("option") + " / " + map.get("word"));
			
			ArrayList<BoardDTO> deliApplyList = new ArrayList<BoardDTO>();
			
			// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
			int allCnt = 0;
			// 한 페이지에 보여줄 게시글의 수 map 에 입력
			map.put("cnt", cnt);
			ArrayList<BoardDTO> deliallCount = dao.deliallCount(map);
			allCnt = deliallCount.size();
			logger.info("allCnt : " + allCnt);
			
			// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
			if(allCnt == 0) {
				// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
				allCnt = 1;
			}
			
		
			
			int pages = allCnt%cnt != 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
			logger.info("pages : " + pages);
			
			if (page > pages) {
				page = pages;
			}
			
			map.put("pages", pages); // 최대 페이지 수
			int offset = cnt * (page-1);
			logger.info("offset : "+offset);
			
			map.put("offset", offset);
			map.put("currPage", page); // 현재 페이지
			
			deliApplyList = dao.deliApplyList(map);
			
			
			
			
			logger.info("페이징 체크포인트");
			return deliApplyList;
		}

		//택시참가
		public ModelAndView taxiApplyList(HashMap<String, String> params) {
			logger.info("택시 참가 목록 요청");
			   ModelAndView mav = new ModelAndView("myPage/taxiApplyList");
			   
			   // 페이징 처리
			   HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
			   int page = Integer.parseInt(params.get("page"));
			   String option = params.get("option");
			   String word = params.get("word");
			   String board_idx = params.get("board_idx");
			   logger.info(board_idx);

			   map.put("board_idx", board_idx);
			   map.put("page", page); // page 입력
			   // 검색어를 입력했을 때
			   if(word != "" && word != " ") {
					map.put("word", word); // 검색어 입력
					map.put("option", option); // 검색 옵션 입력
				}
		
			   ArrayList<BoardDTO> taxiApplyList = taxipagination(map);
			   logger.info("게시글의 개수 : "+ taxiApplyList.size());
			   mav.addObject("taxiApplyList",taxiApplyList);
			   mav.addObject("map",map);
			   
			   return mav;
		}
	
	

		private ArrayList<BoardDTO> taxipagination(HashMap<String, Object> map) {
			int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
			
			logger.info("테스트");
			
			int page = (int) map.get("page");
			String option = (String) map.get("option");
			String word = (String) map.get("word");
			
			logger.info("배달 보여줄 페이지 : " + map.get("page"));
			logger.info("검색 옵션 / 검색어 : " + map.get("option") + " / " + map.get("word"));
			
			ArrayList<BoardDTO> taxiApplyList = new ArrayList<BoardDTO>();
			
			// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
			int allCnt = 0;
			// 한 페이지에 보여줄 게시글의 수 map 에 입력
			map.put("cnt", cnt);
			ArrayList<BoardDTO> taxiallCount = dao.taxiallCount(map);
			allCnt = taxiallCount.size();
			logger.info("allCnt : " + allCnt);
			
			// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
			if(allCnt == 0) {
				// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
				allCnt = 1;
			}
			
		
			
			int pages = allCnt%cnt != 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
			logger.info("pages : " + pages);
			
			if (page > pages) {
				page = pages;
			}
			
			map.put("pages", pages); // 최대 페이지 수
			int offset = cnt * (page-1);
			logger.info("offset : "+offset);
			
			map.put("offset", offset);
			map.put("currPage", page); // 현재 페이지
			
			taxiApplyList = dao.taxiApplyList(map);
			
		
			logger.info("페이징 체크포인트");
			return taxiApplyList;
		}

		public ModelAndView applyUpdate(HashMap<String, String> params) {
			String board_idx = params.get("board_idx");
			
			ModelAndView mav = new ModelAndView("redirect:/deliApplyList?page="+1+"&board_idx="+board_idx+"&option="+"&word=");
			dao.applyUpdate(params);
			return mav;
			
		}
		public ModelAndView taxiApplyUpdate(HashMap<String, String> params) {
			String board_idx = params.get("board_idx");
			
			ModelAndView mav = new ModelAndView("redirect:/taxiApplyList?page="+1+"&board_idx="+board_idx+"&option="+"&word=");
			dao.taxiApplyUpdate(params);
			return mav;
			
		}
		
		
		
		
		
		
		
		
		// 현수 밥 추가요----------------------------------------------------------
		public ModelAndView mealApplyList(HashMap<String, String> params) {
			logger.info("밥 참가 목록 요청");
			   ModelAndView mav = new ModelAndView("myPage/mealApplyList");
			   
			   // 페이징 처리
			   HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
			   int page = Integer.parseInt(params.get("page"));
			   String option = params.get("option");
			   String word = params.get("word");
			   String board_idx = params.get("board_idx");
			   logger.info(board_idx);

			   map.put("board_idx", board_idx);
			   map.put("page", page); // page 입력
			   // 검색어를 입력했을 때
			   if(word != "" && word != " ") {
					map.put("word", word); // 검색어 입력
					map.put("option", option); // 검색 옵션 입력
				}
		
			   ArrayList<BoardDTO> mealApplyList = mealpagination(map);
			   logger.info("게시글의 개수 : "+ mealApplyList.size());
			   mav.addObject("mealApplyList",mealApplyList);
			   mav.addObject("map",map);
			   
			   return mav;
		}

		private ArrayList<BoardDTO> mealpagination(HashMap<String, Object> map) {
			int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
			
			int page = (int) map.get("page");
			String option = (String) map.get("option");
			String word = (String) map.get("word");
			
			logger.info("밥 보여줄 페이지 : " + map.get("page"));
			logger.info("검색 옵션 / 검색어 : " + map.get("option") + " / " + map.get("word"));
			
			ArrayList<BoardDTO> mealApplyList = new ArrayList<BoardDTO>();
			
			// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
			int allCnt = 0;
			// 한 페이지에 보여줄 게시글의 수 map 에 입력
			map.put("cnt", cnt);
			ArrayList<BoardDTO> mealCount = dao.mealCount(map);
			allCnt = mealCount.size();
			logger.info("allCnt : " + allCnt);
			
			// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
			if(allCnt == 0) {
				// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
				allCnt = 1;
			}
			
		
			int pages = allCnt%cnt != 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
			logger.info("pages : " + pages);
			
			if (page > pages) {
				page = pages;
			}
			
			map.put("pages", pages); // 최대 페이지 수
			int offset = cnt * (page-1);
			logger.info("offset : "+offset);
			
			map.put("offset", offset);
			map.put("currPage", page); // 현재 페이지
			
			mealApplyList = dao.mealApplyList(map);
			

			logger.info("페이징 체크포인트");
			return mealApplyList;
		}

		
	
	
	
	
	
	
	
	
	/*
	public ModelAndView totalApplyList(HashMap<String, String> params) {
		logger.info("참가 신청 목록 조회 서비스");
		
		String category_id = "";
		if(params.get("category_id") != null) {
			if(params.get("category_id").equals("배달게시판")) {
				category_id = params.get("category_id");
			}else if(params.get("category_id").equals("밥게시판")) {
				category_id = params.get("category_id");
			}else if(params.get("category_id").equals("택시게시판")) {
				category_id = params.get("category_id");
			}
		}

		String pagePath = "";
		if(category_id.equals("배달게시판")) {
			pagePath = "myPage/deliApplyList";
		}else if (category_id.equals("밥게시판")) {
			pagePath = "myPage/mealApplyList";
		}else if (category_id.equals("택시게시판")) {
			pagePath = "myPage/taxiApplyList";
		}
		ModelAndView mav = new ModelAndView(pagePath);
		
		// 페이징 처리
		HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		logger.info(params.get("category_id"));
		
		map.put("category_id",category_id);
		map.put("page", page); // page 입력
		// 검색어를 입력했을 때
		if(word != "") {
			map.put("word", word); // 검색어 입력
			if(category_id.equals("category_id")) {
				map.put("option", option); // 검색 옵션 입력
			}
		}
		ArrayList<BoardDTO> userList = pagination(map);
		logger.info("일반 회원 인원 : "+ userList.size());
		mav.addObject("list", userList);	
		mav.addObject("map",map);
		return null;
	}
	*/
}
