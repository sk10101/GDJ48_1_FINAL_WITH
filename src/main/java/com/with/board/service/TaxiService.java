package com.with.board.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.dao.TaxiDAO;
import com.with.board.dto.BoardDTO;

@Service
public class TaxiService {
	
	@Autowired TaxiDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

//	public ModelAndView taxiList(HttpSession session) {
//		// 모델앤뷰를 객체화 할때, 모델을 넘겨받는 jsp 명을 인자값에 넣어줄 수 있다. 
//		ModelAndView mav = new ModelAndView();
//		ArrayList<BoardDTO> list = dao.taxiList();
//		
//		// 리스트로 왔을 때 chkHit 세션을 제거해주는 코드
//		// 해당 코드가 있어야만 Detail 에 다시 접근했을 때 조회수 기능을 실행할 수 있다.
//		session.removeAttribute("chkHit");
//		
//		mav.addObject("list", list);
//		mav.setViewName("taxiBoard/TaxiList");
//		
//		return mav;
//	}
	public ModelAndView taxiListGo(HttpSession session) {
		
		ModelAndView mav = new ModelAndView("taxiBoard/TaxiList");

		// 리스트로 왔을 때 chkHit 세션을 제거해주는 코드
		// 해당 코드가 있어야만 Detail 에 다시 접근했을 때 조회수up 기능을 실행할 수 있다.
		session.removeAttribute("chkHit");
		
		// 마감시간과 비교하여 마감여부를 update 해주는 코드
		dao.updateEnd();
		
		return mav;
	}

	public HashMap<String, Object> taxiList(HashMap<String, String> params, HttpSession session) {
		
		String loginId = (String) session.getAttribute("loginId");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page= Integer.parseInt(params.get("page"));
		logger.info("보여줄 페이지 : "+ page);
		
		//총갯수(allCnt) / 페이지당 보여줄 갯수(cnt) = 생성 가능한 페이지(pages)
		int allCnt = dao.allCount(loginId);
		logger.info("allCnt:"+allCnt);
		int pages = allCnt%cnt > 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		
		if (page > pages) {
			page = pages;
		}
		
		map.put("pages", pages); //만들 수 있는 최대 페이지 수
		map.put("currPage", page); //현재 페이지
		
		// cnt 변경 시 선택된 현재페이지에 머무르는 방법 ?
		// 게시물(cnt) 5 > 85 페이지(page)
		// 게시물 10(cnt) > 43 페이지(page)
		
		int offset = (page-1)*cnt;
		logger.info("offset : " + offset);
		
		// 
		
		// page : cnt = offset
		//  1     10     0
		//  2     10     10
		//  3     10     20
		//  4     10     30
		//  5     10     40
		//  6     10     50
		
		ArrayList<BoardDTO> list = dao.taxiList(cnt,offset,loginId);
		map.put("taxiList", list);
		
		return map;
	}


	

}
