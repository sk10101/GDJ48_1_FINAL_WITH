package com.with.report.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.with.report.service.ReportService;


@Controller
public class ReportController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired ReportService service;
	
	@RequestMapping(value = "/reportList")
	public ModelAndView reportlist() {
		logger.info("신고내역 리스트 조회");
		return service.reportlist();
	}
	
	
	
}
