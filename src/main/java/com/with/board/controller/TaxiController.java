package com.with.board.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.dto.BoardDTO;
import com.with.board.service.TaxiService;

@Controller
public class TaxiController {
	
	@Autowired TaxiService service;

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/taxiList", method = RequestMethod.GET)
	public ModelAndView taxiList(HttpSession session) {
		return service.taxiListGo(session);
	}
	
	@RequestMapping(value = "/taxiList.ajax")
	@ResponseBody
	public HashMap<String, Object> taxiList(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("리스트 요청 : {}",params);
		
		String loginId = "일반회원";
		session.setAttribute("loginId", "일반회원");
		
		return service.taxiList(params, session);
	}
	
	@RequestMapping(value = "/taxiWrite", method = RequestMethod.GET)
	public String taxiWrite() {
		return "taxiBoard/TaxiWrite";
	}
	
	@RequestMapping(value = "/taxiUploadForm")
	public String uploadForm() {
		return "taxiBoard/uploadForm";
	}
	
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
	
}
