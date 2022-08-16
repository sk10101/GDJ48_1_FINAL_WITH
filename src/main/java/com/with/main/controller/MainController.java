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
}
