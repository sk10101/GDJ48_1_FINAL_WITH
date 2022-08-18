package com.with.main.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.dto.BoardDTO;
import com.with.main.dao.MainDAO;

@Service
public class MainService {
	
	@Autowired MainDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public ModelAndView main(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		String loginId = (String) session.getAttribute("loginId");
		
		// 평점 가져오기
		float avg = dao.grade(loginId);
		avg = (float) (Math.round(avg*10)/10.0);
		logger.info("avg 값 : {}",avg);
		// 대학교 가져오기
		String univ = dao.getUniv(loginId);
		
		// 모집중인 게시글 작성을 최신순으로 5개 가져오기
		ArrayList<BoardDTO> recruitIng = dao.recruitIng(loginId);
		
		// 참여중인 게시글 최신순으로 5개 가져오기
		ArrayList<BoardDTO> partIng = dao.partIng(loginId);
		
		// 모집중인 게시글 수 가져오기
		int recruitCnt = dao.recruitCnt(loginId);
		logger.info("모집중인 게시글 수 : " + recruitCnt);
		
		// 참여중인 게시글 수 가져오기
		int partCnt = dao.partCnt(loginId);
		logger.info("참여중인 게시글 수 : " + partCnt);
		
		mav.addObject("avg", avg);
		mav.addObject("univ", univ);
		mav.addObject("recruitIng", recruitIng);
		mav.addObject("partIng", partIng);
		mav.addObject("recruitCnt", recruitCnt);
		mav.addObject("partCnt", partCnt);
		mav.setViewName("main");
		
		return mav;
	}
	
	


}
