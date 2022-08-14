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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


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
	public String loginForm(HttpServletRequest request,RedirectAttributes rAttr) {
		
		return "member/login";
	}
	
	//로그인
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(HttpServletRequest request, Model model, HttpSession session, RedirectAttributes rAttr) {		
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
			rAttr.addFlashAttribute("msg",msg);
			page = "redirect:/main";			
		} else {			
			model.addAttribute("msg", msg);
			logger.info("로그인 실패");
		}
		
	
		return page;
	}

	
	  //로그아웃
	  @RequestMapping(value="logout", method=RequestMethod.GET)
	  public String logout(HttpSession session, RedirectAttributes rAttr) { 
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
      @RequestMapping("/pwfind.do")
      public ModelAndView pwFind(@RequestParam String id,@RequestParam String email) {
         ModelAndView mav = new ModelAndView();
    	 logger.info("아이디 찾기 아이디: "+id);
         logger.info("아이디 찾기 이메일: "+email);
         String pw = service.pwFind(id,email);
         mav.addObject("id",id);
         logger.info("id 값 : "+id);
         mav.addObject("pw",pw);
         logger.info("pw 값 : "+pw);
         mav.setViewName("member/newPw");
         return mav;
      }
	  
	  //비밀번호찾기-->비밀번호 수정페이지
		@RequestMapping(value="/newPw")
		public String newPw(Model model, @RequestParam String id, @RequestParam String pw) {
		  BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		  logger.info("비밀번호 수정(컨트롤러)");
		  logger.info("현재 ID : "+id);
		  logger.info("현재 PW : "+pw);
		  String newpw = encoder.encode(pw);
		  logger.info("새로운 암호화 PW : "+newpw);
		  boolean success = false; 
		  success = service.newPw(id,newpw);
		  logger.info("비밀번호 찾기 여부 : " + success);
		  model.addAttribute("pwmsg",success);
		  return "/member/login"; 
		  }
		 

			/* //일시 중단...
			 * // 카카오 로그인 토큰 받기
			 * 
			 * @RequestMapping(value="/kakaoLogin", method=RequestMethod.GET) public String
			 * kakaoLogin(@RequestParam(value = "code", required = false) String code, Model
			 * model) throws Exception{ System.out.println("#########" + code); String
			 * access_Token = service.getAccessToken(code); KakaoDTO userInfo =
			 * service.getUserInfo(access_Token); KakaoDTO number =
			 * service.kakaoNumber(userInfo); session.invalidate();
			 * session.setAttribute("kakaoN", userInfo.getK_name());
			 * session.setAttribute("kakaoE", userInfo.getK_email());
			 * session.setAttribute("kakaoNumber", number.getK_number()); return
			 * "member/memberMain"; }
			 */
		
			/*
			 * // 로그인 api 용 Main
			 * 
			 * @RequestMapping(value="Main", method=RequestMethod.GET) public String Main(){
			 * return "member/memberMain"; }
			 */
		
	  
		// 로그인한 사용자가 이용제한을 받고 있는 중일 때 Interceptor 에서 보내는 요청
		@RequestMapping(value = "penaltyLogout", method = RequestMethod.GET)
		public String penaltyLogout(RedirectAttributes rAttr, @RequestParam String chkPenalty) {
			session.invalidate();
			logger.info("이용제한회원이기 때문에 강제 로그아웃 처리합니다.");
			rAttr.addFlashAttribute("msg","현재 "+chkPenalty+ " 까지 이용제한 중인 계정입니다.");
			// String msg = "현재 "+chkPenalty+ " 까지 이용제한 중인 계정입니다.";
			return "redirect:/login";
		}
	  
	  
	
}
