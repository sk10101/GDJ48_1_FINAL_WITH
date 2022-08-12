package com.with.history.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.dto.BoardDTO;
import com.with.history.dao.HistoryDAO;

@Service
public class HistoryService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired HistoryDAO dao;


//내가 만든 모임
	   public ModelAndView mygList(HashMap<String, String > params, String loginId) {
		      logger.info("내가 만든 목록 요청");
		      ModelAndView mav = new ModelAndView("myPage/myGroupList");
		      
		   // 페이징 처리
				HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
				int page = Integer.parseInt(params.get("page"));
				String option = params.get("option");
				String word = params.get("word");
				
				map.put("page", page); // page 입력
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
				
			
		      ArrayList<BoardDTO> mygList = pagination(map);
		      logger.info("게시글의 개수 : "+ mygList.size());
		      mav.addObject("mygList",mygList);
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
		
		ArrayList<BoardDTO> mygList = new ArrayList<BoardDTO>();
		
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
		
		mygList = dao.mygList(map);
		
	
		logger.info("페이징 체크포인트");
		return mygList;
	}
	
	
	



	
}
