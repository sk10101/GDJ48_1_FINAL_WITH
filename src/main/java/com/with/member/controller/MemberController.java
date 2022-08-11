package com.with.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.with.member.dto.MannerDTO;
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
		int result[]= new int[4]; 
		String nameBox[] = {"친절함","응답속도","시간약속"};
		for(int i=0;i<3;i++) {
			result[i]+=service.average(member_id,nameBox[i]);
			avg[i]=(float)result[i]/cnt;
			avg[3]+=avg[i];
		}
		int num[] = new int[3];
		for(int i=0;i<3;i++) {
			num[i]=(int)Math.round(avg[i]*1)/1;
		}
		map.put("university_idx",name);
		map.put("manner_cnt",cnt);
		map.put("avg_One",Math.round(avg[0]*10)/10.0);
		map.put("avg_Two",Math.round(avg[1]*10)/10.0);
		map.put("avg_Three",Math.round(avg[2]*10)/10.0);
		map.put("avg_Four",Math.round((avg[3]/cnt)*10)/10.0);
		map.put("avg_Five",num[0]);
		map.put("avg_Six",num[1]);
		map.put("avg_Seven",num[2]);
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
	
	@RequestMapping(value = "/mannerDetail.go")
	public String mannerDetail(Model model) {
		String idx = "tester";
		String nameBox[] = {"친절함","응답속도","시간약속"};
		//ArrayList<MannerDTO> name = service.madatail(idx);
		//model.addAttribute("mbdate",date);
		//HashMap<String, Object> map = service.madetail(idx,nameBox[0]);
		//model.addAttribute("mblist", map);
		return "myPage/mannerDetail";
	}
}
