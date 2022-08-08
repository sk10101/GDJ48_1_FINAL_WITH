package com.with.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.board.service.MealService;

@Controller
public class MealController {

Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MealService service;
	
	// 식사 메인페이지 이동
	@RequestMapping(value = "/MealList", method = RequestMethod.GET)
	public String memberMealMain(Model model) {
		logger.info("식사 메인페이지 이동");
		
		ArrayList<com.with.board.dto.BoardDTO> list = service.list();
		logger.info("리스트 개수 :"+list.size());
		model.addAttribute("list", list);		
		
		return "mealBoard/MealList";
	}
	
	@RequestMapping(value = "/MealDetail", method = RequestMethod.GET)
	public String detail(Model model, @RequestParam String board_idx) {
		logger.info("식사 메인페이지 이동");

		logger.info(board_idx+" 번 상세보기");
		com.with.board.dto.BoardDTO bbs = service.detail(board_idx);
		model.addAttribute("bbs", bbs);
	
		
		return "mealBoard/MealDetail";
	}
	
	
	// 글 작성 페이지 이동
	@RequestMapping(value = "/MealWrite.go")
	public String writeForm( Model model,HttpSession session) {
		logger.info("글쓰기 페이지 이동");
			
		return "mealBoard/MealWrite";
	}
	
	// 글 작성 + 이미지 파일 업로드
	@RequestMapping(value = "/MealWrite.do")
	public String MealWrite(MultipartFile[] photos, Model model,HttpSession session,
			@RequestParam HashMap<String, String> params,RedirectAttributes attr) {
		
			logger.info("params{}",params);
			service.MealWrite(photos,params);
			attr.addFlashAttribute("msg", "글 작성 완료.");
			
		
		return "redirect:/list";
	}
	
	
	
	
	
}
