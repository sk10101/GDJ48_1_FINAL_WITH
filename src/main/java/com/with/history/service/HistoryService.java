package com.with.history.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.history.dao.HistoryDAO;
import com.with.history.dto.HistoryDTO;

@Service
public class HistoryService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired HistoryDAO dao;

	public HashMap<String, Object> mygrouplist(HashMap<String, String> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String loginId = params.get("id");
		logger.info("보여줄 페이지 : " + page);
		
		int allCnt = dao.sendallCount(loginId);
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
		
		logger.info("offset : " + offset);
		ArrayList<HistoryDTO> mygrouplist = dao.mygrouplist(cnt, offset, loginId);
		map.put("msgsendlist", mygrouplist);
		return map;
		
		}
}
