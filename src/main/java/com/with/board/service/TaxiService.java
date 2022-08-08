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

	public ModelAndView taxiList(HttpSession session) {
		// 모델앤뷰를 객체화 할때, 모델을 넘겨받는 jsp 명을 인자값에 넣어줄 수 있다. 
		ModelAndView mav = new ModelAndView();
		ArrayList<BoardDTO> list = dao.taxiList();
		
		// 리스트로 왔을 때 chkHit 세션을 제거해주는 코드
		// 해당 코드가 있어야만 Detail 에 다시 접근했을 때 조회수 기능을 실행할 수 있다.
		session.removeAttribute("chkHit");
		
		mav.addObject("list", list);
		mav.setViewName("taxiBoard/TaxiList");
		
		return mav;
	}

	public HashMap<String, Object> list(HashMap<String, String> params) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page= Integer.parseInt(params.get("page"));
		logger.info("보여줄 페이지 : "+ page);
		
		//총갯수(allCnt) / 페이지당 보여줄 갯수(cnt) = 생성 가능한 페이지(pages)
		int allCnt = dao.allCount();
		logger.info("allCnt:"+allCnt);
		int pages = allCnt%cnt > 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		
		if (page > pages) {
			page = pages;
		}
		
		map.put("pages", pages); //만들 수 있는 최대 페이지 수
		map.put("currPage", page); //현재 페이지
		
		return map;
	}

	

}
