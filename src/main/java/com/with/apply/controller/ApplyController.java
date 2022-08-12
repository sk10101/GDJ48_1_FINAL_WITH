package com.with.apply.controller;

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

import com.with.apply.service.ApplyService;

@Controller
public class ApplyController {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired ApplyService service;
	
	@RequestMapping("/myGroupList.go") public String myGroup(Model model) {
		return "myPage/myGroupList"; 
	}
	
	
	
	// 내가 참가한 모임 페이지 이동
		@RequestMapping(value = "/myApplyList.go", method = RequestMethod.GET)
		public String myApplyList(HttpSession session) {

			return "redirect:/myApplyList?page="+1+"&option="+"&word=";
		}
	
		//배달 참여 신청자 목록
		@RequestMapping(value = "/totalApplyList.go", method = RequestMethod.GET)
		public String deliApplyList(HttpSession session) {
			
			return "redirect:/totalApplyList?page="+1+"&option="+"&word=";
		}
		
	
	@RequestMapping(value = "/myApplyList", method = RequestMethod.GET)
	public ModelAndView myApplyList(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("이용내역 목록 조회");
		session.removeAttribute("option");
		session.removeAttribute("word");
		
		// 검색어 저장을 위해 세션 활용
		if(params.get("word") != "") {
			session.setAttribute("option", params.get("option"));
			session.setAttribute("word", params.get("word"));
		}
		params.put("member_id", "son");
		session.setAttribute("loginId", "son"); 
		String loginId = (String) session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		mav = service.myApplyList(params, loginId);
		return mav;
	}
	
	@RequestMapping(value = "/totalApplyList", method = RequestMethod.GET)
	public ModelAndView totalApplyList(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("참여 신청자 조회");
		session.removeAttribute("option");
		session.removeAttribute("word");
		
		// 검색어 저장을 위해 세션 활용
		if(params.get("word") != "") {
			session.setAttribute("option", params.get("option"));
			session.setAttribute("word", params.get("word"));
		}
		
		//params.put("member_id", "son");
		//session.setAttribute("loginId", "son"); 
		//String loginId = (String) session.getAttribute("loginId");
		
		
		logger.info(params.get("category_id"));
		session.setAttribute("category_id", params.get("category_id"));
		ModelAndView mav = new ModelAndView();
		mav = service.totalApplyList(params);
		return mav;
	}
	

	
	
	
}
