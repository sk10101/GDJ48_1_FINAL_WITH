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
import com.with.board.service.TaxiService;

@Controller
public class TaxiController {
	
	@Autowired TaxiService service;

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// 택시게시판 목록 페이지 이동
	@RequestMapping(value = "/taxiListGo", method = RequestMethod.GET)
	public String taxiListGo(HttpSession session) {
		return "redirect:/taxiList?page="+1+"&option="+"&word=";
	}
	
	// 택시게시판 목록
	@RequestMapping(value = "/taxiList", method = RequestMethod.GET)
	public ModelAndView taxiList(HttpSession session, @RequestParam HashMap<String, String> params) {
		// 검색어 저장을 위해 세션 활용
//		if(params.get("word") != "") {
		session.setAttribute("option", params.get("option"));
		session.setAttribute("word", params.get("word"));
//		}
		
		return service.taxiList(session, params);
	}
	
//	// 택시게시판 목록(검색)
//	@RequestMapping(value = "/taxiSearchList", method = RequestMethod.GET)
//	public ModelAndView taxiSearchList(HttpSession session, @RequestParam String option, @RequestParam String word) {
//		return service.taxiSearchList(session, option, word);
//	}
	
	// 택시 상세보기
	@RequestMapping(value = "/taxiDetail", method = RequestMethod.GET)
	public ModelAndView taxiDetail(HttpSession session, @RequestParam String board_idx) {
		return service.taxiDetail(session, board_idx);
	}
	
	// 택시 글쓰기 이동
	@RequestMapping(value = "/taxiWrite", method = RequestMethod.GET)
	public String taxiWrite() {
		return "taxiBoard/TaxiWrite";
	}
	
	// 택시 글쓰기
	@RequestMapping(value = "/taxiWriteDo")
	public ModelAndView taxiWriteDo(MultipartFile[] photos, HttpSession session, @ModelAttribute BoardDTO dto, RedirectAttributes rAttr) {
		return service.taxiWrite(photos, dto);
	}
	
	
}
