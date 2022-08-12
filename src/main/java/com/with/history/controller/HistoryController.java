package com.with.history.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.with.history.service.HistoryService;

@Controller
public class HistoryController {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired HistoryService service;

	@RequestMapping("/myGroupList") public String sendHistory(Model model) { 
		return "myPage/myGroupList";
	}

	@RequestMapping("/myApplyList.go") public String myApply(Model model) {
		return "myPage/myApplyList"; 
	}

	

	//내가 만든 모임 목록 페이지 이동
	@RequestMapping(value = "/mygList.go", method = RequestMethod.GET)
	public String deliList(HttpSession session) {

		return "redirect:/mygList?page="+1+"&option="+"&word=";
	}


	@RequestMapping(value = "/mygList", method = RequestMethod.GET)
	public ModelAndView mygList(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("이용내역 목록 조회");
		session.removeAttribute("option");
		session.removeAttribute("word");
		
		// 검색어 저장을 위해 세션 활용
		if(params.get("word") != "") {
			session.setAttribute("option", params.get("option"));
			session.setAttribute("word", params.get("word"));
		}
		params.put("member_id", "일반회원");
		session.setAttribute("loginId", "일반회원"); 
		String loginId = (String) session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		mav = service.mygList(params, loginId);
		return mav;
	}
	
	



	@RequestMapping("/detail.go")
	public String BoardDetail(Model model, @RequestParam String board_idx, @RequestParam String category_id) {
		logger.info(category_id);
		logger.info(board_idx);
		String page = "";
		if(category_id.equals("배달게시판")){
			page = "redirect:/deliDetail?board_idx="+board_idx; 
		}else if (category_id.equals("밥게시판")){
			page = "redirect:/MealDetail?board_idx="+board_idx; 
		}else if(category_id.equals("택시게시판")){
			page = "redirect:/taxiDetail?board_idx="+board_idx;
		}
		return page;
	}

}
