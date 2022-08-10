package com.with.history.controller;

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
	
	 @RequestMapping("/") public String sendHistory(Model model) { return
	 "myPage/myGroupList"; }
	 
	  @RequestMapping("/myApplyList.go") public String myApply(Model model) {
	 return "myPage/myApplyList"; }
	 
	
	
	@RequestMapping(value = "/mygList", method = RequestMethod.GET)
	public ModelAndView mygList(HttpSession session) {
		int page = 1;
		String word = "제목";
		logger.info("이용내역 목록 조회");
		logger.info("현재 페이지 : "+page);
		session.setAttribute("loginId", "일반회원"); 
		String loginId = (String) session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		mav = service.mygList(loginId, page, word);
		return mav;
	}
	

	// 검색 목록 조회
	@RequestMapping(value = "/mygroupsearch", method = RequestMethod.GET)
	public ModelAndView mygroupsearch(HttpSession session, @RequestParam String option, @RequestParam String keyword) {
		
		logger.info("검색 목록 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		// 검색 하면 page = 1 로 되돌아 가기 위한 변수 생성
		logger.info(option+" : "+keyword+" 검색");
		
		mav = service.mygroupsearch(option, keyword);
		
		return mav;
	}	
	
	
	
	
	
	
	/*
	 * 
	 * @RequestMapping("/mygrouplist.ajax") public @ResponseBody HashMap<String,
	 * Object> mygrouplist(HttpSession session, @RequestParam HashMap<String,
	 * String> params) { logger.info("리스트 요청 : {}",params);
	 * 
	 * String loginId = "일반회원";
	 * 
	 * session.setAttribute("loginId", "일반회원"); params.put("member_id", loginId);
	 * 
	 * 
	 * //String loginId = (String) session.getAttribute("loginId");
	 * logger.info("로그인 아이디 : "+loginId); return service.mygrouplistajax(params,
	 * loginId); }
	 */
	
	
	
	
	
	
	
	/*
	@RequestMapping(value = "myPage/mygroupsearch.do")
	public ModelAndView mygroupsearch(
			@RequestParam String opt, 
			@RequestParam String keyword) {		
			logger.info(opt+" : "+keyword);
		return service.mygroupsearch(opt, keyword);
	}
	*/

	
	@RequestMapping("/detail.go")
	public String sendHistory(Model model, @RequestParam String board_idx, @RequestParam String category_id) {
		logger.info(category_id);
		String page = "배달게시판";
		if(category_id == "배달게시판"){
			page = "deliveryBoard/DeliDetail"; 
			}else if (category_id == "밥게시판"){
				page = "mealBoard/MealDetail"; 
			}else if(category_id == "택시게시판"){
				page = "taxiBoard/TaxiDetail";
				}
		return page;
	}
	
}
