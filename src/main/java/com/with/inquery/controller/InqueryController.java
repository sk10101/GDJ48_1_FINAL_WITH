package com.with.inquery.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.inquery.service.InqueryService;
@Controller
public class InqueryController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired InqueryService service;
	
	@RequestMapping(value = "/inqueryList.go")
	public String inqueryListGo() {
		logger.info("들어왔나요?");
		return "redirect:/inqueryList?page="+1;
	}
	
	@RequestMapping(value = "/inqueryList")
	public ModelAndView inqueryList(@RequestParam HashMap<String, Object> params, HttpSession session) {
		String member_id = (String) session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		mav = service.inqueryList(member_id,params);
		return mav;
	}
	
	@RequestMapping(value = "/inqueryWrite.go")
	public String inqueryWriteGo() {
		return "myPage/inqueryWrite";
	}
	
	@RequestMapping(value = "/inqueryWrite")
	public String inqueryWrite(RedirectAttributes rAttr,@RequestParam HashMap<String, Object> map) {
		logger.info("값들 출력 : {}",map);
		int result = service.inqueryWrite(map);
		logger.info("결과 값 : {}",result);
		if(result>0) {
			rAttr.addFlashAttribute("msg","문의 작성에 성공하셨습니다.");
		}
		return "redirect:/inqueryList?page="+1;
	}
	@RequestMapping(value = "/inqueryDetail.go")
	public String inqueryDetailgo(@RequestParam int idx) {
		return "redirect:/inqueryDetail?idx="+idx;
	}
	
	@RequestMapping(value = "/inqueryDetail")
	public String inqueryDetail(Model model,@RequestParam int idx) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map = service.inqueryDetail(idx);
		map.put("idx",idx);
		logger.info("map 값 : {}",map);
		//map.get(")
		model.addAttribute("map",map);
		return "myPage/inqueryDetail";
	}
	
	@RequestMapping(value = "/inqueryDelete")
	public String inqueryDelete(RedirectAttributes rAttr, @RequestParam int idx) {
		int result = service.inqueryDelete(idx);
		if(result>0) {
			rAttr.addFlashAttribute("msg","문의내역 삭제에 성공하셨습니다.");
		}
		return "redirect:/inqueryList.go";
	}
	
	@RequestMapping(value = "/inqueryUpdate")
	public String inqueryUpdate(RedirectAttributes rAttr, @RequestParam HashMap<String, Object> params) {
		logger.info("params 값 : {}",params);
		int result = service.inqueryUpdate(params);
		if(result>0) {
			rAttr.addFlashAttribute("msg","문의내역 수정에 성공하셨습니다.");
		}
		return "redirect:/inqueryList.go";
	}
	
	@RequestMapping(value = "/admininqueryList.go")
	public String admininqueryListGo() {
		return "redirect:/adminInQueryList?page="+1;
	}
	
	@RequestMapping(value = "/adminInQueryList")
	public ModelAndView adminInQueryList(@RequestParam HashMap<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		mav = service.adminInqueryList(map);
		return mav;
	}
	
	@RequestMapping(value = "/adminInqueryDetail.go")
	public String adminInqueryDetailgo(@RequestParam int idx) {
		return "redirect:/adminInqueryDetail?idx="+idx;
	}
	
	@RequestMapping(value = "/adminInqueryDetail")
	public String adminInqueryDetail(Model model,@RequestParam int idx) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idx",idx);
		map = service.admininqueryDetail(idx);
		logger.info("map 값 : {}",map);		
		model.addAttribute("map",map);
		model.addAttribute("page",idx);
		return "admin/inqueryDetail";
	}
	
	@RequestMapping(value = "/adminInqueryUpdate")
	public String adminInqueryUpdate(RedirectAttributes rAttr, @RequestParam HashMap<String, Object> params) {
		logger.info("params 값 : {}",params);
		int result = service.admininqueryUpdate(params);
		if(result>0) {
			rAttr.addFlashAttribute("msg","문의내역 답변에 성공하셨습니다.");
		}
		return "redirect:/admininqueryList.go";
	}
}
