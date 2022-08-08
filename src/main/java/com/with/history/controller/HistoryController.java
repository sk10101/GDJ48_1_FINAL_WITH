package com.with.history.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.with.history.service.HistoryService;

@Controller
public class HistoryController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
    
	@Autowired HistoryService service;
	
	@RequestMapping("/")
	public String sendHistory(Model model) {
		return "myPage/myGroupList";
	}
	
	@RequestMapping("/mygrouplist.ajax")
    @ResponseBody
    public HashMap<String, Object> mygrouplist(HttpSession session, @RequestParam HashMap<String, String> params) {
       logger.info("리스트 요청 : {}",params);
		/*
		 * params.put("member_id","일반회원"); 
		 * */
		 String loginId = "일반회원";
				 
		session.setAttribute("loginId", "일반회원");
		 
       
       //String loginId = (String) session.getAttribute("loginId");
       logger.info("로그인 아이디 : "+loginId);
       return service.mygrouplist(params);
    }
	
	
	/*@RequestMapping(value = "myPage/myglist.do")
	public ModelAndView myglist(
			@RequestParam String opt, 
			@RequestParam String keyword) {		
			logger.info(opt+" : "+keyword);
		return service.myglist(opt, keyword);
	}
	*/
}
