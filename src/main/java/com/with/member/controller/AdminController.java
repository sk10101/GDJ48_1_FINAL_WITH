package com.with.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.parsing.GenericTokenParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.DefaultParameterNameDiscoverer;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.with.member.service.AdminService;

@Controller
public class AdminController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired AdminService service;
	
	@RequestMapping(value = "/userList.go", method = RequestMethod.GET)
	public String userlist(HttpSession session) {
		
		return "redirect:/userList?page="+1+"&option=''"+"&word=''";
	}
	
	//회원 목록 리스트
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public ModelAndView userlist(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("유저 목록 조회");
		session.removeAttribute("option");
		session.removeAttribute("word");
		session.removeAttribute("member_classs");

		String loginId = (String) session.getAttribute("loginId");
		
		logger.info("로그인 아이디 : "+loginId);
		
		if(params.get("word") != "") {
			session.setAttribute("option",params.get("option")); 
			session.setAttribute("word", params.get("word"));
			session.setAttribute("member_classs", params.get("member_class"));
			}
		
		params.put("loginId", loginId);
		ModelAndView mav = new ModelAndView();
		mav = service.userList(params);
		return mav;
	}
	
	//회원 상세보기
	@RequestMapping(value = "userDetail")
	public ModelAndView userDetail(HttpSession session, @RequestParam String member_id) {
		logger.info("회원 상세보기 요청");
		ModelAndView mav = new ModelAndView();
		mav = service.userDetail(member_id);
		
		return mav;
	}
	
	//대학교 인증 처리
	@RequestMapping(value = "pass")
	public String  pass(HttpSession session, @RequestParam String member_id) {
		logger.info(member_id+"회원 대학교 인증 요청");
		service.pass(member_id);
		return "redirect:/userList.go";
	}
	
	
}
