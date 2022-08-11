package com.with.member.controller;

import java.util.HashMap;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.with.member.dto.KakaoDTO;
import com.with.member.dto.MemberDTO;
import com.with.member.service.LoginService;

@Controller
public class LoginController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired LoginService service;
	
	@Autowired
	private HttpSession session;
	
	//로그인 페이지 이동
	@RequestMapping(value = {"/login","/"}, method = RequestMethod.GET)
	public String loginForm() {		
		return "member/login";
	}
	
	//로그인
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(HttpServletRequest request, Model model, HttpSession session) {		
		logger.info("로그인 하기");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDTO loginDto = service.login(id, pw);
		String loginId = loginDto.getMember_id();
		String member_class = loginDto.getMember_class();  
		
		logger.info("로그인한 아이디 : "+ loginId);
		logger.info("회원등급 : "+ member_class);
		
		String msg = "아이디 혹은 비밀번호가 틀렸습니다";
		String page = "member/login";
		
		if(loginId != null && member_class != null) {
			session.setAttribute("loginId", loginId);
			session.setAttribute("member_class", member_class);
			
			msg = loginId + " (" + member_class + ") 님 환영합니다";			
			page = "main";			
		} else {			
			model.addAttribute("msg", msg);
			logger.info("로그인 실패");
		}
		
	
		return page;
	}

	
	  //로그아웃
	  @RequestMapping(value="logout", method=RequestMethod.GET)
	  public String logout(HttpSession session) { 
		  session.invalidate(); 
		  return "redirect:/login"; 
		  }
	 
	  // 카카오 로그인 토큰 받기
		@RequestMapping(value="/kakaoLogin", method=RequestMethod.GET)
		public String kakaoLogin(@RequestParam(value = "code", required = false) String code, Model model) throws Exception{
	        System.out.println("#########" + code);
	        String access_Token = service.getAccessToken(code);
	        KakaoDTO userInfo = service.getUserInfo(access_Token);
	        KakaoDTO number = service.kakaoNumber(userInfo);
	        session.invalidate();
	        session.setAttribute("kakaoN", userInfo.getK_name());
	        session.setAttribute("kakaoE", userInfo.getK_email());
	        session.setAttribute("kakaoNumber", number.getK_number());
	        return "member/memberMain";
	    }
		
		// 로그인 api 용 Main
		@RequestMapping(value="Main", method=RequestMethod.GET)
		public String Main(){
			return "member/memberMain";
		}
		
	  
	  
	  
	  
	
}
