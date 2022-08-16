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
import com.with.member.service.MemberService;

@Controller
public class ApplyController {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired ApplyService service;
	@Autowired MemberService mbservice;
	
	@RequestMapping("/myGroupList.go") public String myGroup(Model model) {
		return "myPage/myGroupList"; 
	}
	
	
	
	// 내가 참가한 모임 페이지 이동
		@RequestMapping(value = "/myApplyList.go", method = RequestMethod.GET)
		public String myApplyList(HttpSession session) {

			return "redirect:/myApplyList?page="+1+"&option="+"&word=";
		}
	
		// 배달 참가 리스트 페이지 이동
		@RequestMapping(value = "/deliApplyList.go", method = RequestMethod.GET)
		public String deliApplyList(HttpSession session, @RequestParam String board_idx) {
			
			return "redirect:/deliApplyList?page="+1+"&board_idx="+board_idx+"&option="+"&word=";
		}
		// 택시 참가 리스트 페이지 이동
		@RequestMapping(value = "/taxiApplyList.go", method = RequestMethod.GET)
		public String taxiApplyList(HttpSession session) {
			
			return "redirect:/taxiApplyList?page="+1+"&option="+"&word=";
		}
		@RequestMapping(value = "/applyUpdate", method = RequestMethod.GET)
		public String applyUpdate(HttpSession session, @RequestParam HashMap<String, String> params) {
			logger.info(params.get("status"));
			logger.info(params.get("apply_idx"));
			String realstatus = params.get("status");
			if (realstatus == "1") {
				realstatus = "수락";
				}if(realstatus == "0") {
					realstatus = "거절";
				}
			params.put("realstatus", realstatus);
			return service.applyUpdate(params);
		}
		
		/*
		//배달 참여 신청자 목록
		@RequestMapping(value = "/totalApplyList.go", method = RequestMethod.GET)
		public String deliApplyList(HttpSession session) {
			
			return "redirect:/totalApplyList?page="+1+"&option="+"&word=";
		}
		*/
	
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
		
		String loginId = (String) session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		mav = service.myApplyList(params, loginId);
		return mav;
	}
	
	@RequestMapping(value = "/deliApplyList", method = RequestMethod.GET)
	public ModelAndView deliApplyList(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("배달 참가 목록 조회");
		session.removeAttribute("option");
		session.removeAttribute("word");
		
		// 검색어 저장을 위해 세션 활용
		if(params.get("word") != "") {
			session.setAttribute("option", params.get("option"));
			session.setAttribute("word", params.get("word"));
		}
		
		logger.info(params.get("category_id"));
		session.setAttribute("category_id", params.get("category_id"));
		session.setAttribute("board_idx", params.get("board_idx"));
		logger.info(params.get("board_idx"));
		
		//HashMap<String, Object> map = new HashMap<String, Object>();
//		map=mbservice.infoAll(, map);
		ModelAndView mav = new ModelAndView();
//		logger.info("map의 맛 : {}",map.get("avg_allAvg"));
//		mav.addObject("manner",map);
		mav = service.deliApplyList(params);
		return mav;
	}
	
	//택시 참가
	@RequestMapping(value = "/taxiApplyList", method = RequestMethod.GET)
	public ModelAndView taxiApplyList(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("택시 참가 목록 조회");
		session.removeAttribute("option");
		session.removeAttribute("word");
		
		// 검색어 저장을 위해 세션 활용
		if(params.get("word") != "") {
			session.setAttribute("option", params.get("option"));
			session.setAttribute("word", params.get("word"));
		}
		
		session.setAttribute("category_id", params.get("category_id"));
		logger.info(params.get("category_id"));
		ModelAndView mav = new ModelAndView();
		mav = service.taxiApplyList(params);
		return mav;
	}
	
	
	/*
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
	
*/
	
	
	
}
