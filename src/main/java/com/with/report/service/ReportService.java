package com.with.report.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.report.dao.ReportDAO;
import com.with.report.dto.ReportDTO;

@Service
public class ReportService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired ReportDAO dao;

	public ModelAndView reportlist() {
		logger.info("신고 내역 요청 서비스");
		ModelAndView mav = new ModelAndView("admin/reportList");
		ArrayList<ReportDTO> list = dao.reportlist();
		mav.addObject("list", list);
		return mav;
	}
}
