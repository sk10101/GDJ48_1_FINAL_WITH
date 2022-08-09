package com.with.member.controller;

import java.lang.reflect.Array;
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
		String member_id = "tester";
		HashMap<String, Object> map = service.mblist(member_id);
		String name = service.univer(map.get("university_idx"));
		int cnt = service.macnt(member_id)/3;
		float avg[]= new float[4];
		int yang[]= new int[4]; 
		String subin[] = {"친절함","응답속도","시간약속"};
		for(int i=0;i<3;i++) {
			yang[i]+=service.average(member_id,subin[i]);
			yang[3]+=yang[i];
			avg[i]=yang[i]/cnt;
		}
		map.put("university_idx",name);
		map.put("manner_cnt",cnt);
		model.addAttribute("mblist",map);
		return "myPage/myInfo";
	}
	@RequestMapping(value = "/mbUpdate.go")
	public String mbUpgo(Model model) {
		String idx = "tester";
		HashMap<String, Object> map = service.mblist(idx);
		model.addAttribute("mblist", map);
		return "myPage/myInfoUpdate";
	}
	
	@RequestMapping(value = "/mbUpdate.do")
	public String mbUpdate(Model model, @RequestParam String member_pw,
			@RequestParam String phone, @RequestParam int hide) {
		String member_id = "tester";
		service.update(member_pw,phone,hide,member_id);
		return "myPage/myInfo";
	}
	
	
}
