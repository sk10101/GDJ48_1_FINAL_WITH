/*package com.with.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.service.TaxiService;

@Controller
public class TaxiController {
	
	@Autowired TaxiService service;

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/taxiList", method = RequestMethod.GET)
	public ModelAndView taxiList(HttpSession session) {
		return service.taxiList(session);
	}
	
	@RequestMapping(value = "/taxiSearchList", method = RequestMethod.GET)
	public ModelAndView taxiSearchList(HttpSession session, @RequestParam String option, @RequestParam String word) {
		return service.taxiSearchList(session, option, word);
	}
	
	@RequestMapping(value = "/taxiDetail", method = RequestMethod.GET)
	public ModelAndView taxiDetail(HttpSession session, @RequestParam String board_idx) {
		return service.taxiDetail(session, board_idx);
	}
	
	@RequestMapping(value = "/taxiWrite", method = RequestMethod.GET)
	public String taxiWrite() {
		return "taxiBoard/TaxiWrite";
	}
	@RequestMapping(value = "/taxiUploadForm")
	public String uploadForm() {
		return "taxiBoard/uploadForm";
	}
	/*
	@RequestMapping(value = "/taxiUpload")
	public ModelAndView upload(MultipartFile file, HttpSession session) {		
		logger.info("upload 요청");
		return service.fileUpload(file, session);
	}
	
	@RequestMapping(value = "/taxiFileDelete")
	@ResponseBody
	public HashMap<String, Object> fileDelete(
			@RequestParam String fileName, HttpSession session) {		
		logger.info(fileName+ "삭제 요청");
		return service.fileDelete(fileName, session);
	}
	
	@RequestMapping(value = "/taxiWriteDo", method = RequestMethod.POST)
	public ModelAndView write(BoardDTO dto, HttpSession session) {
		return service.write(dto, session);
	}
	
	@RequestMapping(value = "/taxiDel/{idx}")
	public ModelAndView del(@PathVariable String idx) {		
		logger.info("삭제 요청 : "+idx);
		return service.del(idx);
	}
}*/
