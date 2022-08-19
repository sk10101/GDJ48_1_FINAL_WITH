package com.with.report.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.with.report.service.PenaltyService;

@Controller
public class PenaltyController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired PenaltyService service;
	
	//제한내역리스트가기
	@RequestMapping(value = "/penaltyList.go", method = RequestMethod.GET)
	public String penaltylists(HttpSession session) {
		
		return "redirect:/penaltyList?page="+1+"&word=";
	}
	
	//이용제한내역 리스트
	@RequestMapping(value = "/penaltyList")
	public ModelAndView penaltyList(HttpSession session, @RequestParam HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView();
		logger.info("이용제한내역 리스트 조회");
		String loginId = (String) session.getAttribute("loginId");
		session.removeAttribute("word");
		
		if(params.get("word") != "") {
			session.setAttribute("word", params.get("word"));
		}
		logger.info(params.get("page"));
		logger.info("로그인 아이디 : "+loginId);
		params.put("loginId", loginId);
		mav = service.penaltyList(params);
		return mav;
	}
	
	//이용제한회원 상세보기
	@RequestMapping(value = "/penaltydetail")
	public ModelAndView penaltdetail(HttpSession session, @RequestParam String penalty_idx) {
		logger.info("이용제한 상세보기");
		return service.penaltydetail(penalty_idx);
	}
	
	//이용제한 해제
	@RequestMapping(value = "/update.do")
	public ModelAndView update(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("이용제한 해제");
		String loginId = (String) session.getAttribute("loginId");
		params.put("loginId", loginId);
		return service.update(params);
	}
	
	
}
