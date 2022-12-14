package com.with.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.member.dto.MemberDTO;
import com.with.member.service.JoinService;

@Controller
public class JoinController {
		
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired JoinService service;
	
	//회원가입 페이지 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinForm() {		
		return "member/join";
	}
	
	//회원가입 정보 저장
	@RequestMapping(value = "main/join.do", method = RequestMethod.POST)
	public ModelAndView join(MultipartFile[] photos, @ModelAttribute MemberDTO dto, RedirectAttributes rAttr) {
		logger.info(dto.getMember_id());
		//logger.info(dto.getUniversity_idx());
		logger.info("pw:"+dto.getMember_pw());
		logger.info("이름:"+dto.getName());
		logger.info("성별:"+dto.getGender());
		logger.info("이메일:"+dto.getEmail());
		logger.info("연락처:"+dto.getPhone());
		
		/* System.out.println("test"); */
		ModelAndView mav = service.join(photos,dto,rAttr);
		return mav;
	}	
	
	  //대학검색
	  @RequestMapping("/univSearch.ajax")
	  @ResponseBody public ArrayList<MemberDTO> univSearch(@RequestParam String keyword) { 
		  return service.univSearch(keyword); 
	  }
	  
	  //모달 뿌려주는 ajax
	  @RequestMapping("/univList.ajax")
	  @ResponseBody 
	  public ArrayList<MemberDTO> univList() { 
		  return service.univList(); 
	  }
	 
	  
	  //아이디 중복 체크
		@RequestMapping(value = "/IdCheck.ajax")
		@ResponseBody
		public HashMap<String, Object> IdOverlay(@RequestParam String chkId) {
			logger.info("아이디 중복체크 : " + chkId);
			return service.IdOverlay(chkId);
		}
	  
	  //이메일 중복 체크
		@RequestMapping("EmailCheck.ajax")
		@ResponseBody
		public HashMap<String, Object> EmailOverlay(@RequestParam String chkEmail) {
			
			logger.info("이메일 중복 체크 : "+chkEmail);
			return service.EmailOverlay(chkEmail);
		}


}
