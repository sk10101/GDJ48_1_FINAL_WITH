package com.with.report.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import com.with.report.service.PenaltyService;

@Controller
public class PenaltyController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired PenaltyService service;
	
}
