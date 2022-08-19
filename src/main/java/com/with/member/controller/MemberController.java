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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.with.member.service.MemberService;

@Controller
public class MemberController {
	@Autowired MemberService service;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/myInfo")
	public String myInfo(Model model, HttpSession session) {
		String member_id = (String) session.getAttribute("loginId");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map=service.mblist(member_id);
		map=service.infoAll((String) map.get("member_id"),map);
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
	public String mbUpdate(Model model,MultipartFile[] photo_idx, @RequestParam HashMap<String, Object> params, HttpSession session) {
		params.put("member_id",(String) session.getAttribute("loginId"));
		logger.info("파일의 값 : {}",photo_idx);
		logger.info("업데이트 변경 값 : {}",params);
		int cnt = service.update(photo_idx,params);
		if(cnt>0) {
			model.addAttribute("msg","회원 수정이 완료되었습니다.");
		}
		return "redirect:/myInfo";
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
	@RequestMapping(value = "/mannerInfo")
	public ModelAndView mannerInfogo(@RequestParam HashMap<String, Object> params) {
		ModelAndView mav = new ModelAndView();
		String member = (String) params.get("member");
		int board=Integer.parseInt((String) params.get("board"));
		logger.info("member의 값 : "+member);
		logger.info("board의 값 : {}",board);
		params=service.infoAll(member, params);
		params.put("board",board);
		mav.addObject("params",params);
		mav.setViewName("myPage/mannerInfo");
		return mav;
	}
	
	@RequestMapping(value = "/blockAdd")
	public String blockAdd(@RequestParam HashMap<String, Object> params, HttpSession session) {
		String mb_id = (String) session.getAttribute("loginId");
		String member = (String) params.get("member");
		int board=Integer.parseInt((String) params.get("board"));
		service.blockUser(member,mb_id);
		return "redirect:/deliDetail?board_idx="+board;
	}

}
