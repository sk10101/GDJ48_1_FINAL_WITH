package com.with.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.with.member.service.MemberService;

@Controller
public class MemberController {
	@Autowired MemberService service;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/myInfo")
	public String myInfo(Model model, HttpSession session) {
		String member_id = (String) session.getAttribute("loginId");
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
		map.put("avg_Four",Math.round((avg[3]/3)*10)/10.0);
		map.put("avg_Five",num[0]);
		map.put("avg_Six",num[1]);
		map.put("avg_Seven",num[2]);
		model.addAttribute("mblist",map);
		return "myPage/myInfo";
	}
	@RequestMapping(value = "/mbUpdate.go")
	public String mbUpgo(Model model, HttpSession session) {
		String member_id = (String) session.getAttribute("loginId");
		HashMap<String, Object> map = service.mblist(member_id);
		model.addAttribute("mblist", map);
		return "myPage/myInfoUpdate";
	}
	
	@RequestMapping(value = "/mbUpdate.do")
	public String mbUpdate(Model model, @RequestParam String member_pw,
			@RequestParam String phone, @RequestParam int hide, HttpSession session) {
		String member_id = (String) session.getAttribute("loginId");
		service.update(member_pw,phone,hide,member_id);
		return "myPage/myInfo";
	}
	@RequestMapping(value = "/mannerDetail.go")
	public String deliList() {
		return "redirect:/mannerDetail?page="+1;
	}
	
	
	@RequestMapping(value = "/mannerDetail")
	public ModelAndView mannerDetail(@RequestParam int page, HttpSession session) {
		String member_id = (String) session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		mav = service.madetail(member_id,page);
		return mav;
	}
	
	@RequestMapping(value = "/blockUserList.go")
	public String blockUserGo() {
		return "redirect:/blockUserList?page="+1;
	}
	
	@RequestMapping(value = "/blockUserList")
	public ModelAndView blockUser(@RequestParam HashMap<String, Object> params, HttpSession session) {
		String member_id = (String) session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		mav = service.blockList(member_id,params);
		return mav;
	}
	@RequestMapping(value = "/blockDelete")
	public String blockDelete(HttpSession session, @RequestParam String name) {
		String member_id = (String) session.getAttribute("loginId");
		service.blockDelete(member_id,name);
		return "redirect:/blockUserList?page="+1;
	}
	
}
