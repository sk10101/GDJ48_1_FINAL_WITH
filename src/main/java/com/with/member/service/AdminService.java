package com.with.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.member.dao.AdminDAO;
import com.with.member.dto.MemberDTO;

@Service
public class AdminService {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired AdminDAO dao;
	
	public ModelAndView userList(HashMap<String, String> params) {
		logger.info("유저 목록 조회 서비스");
		ModelAndView mav = new ModelAndView("admin/userList");
		
		ArrayList<MemberDTO> list = dao.userList(params);
		mav.addObject("list", list);		
		return mav;
	}

	public ModelAndView userDetail(String member_id) {
		logger.info("유저 상세보기 서비스 요청");
		ModelAndView mav = new ModelAndView("admin/userDetail");
		MemberDTO dto = dao.userDetail(member_id);
		mav.addObject("dto", dto);
		
		return mav;
	}

	public ModelAndView adminList() {
		logger.info("관리자 목록 조회 서비스");
		ModelAndView mav = new ModelAndView("admin/managerList");
		ArrayList<MemberDTO> list = dao.adminList();
		mav.addObject("list", list);
		return mav;
	}

	public void pass(String member_id) {
		logger.info("대학교 인증 요청 서비스");
		dao.pass(member_id);
	}

	public ModelAndView search(String name) {
		ModelAndView mav = new ModelAndView("admin/managerList");
		ArrayList<MemberDTO> list = dao.search(name);
		mav.addObject("list", list);
		return mav;
	}

	public ModelAndView usersearch(String opt, String keyword) {
		ModelAndView mav = new ModelAndView("admin/userList");
		if(opt.equals("certficate") && (keyword.equals("n") || keyword.equals("N"))) {
			keyword = "0";
		} else if(opt.equals("certficate") && (keyword.equals("y") || keyword.equals("Y"))) {
			keyword = "1";
		}
		ArrayList<MemberDTO> list = dao.usersearch(opt, keyword);
		mav.addObject("list", list);
		return mav;
	}

	
	
}
