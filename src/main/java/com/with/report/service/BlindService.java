package com.with.report.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.report.dao.BlindDAO;

@Service
public class BlindService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BlindDAO dao;
	
	public ModelAndView superBlind(String board_idx) {
		// 해당 기능은 조건없이 무조건 블라인드 처리해준다.
		ModelAndView mav = new ModelAndView();
		dao.superBlind(board_idx);
		
		return mav;
	}
}
