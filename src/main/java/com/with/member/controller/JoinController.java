package com.with.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.with.member.dto.MemberDTO;
import com.with.member.service.JoinService;

@Controller
@RequestMapping(value="/member/*") 
public class JoinController {
		
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired JoinService service;
	
	//회원가입 페이지 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinForm() {		
		return "member/join";
	}
	
	//회원가입 정보 저장
	@RequestMapping(value = "/join.do", method = RequestMethod.POST)
	public ModelAndView join(@ModelAttribute MemberDTO dto) {
		logger.info(dto.getMember_id());
		logger.info(dto.getUniversity_idx());
		logger.info(dto.getMember_pw());
		logger.info(dto.getName());
		logger.info(dto.getGender());
		logger.info(dto.getEmail());
		logger.info(dto.getPhone());
		return service.join(dto);
	}	
}
