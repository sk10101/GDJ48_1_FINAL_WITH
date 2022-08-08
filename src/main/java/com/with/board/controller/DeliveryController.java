package com.with.board.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.service.DeliveryService;

@Controller
public class DeliveryController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired DeliveryService service;
	
	// 택시 게시판 목록 조회
	@RequestMapping(value = "/deliList", method = RequestMethod.GET)
	public ModelAndView deliList(HttpSession session) {
		
		logger.info("게시판 목록 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		mav = service.deliList();
		
		return mav;
	}
	
	
	// 상세보기
	@RequestMapping(value = "/deliDetail", method = RequestMethod.GET)
	public ModelAndView deliDetail(HttpSession session, @RequestParam String board_idx) {
		logger.info(board_idx + " 번 글 상세보기 요청 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		
		mav = service.deliDetail(board_idx);
		
		return mav;
	}
	
	
	// 상세보기 Kakao MAP API 관련 콘트롤러
	// 등록한 위도 경도 가져오기
	@RequestMapping(value = "/LatLng", method = RequestMethod.GET)
	public ModelAndView LatLng(HttpSession session) {
		
		logger.info("위도 경도 가져오기 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		mav = service.LatLng();
		
		return mav;
	}
	
}
