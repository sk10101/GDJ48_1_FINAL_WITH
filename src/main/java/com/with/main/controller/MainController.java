package com.with.main.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	// 정상적으로 로그인을 했을 때 하는 메인페이지 이동 요청
	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String main() {
		return "main";
	}
}
