package com.with.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.member.dto.MemberDTO;
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
	public String mbUpdate(RedirectAttributes rAttr,MultipartFile[] photo_idx, @RequestParam HashMap<String, Object> params, HttpSession session) {
		params.put("member_id",(String) session.getAttribute("loginId"));
		logger.info("업데이트 변경 값 : {}",params);
		String pw = (String) params.get("pw");
		String member_pw = (String) params.get("member_pw");
		String phone = (String) params.get("phone");
		String university_name = (String) params.get("university_name");
		int hide = Integer.parseInt((String)params.get("hide"));
		int cnt=0;
		String msg="회원정보 수정에 실패하었습니다.";
		if(photo_idx != null) {
			service.photoUpdate(photo_idx,params);
			msg="회원정보 수정에 성공하였습니다.";
		}
		if(phone != null) {
			service.mbPhone(params);
			msg="회원정보 수정에 성공하였습니다.";
		}
		if(hide > 0) {
			service.hideUpdate(params);
			msg="회원정보 수정에 성공하였습니다.";
		}
		if(!university_name.isEmpty()) {
			service.univer_add(params);
			msg="대학교 설정에 성공하였습니다.";
		}
		if(!pw.isEmpty()&&!member_pw.isEmpty()){
			if(pw.equals(member_pw)) {
				cnt = service.pwUpdate(params);
				msg="비밀번호 변경에 성공하였습니다.";
			}else {
				msg="비밀번호가 일치하지 않습니다.";
			}
		}
		rAttr.addFlashAttribute("msg",msg);
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
	public ModelAndView mannerInfo(@RequestParam HashMap<String, Object> params,HttpSession session) {
		String mb_id = (String) session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		String member = (String) params.get("member");
		int whoId = service.whoId(mb_id,member);
		logger.info("whoId 의 값 : {}",whoId);
		int board=Integer.parseInt((String) params.get("board"));
		String boardName = service.boardName(board);
		params=service.infoAll(member, params);
		params.put("board",board);
		params.put("boardName",boardName);
		params.put("whoId", whoId);
		mav.addObject("params",params);
		mav.setViewName("myPage/mannerInfo");
		return mav;
	}
	
	@RequestMapping(value = "/blockAdd")
	public String blockAdd(@RequestParam HashMap<String, Object> params, HttpSession session, RedirectAttributes rAttr) {
		String mb_id = (String) session.getAttribute("loginId");
		String member = (String) params.get("member");
		int board=Integer.parseInt((String) params.get("board"));
		String page = "redirect:/deliDetail?board_idx="+board;
		// 차단하기 이전에 이미 차단한 회원인지 부터 확인한다.
		int blockChk = service.blockChk(member,mb_id);
		if (blockChk == 0) {
			service.blockUser(member,mb_id);
		} else {
			rAttr.addFlashAttribute("msg","이미 차단한 회원입니다.");
			page = "redirect:/mannerInfo?member="+member+"&board="+board;
		}
		return page;
	}

}
