package com.with.board.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.service.TaxiService;

@Controller
public class TaxiController {
	
	@Autowired TaxiService service;

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/taxiList", method = RequestMethod.GET)
	public ModelAndView taxiList(HttpSession session) {
		return service.taxiList(session);
	}
	
	@RequestMapping(value = "/taxiList.ajax")
	@ResponseBody
	public HashMap<String, Object> list(@RequestParam HashMap<String, String> params) {
		logger.info("리스트 요청 : {}",params);
		return service.list(params);
	}
}
