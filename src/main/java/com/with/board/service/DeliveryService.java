package com.with.board.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.dao.DeliveryDAO;
import com.with.board.dto.BoardDTO;


@Service
public class DeliveryService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired DeliveryDAO dao;
	
	// 배달 게시판 목록 조회 서비스
	public ModelAndView deliList() {
		logger.info("게시글 목록 요청");
		ModelAndView mav = new ModelAndView("deliveryBoard/DeliList");
		
		ArrayList<BoardDTO> deliList = dao.deliList();
		logger.info("게시글의 개수 : "+ deliList.size());
		mav.addObject("deliList",deliList);
		
		return mav;
	}

	
	// 상세보기 서비스
	@Transactional
	public ModelAndView deliDetail(String board_idx) {
		logger.info("상세보기 서비스 요청");
		ModelAndView mav = new ModelAndView("DeliDetail");
		
		// 조회수 올리기
		dao.upHit(board_idx);
		// 게시글 상세보기
		BoardDTO info = dao.deliDetail(board_idx);
		mav.addObject("info",info);
		
		return mav;
	}

}
