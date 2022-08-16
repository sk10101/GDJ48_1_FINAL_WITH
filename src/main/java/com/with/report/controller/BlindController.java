package com.with.report.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.report.dto.BlindDTO;
import com.with.report.service.BlindService;

@Controller
public class BlindController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BlindService service;
	
	
	// 관리자가 각 게시글의 상세보기에서 눈 버튼을 누르면 조건 따지지 않고 바로 hide = 1 처리하여 블라인드 게시판으로 보낸다.
	// 무조건 삭제
	@RequestMapping(value = "/superBlind", method = RequestMethod.GET)
	public ModelAndView blindDelete(HttpSession session, RedirectAttributes rAttr, @RequestParam String board_idx) {
		logger.info("블라인드 처리하려는 게시글 번호 : " + board_idx);
		ModelAndView mav = new ModelAndView();
		
		mav = service.superBlind(board_idx);
		
		mav.setViewName("redirect:/blindListGo");
		
		return mav;
	}
	
	// 블라인드 게시판 목록 페이지 이동
		@RequestMapping(value = "/blindListGo", method = RequestMethod.GET)
		public String blindList(RedirectAttributes rAttr, HttpSession session) {
			return "redirect:/blindList?page="+1+"&option="+"&word=";
		}
		
		// 블라인드 게시판 목록 조회
		@RequestMapping(value = "/blindList", method = RequestMethod.GET)
		public ModelAndView blindList(HttpSession session, @RequestParam HashMap<String, String> params) {
			
			logger.info("블라인드 목록 컨트롤러 접속");
			
			// 검색어 저장을 위해 세션 활용
			if(params.get("word") != "" || params.get("word") != " ") {
				session.setAttribute("option", params.get("option"));
				session.setAttribute("word", params.get("word"));
			}
			ModelAndView mav = new ModelAndView();
			mav = service.blindList(params);
			
			return mav;
		}
		
		// 상세보기
		@RequestMapping(value = "/blindDetail", method = RequestMethod.GET)
		public ModelAndView blindDetail(HttpSession session, @RequestParam String board_idx) {
			logger.info(board_idx + " 번 글 상세보기 요청 컨트롤러 접속");
			ModelAndView mav = new ModelAndView();
			
			mav = service.blindDetail(board_idx,session);
			
			return mav;
		}
		
		//블라인드 해제/해제취소
		@RequestMapping(value="/blind/updateList", method = RequestMethod.POST)
		public String updateList(HttpSession session, BlindDTO dto) {
			
			int idx = dto.getBoard_idx();
			
			dto.setBlindCancel_id(""+session.getAttribute("loginId"));
			
			service.updateList(dto);
			
			return "redirect:/blindDetail?board_idx="+idx;
			
		}
	
}
