package com.with.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.with.member.service.MemberService;

@Controller
public class MemberController {
	@Autowired MemberService service;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/myInfo")
	public String myInfo(Model model) {
		String idx = "tester";
		HashMap<String, Object> map = service.mblist(idx);
		String name = service.univer(map.get("university_idx"));
		map.put("university_idx",name);
		model.addAttribute("mblist",map);
		return "myPage/myInfo";
	}
	@RequestMapping(value = "/mbUpdate.go")
	public String mbUpdate(Model model) {
		String idx = "tester";
		HashMap<String, Object> map = service.mblist(idx);
		model.addAttribute("mblist", map);
		return "myPage/myInfoUpdate";
	}
}
