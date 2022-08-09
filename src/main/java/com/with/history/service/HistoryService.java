package com.with.history.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.board.dto.BoardDTO;
import com.with.history.dao.HistoryDAO;

@Service
public class HistoryService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired HistoryDAO dao;

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
/*
	public ModelAndView myglist(String opt, String keyword) {
		ArrayList<HistoryDTO> myglist = dao.myglist(opt, keyword);
		ModelAndView mav = new ModelAndView("myglist");
		mav.addObject("myglist", myglist);		
		return mav;
	}
*/
}
