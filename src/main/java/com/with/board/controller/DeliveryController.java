package com.with.board.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.board.dto.BoardDTO;
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
	
	// 검색 목록 조회
	@RequestMapping(value = "/searchList", method = RequestMethod.GET)
	public ModelAndView searchList(HttpSession session, @RequestParam String option, @RequestParam String word) {
		
		logger.info("검색 목록 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		mav = service.searchList(option,word);
		
		return mav;
	}	
	
	
	// 글쓰기 페이지 이동
	@RequestMapping(value = "/write.go", method = RequestMethod.GET)
	public ModelAndView writePage(HttpSession session, RedirectAttributes rAttr) {
		logger.info("글쓰기 페이지 이동");
		ModelAndView mav = new ModelAndView();

		mav.setViewName("deliveryBoard/DeliWrite");
		
		return mav;
	}
	
	
	// 글쓰기
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public ModelAndView write(MultipartFile[] photos, HttpSession session, @ModelAttribute BoardDTO dto, RedirectAttributes rAttr) {
		logger.info("게시글 작성 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		
		service.write(photos, dto);
		mav.setViewName("redirect:/deliList");
		
		return mav;
	}
	
	
}
