package com.with.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.with.member.dto.MemberDTO;
import com.with.member.service.LoginService;

@Controller
/* @RequestMapping(value="/member/*") */ 
public class LoginController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired LoginService service;
	
	//로그인 페이지 이동
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginForm() {		
		return "member/login";
	}
	
	//로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, Model model) {		
		logger.info("로그인 하기");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		String loginId = service.login(id, pw);
		
		String msg = "아이디 혹은 비밀번호가 틀렸습니다";
		String page = "login";
		
		if(loginId != null ) {
			HttpSession session = request.getSession();
			session.setAttribute("loginId", loginId);
			msg = loginId + "님 환영합니다";			
			page = "redirect:/";			
		} else {			
			model.addAttribute("msg", msg);
			logger.info("로그인 실패");
		}
		
	
		return page;
	}

}
