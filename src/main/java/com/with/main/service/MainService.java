package com.with.main.service;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.main.dao.MainDAO;

@Service
public class MainService {
	
	@Autowired MainDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public ModelAndView main(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		String loginId = (String) session.getAttribute("loginId");
		
		// 평점 가져오기
		
		// 대학교 가져오기
		String univ = dao.getUniv(loginId);
		
		// 모집중인 게시글 작성을 최신순으로 5개 가져오기
		
		// 참여중인 게시글 최신순으로 5개 가져오기
		
		mav.addObject("univ", univ);
		mav.setViewName("main");
		
		return mav;
	}
	
	


}
