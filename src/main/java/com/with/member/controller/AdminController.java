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
		
		return "redirect:/userList?page="+1;
	}
	
	//회원 목록 리스트
	@RequestMapping(value = "/userList")
	public ModelAndView userlist(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("유저 목록 조회");
		logger.info(params.get("page"));
		ModelAndView mav = new ModelAndView();
		mav = service.userList(params);
		return mav;
	}
	
	//관리자 목록 리스트
	@RequestMapping(value = "/adminList")
	public ModelAndView adminList(HttpSession session) {
		logger.info("관리자 목록 조회");
		ModelAndView mav = new ModelAndView();
		mav = service.adminList();
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
		return "redirect:/userList";
	}
	
	//관리자 ID검색 
	@RequestMapping(value = "/search.do")
	public ModelAndView search(HttpSession session, @RequestParam String name) {
		logger.info(name+" : 관리자ID검색 요청");
		return service.search(name);
	}
	
	//회원 목록 검색 리스트
	@RequestMapping(value = "/usersearch.do")
	public ModelAndView usersearch(HttpSession session, @RequestParam String opt, @RequestParam String keyword) {
		logger.info("유저 목록 검색");
		logger.info(opt+" : "+keyword+" 검색");
		return service.usersearch(opt, keyword);
	}
	
	
	
}
