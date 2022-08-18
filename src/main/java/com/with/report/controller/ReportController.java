package com.with.report.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.with.report.service.ReportService;


@Controller
public class ReportController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired ReportService service;
	
	@RequestMapping(value = "/reportList.go", method = RequestMethod.GET)
	public String userlist(HttpSession session) {
		
		return "redirect:/reportList?page="+1+"&option=''"+"&word=''";
	}
	
	//신고내역 조회
	@RequestMapping(value = "/reportList")
	public ModelAndView reportlist(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("신고내역 리스트 조회");
		String loginId = (String) session.getAttribute("loginId");
		session.removeAttribute("option");
		session.removeAttribute("word");
		
		if(params.get("word") != "") {
			session.setAttribute("option",params.get("option")); 
			session.setAttribute("word", params.get("word"));
			}

		logger.info("로그인 아이디: "+loginId);
		params.put("loginId", loginId);
		ModelAndView mav = new ModelAndView();
		mav = service.reportlist(params);
		return mav;
	}
	
	//신고 내역 폼 이동
	@RequestMapping(value = "/reportWrite.go")
	public String report() {
		logger.info("신고하기 페이지");
		return "admin/reportWrite";
	}
	
	//신고 하기
	@RequestMapping(value = "/reportsend", method = RequestMethod.GET)
	public ModelAndView reportsend(HttpSession session, @RequestParam HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView();
		logger.info(params.get("board_idx")+"번 게시글"+params.get("check")+"신고하기"+params.get("textbox"));
		logger.info("로그인 아이디 : "+ session.getAttribute("loginId"));
		params.put("loginId", (String) session.getAttribute("loginId"));
		mav = service.reportsend(params);
		return mav;
	}
	
	//신고 내역 상세보기
	@RequestMapping(value = "/reportDetail")
	public ModelAndView reportdetail(HttpSession session, @RequestParam String report_idx) {
		logger.info(report_idx+" 번 신고내역 상세보기");
		ModelAndView mav = new ModelAndView();
		mav = service.reportdetail(report_idx);
		return mav;
	}
	
	//신고 처리
	@RequestMapping(value = "/reportcom", method = RequestMethod.GET)
	public String reportcom(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("신고처리");
		logger.info("로그인 아이디 : "+session.getAttribute("loginId"));
		params.put("loginId", (String) session.getAttribute("loginId"));
		return service.reportcom(params);
	}
	
	
}
