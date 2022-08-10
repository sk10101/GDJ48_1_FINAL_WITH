package com.with.history.service;

import java.util.ArrayList;

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

	public ModelAndView mygList(String loginId) {
		logger.info("게시글 목록 요청");
		ModelAndView mav = new ModelAndView("myPage/myGroupList");
		
		ArrayList<BoardDTO> mygList = dao.mygList(loginId);
		ArrayList<BoardDTO> mygList1 = dao.mygList1(loginId);
		logger.info("게시글의 개수 : "+ mygList.size());
		mav.addObject("mygList",mygList);
		mav.addObject("mygList1",mygList1);
		
		return mav;
	}

	
}
