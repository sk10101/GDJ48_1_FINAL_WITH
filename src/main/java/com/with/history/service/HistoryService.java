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
/*
	public HashMap<String, Object> mygrouplistajax(HashMap<String, String> params, String loginId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		logger.info("보여줄 페이지 : " + page);
		
		int allCnt = dao.allCount();
		logger.info("allCnt:" + allCnt);
		
		int pages = allCnt%cnt > 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		logger.info("pages : " + pages);
		
		//currPage = pages
		//currPage가 pages보다 크면 currPage를 pages로 맞춰준다?
		if(page > pages) {
			page = pages;
		}
		map.put("pages", pages);		//만들 수 있는 최대 페이지 수
		map.put("currPage", page); //현재 페이지

		int offset = (page-1) * cnt;
		if(offset == -5) {
	         offset = 5;
	      }
		logger.info("offset : " + offset);
		ArrayList<BoardDTO> mygrouplist = dao.mygrouplistajax(cnt, offset, loginId);
		ArrayList<BoardDTO> mygrouplist1 = dao.mygrouplistajax1(cnt, offset, loginId);
		
		logger.info("mygrouplist : {}", map.size());
		map.put("mygrouplist", mygrouplist);
		map.put("mygrouplist1", mygrouplist);
		return map;
		
		}
		
		*/
/*
	public ModelAndView mygroupsearch(String opt, String keyword) {
		ModelAndView mav = new ModelAndView("myglist");
		ArrayList<BoardDTO> myglist = dao.mygroupsearch(opt, keyword);
		mav.addObject("mygroupsearch", myglist);		
		return mav;
	}
	/*
	 public ModelAndView usersearch(String opt, String keyword) {
	      ModelAndView mav = new ModelAndView("admin/userList");
	      if(opt.equals("certficate") && (keyword.equals("n") || keyword.equals("N"))) {
	         keyword = "0";
	      } else if(opt.equals("certficate") && (keyword.equals("y") || keyword.equals("Y"))) {
	         keyword = "1";
	      }
	      ArrayList<MemberDTO> list = dao.usersearch(opt, keyword);
	      mav.addObject("list", list);
	      return mav;
	   }
*/

	   public ModelAndView mygList(HashMap<String, String > params, String loginId) {
		      logger.info("이용 내역 목록 요청");
		      ModelAndView mav = new ModelAndView("myPage/myGroupList");
		      
		   // 페이징 처리
				HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
				int page = Integer.parseInt(params.get("page"));
				String option = params.get("option");
				String word = params.get("word");
				
				map.put("page", page); // page 입력
				// 검색어를 입력했을 때
				if(word != "") {
					map.put("word", word); // 검색어 입력
					map.put("option", option); // 검색 옵션 입력
				}
				
				//공통 컬럼 테이블에 작성할 내용
		      ArrayList<BoardDTO> mygList = dao.mygList(loginId, map);
		      //신청 테이블
		      ArrayList<BoardDTO> mygList1 = dao.mygList1(loginId, map);
		      
		      ArrayList<BoardDTO> mygList2 = pagination(map);
		      logger.info("게시글의 개수 : "+ mygList.size());
		      mav.addObject("mygList",mygList);
		      mav.addObject("mygList1",mygList1);
		      mav.addObject("mygList2",mygList2);
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
		
		ArrayList<BoardDTO> mygList2 = new ArrayList<BoardDTO>();
		
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
		
		mygList2 = dao.mygList2(map);
		
		logger.info("페이징 체크포인트");
		return mygList2;
	}
	
	
	



	
}
