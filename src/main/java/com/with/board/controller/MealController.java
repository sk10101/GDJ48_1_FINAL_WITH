package com.with.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.board.dto.BoardDTO;
import com.with.board.service.MealService;

@Controller
public class MealController {

Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MealService service;
	
	// 식사 메인페이지 이동
	@RequestMapping(value = "/MealList", method = RequestMethod.GET)
	public String memberMealMain(Model model) {
		logger.info("식사 메인페이지 이동");
		
		ArrayList<com.with.board.dto.BoardDTO> mealList = service.list();
		logger.info("리스트 개수 :"+mealList.size());
		model.addAttribute("mealList", mealList);		
		
		return "mealBoard/MealList";
	}
	
	
	
	
	
	// detail 
	@RequestMapping(value = "/MealDetail", method = RequestMethod.GET)
	public String detail(Model model, @RequestParam String board_idx) {
		logger.info("식사 메인페이지 이동");

		logger.info(board_idx+" 번 상세보기");
		com.with.board.dto.BoardDTO info = service.detail(board_idx);
		model.addAttribute("info", info);
	
		
		return "mealBoard/MealDetail";
	}
	
	
	// 글쓰기 페이지 이동
	@RequestMapping(value = "/MealWrite.go", method = RequestMethod.GET)
	public ModelAndView writePage(HttpSession session, RedirectAttributes rAttr) {
		logger.info("글쓰기 페이지 이동");
		ModelAndView mav = new ModelAndView();

		mav.setViewName("mealBoard/MealWrite");
		
		return mav;
	}
	
	// 글쓰기 페이지 이동
		@RequestMapping(value = "/kakao.go", method = RequestMethod.GET)
		public ModelAndView kakao(HttpSession session, RedirectAttributes rAttr) {
			logger.info("글쓰기 페이지 이동");
			ModelAndView mav = new ModelAndView();

			mav.setViewName("mealBoard/kakao");
			
			return mav;
		}
	
	
	
	// 글쓰기
	@RequestMapping(value = "/MealWrite.do")
	public ModelAndView write(MultipartFile[] photos, HttpSession session, @ModelAttribute BoardDTO dto, RedirectAttributes rAttr) {
		logger.info("게시글 작성 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		
		service.write(photos, dto);
		mav.setViewName("redirect:/MealList");
		
		return mav;
	}
	
	// 검색 목록 조회
	@RequestMapping(value = "/searchList.go")
	public ModelAndView searchList(HttpSession session, @RequestParam String option, @RequestParam String word) {
		
		logger.info("검색 목록 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		mav = service.searchList(option,word);
		
		return mav;
		}	
	
	
	
	
	
}
