package com.with.main.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.with.main.service.MainService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MainController {
	
	@Autowired MainService service;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// 정상적으로 로그인을 했을 때 하는 메인페이지 이동 요청
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public ModelAndView main(HttpSession session) {
		logger.info("메인 페이지 접속");
		return service.main(session);
	}
	
	
	// 일반회원이 관리자 페이지에 접근을 시도했을 때 강제로 메인페이지로 보내버리도록 요청
	@RequestMapping(value = "/forcedMainGo", method = RequestMethod.GET)
	public String forcedMainGo(RedirectAttributes rAttr) {
		logger.info("일반회원이 관리자 페이지에 접근을 시도하여 메인페이지로 이동시킵니다.");
		rAttr.addFlashAttribute("msg","관리자만 이용가능한 페이지입니다.");
		
		return "redirect:/main";
	}
}
