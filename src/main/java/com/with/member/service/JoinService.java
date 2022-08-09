package com.with.member.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.member.dao.JoinDAO;
import com.with.member.dto.MemberDTO;

@Service
public class JoinService {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired JoinDAO dao;

	public ModelAndView join(MemberDTO dto) {
		String plainPass = dto.getMember_pw();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		dto.setMember_pw(encoder.encode(plainPass));
		
		int row = dao.join(dto);	
		
		logger.info("join success : "+row);
		ModelAndView mav = new ModelAndView();
		String msg = "회원가입에 실패 했습니다.";
		String page = "joinForm";
		if(row >0) {
			msg = "회원가입에 성공 했습니다.";
			page = "redirect:/";
		}
		
		mav.addObject("msg", msg);
		mav.setViewName(page);
		
		return mav;
	}


	
	
	
	

	/*
	 * public ArrayList<MemberDTO> empList() { return dao.empList(); }
	 * 
	 * public ArrayList<MemberDTO> empSearch(int university_idx, String
	 * university_name) { return dao.empSearch(university_idx,university_name); }
	 */



}
