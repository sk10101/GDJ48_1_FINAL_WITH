package com.with.report.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.report.service.BlindService;

@Controller
public class BlindController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BlindService service;
	
	
	// 관리자가 각 게시글의 상세보기에서 눈 버튼을 누르면 조건 따지지 않고 바로 hide = 1 처리하여 블라인드 게시판으로 보낸다.
	// 무조건 삭제
	@RequestMapping(value = "/superBlind", method = RequestMethod.GET)
	public ModelAndView deliDelete(HttpSession session, RedirectAttributes rAttr, @RequestParam String board_idx) {
		logger.info("블라인드 처리하려는 게시글 번호 : " + board_idx);
		ModelAndView mav = new ModelAndView();
		
		mav = service.superBlind(board_idx);
		
		mav.setViewName("redirect:/blindListGo");
		
		return mav;
	}
	
}
