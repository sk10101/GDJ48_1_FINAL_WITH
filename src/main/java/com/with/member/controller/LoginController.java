package com.with.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	  
	 //아이디 찾기 페이지로 이동
	  @RequestMapping(value="idFind")
	  public String idSearchForm(Model model) {
		  logger.info("아이디 찾기 페이지로 이동");
		  return "member/idFind";
	  }
	  
		
	  //아이디 찾기	 
		@RequestMapping("/idFind.ajax")
		@ResponseBody
		public String idFind(@RequestParam String name,@RequestParam String email) {
			logger.info("아이디 찾기 이름 : "+name);
			logger.info("아이디 찾기 이메일: "+email);
			return service.idFind(name,email);
		}	  
	  
		
	 //비밀번호 찾기 페이지로 이동
	  @RequestMapping(value="pwFind")
	  public String pwSearchForm(Model model) {
		  logger.info("비밀번호 찾기 페이지로 이동");
		  return "member/pwFind";
	  }	  
	  
	  //비밀번호 찾기 > 되면 수정 페이지로 이동 
		@RequestMapping("/pwFind.ajax")
		@ResponseBody
		public String pwFind(@RequestParam String id,@RequestParam String email) {
			logger.info("아이디 찾기 아이디: "+id);
			logger.info("아이디 찾기 이메일: "+email);
			return service.pwFind(id,email);
		}
		
	  
	  //비밀번호찾기-->비밀번호 수정페이지
		@RequestMapping(value="/newPw")
		public @ResponseBody HashMap<String, Object>
		  pwUpdate(@RequestParam HashMap<String,String> params) {
		  
		  BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		  logger.info("비밀번호 수정(컨트롤러)"); String pw = encoder.encode(params.get("pw"));
		  String id = params.get("id");
		  
		  boolean success = false; 
		  success = service.newPw(id, pw);
		  logger.info("비밀번호 찾기 여부 : " + success);
		  
		  HashMap<String, Object> map = new HashMap<String, Object>();
		  map.put("success", success); return map; 
		  }
		 
		
		
		  
		/*
		 * @RequestMapping(value="/idFind.do") public @ResponseBody HashMap<String,
		 * Object> idSearch(@RequestParam HashMap<String,String> params) {
		 * 
		 * logger.info("아이디찾기요청(컨트롤러)"); String userName = params.get("name"); String
		 * email = params.get("email");
		 * 
		 * String userId = service.idFind(userName, email);
		 * 
		 * logger.info("userId : " + userId); boolean success=false;
		 * 
		 * HashMap<String, Object> map = new HashMap<String, Object>();
		 * 
		 * if(userId == null) { userId = "해당 조건의 아이디를 찾을 수 없습니다."; map.put("success",
		 * success); map.put("userId", userId); }else { success = true;
		 * map.put("success", success); map.put("userId", userId); } return map; }
		 */
	  
	  
	  
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
