package com.with.board.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	// 배달 게시판 목록 페이지 이동
	@RequestMapping(value = "/deliList.go", method = RequestMethod.GET)
	public String deliList(HttpSession session) {
		
		return "redirect:/deliList?page="+1+"&option="+"&word=";
	}
	
	
	// 배달 게시판 목록 조회
	@RequestMapping(value = "/deliList", method = RequestMethod.GET)
	public ModelAndView deliList(HttpSession session, @RequestParam HashMap<String, String> params) {
		
		logger.info("게시판 목록 컨트롤러 접속");
		
		// 검색어 저장을 위해 세션 활용
		if(params.get("word") != "") {
		session.setAttribute("option", params.get("option"));
		session.setAttribute("word", params.get("word"));
		}
		ModelAndView mav = new ModelAndView();
		mav = service.deliList(params);
		
		return mav;
	}
	

	
	
	
	/* 검색기능 개선으로 인해 주석처리함
	// 검색 목록 조회
	@RequestMapping(value = "/searchList", method = RequestMethod.GET)
	public ModelAndView searchList(HttpSession session, @RequestParam String option, @RequestParam String word) {
		
		logger.info("검색 목록 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		// 검색 하면 page = 1 로 되돌아 가기 위한 변수 생성
		int page = 1;
		mav = service.searchList(option,word,page);
		
		return mav;
	}	
	*/

	// 상세보기
	@RequestMapping(value = "/deliDetail", method = RequestMethod.GET)
	public ModelAndView deliDetail(HttpSession session, @RequestParam String board_idx) {
		logger.info(board_idx + " 번 글 상세보기 요청 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		
		mav = service.deliDetail(board_idx);
		
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
	@RequestMapping(value = "/write")
	public ModelAndView write(MultipartFile[] photos, HttpSession session, @ModelAttribute BoardDTO dto, RedirectAttributes rAttr) {
		logger.info("게시글 작성 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		
		service.write(photos, dto);
		mav.setViewName("redirect:/deliList");
		
		return mav;
	}
}
