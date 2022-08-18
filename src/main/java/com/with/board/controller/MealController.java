package com.with.board.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.board.dto.BoardDTO;
import com.with.board.service.MealService;

@Controller
public class MealController {

Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MealService service;
	
	// 밥 게시판 목록 페이지 이동
	@RequestMapping(value = "/mealList.go", method = RequestMethod.GET)
	public String mealList(HttpSession session) {
		
		return "redirect:/mealList?page="+1+"&option="+"&word=";
	}
	
	
	// 밥 게시판 목록 조회
	@RequestMapping(value = "/mealList", method = RequestMethod.GET)
	public ModelAndView mealList(HttpSession session, @RequestParam HashMap<String, String> params) {
		
		logger.info("게시판 목록 컨트롤러 접속");
		
		// 검색어 저장을 위해 세션 활용
		if(params.get("word") != "") {
		session.setAttribute("option", params.get("option"));
		session.setAttribute("word", params.get("word"));
		}
		ModelAndView mav = new ModelAndView();
		mav = service.mealList(params);
		
		return mav;
	}
	
	
	
	
	
	// 밥  게시글 상세보기
	@RequestMapping(value = "/mealDetail", method = RequestMethod.GET)
	public ModelAndView mealDetail(HttpSession session, @RequestParam String board_idx) {
		logger.info(board_idx + " 번 글 상세보기 요청 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		
		mav = service.mealDetail(session,board_idx);
		
		return mav;
	}
	
	
	// 밥 글쓰기 페이지 이동
	@RequestMapping(value = "/MealWrite.go", method = RequestMethod.GET)
	public ModelAndView writePage(HttpSession session, RedirectAttributes rAttr) {
		logger.info("글쓰기 페이지 이동");
		ModelAndView mav = new ModelAndView();

		mav.setViewName("mealBoard/MealWrite");
		
		return mav;
	}
	

	// 글쓰기
	@RequestMapping(value = "/MealWrite.do")
	public ModelAndView write(MultipartFile[] photos, HttpSession session, @ModelAttribute BoardDTO dto, RedirectAttributes rAttr) {
		logger.info("게시글 작성 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		
		service.write(photos, dto, session);
		mav.setViewName("redirect:/mealList.go");
		
		// 사용했던 세션을 비워주기
		session.removeAttribute("lat");
		session.removeAttribute("lng");
		
		return mav;
	}
	
	
		// kakao
		@RequestMapping(value = "/mealkakao.go", method = RequestMethod.GET)
		public ModelAndView kakao(HttpSession session, RedirectAttributes rAttr) {
			logger.info("글쓰기 페이지 이동");
			ModelAndView mav = new ModelAndView();

			mav.setViewName("mealBoard/kakao");
			
			return mav;
		}
		
		// 상세위치 모달 ajax
		@RequestMapping("/mealMarker.ajax")
		@ResponseBody public HashMap<String, Object> detailMarker(HttpSession session, @RequestParam HashMap<String, String> params) {
			logger.info("상세위치 마커 컨트롤러 접속");
			logger.info("로그인한 아이디 : " + params.get("loginId"));
			
			HashMap<String, Object> mealMap = service.detailMarker(params);
			
			return mealMap;
		}
		
		// 카카오 팝업 창에서 가져온 좌표를 잠시 세션에 보관
		@RequestMapping(value = "/getCoord", method = RequestMethod.GET)
		public void getCoords(HttpSession session, @RequestParam HashMap<String, String> params) {
			logger.info("가져온 좌표 : " + params.get("lat") + "," + params.get("lng"));
			// 혹시 남아있을지 모를 session 을 비워준다
			session.removeAttribute("lat");
			session.removeAttribute("lng");
			// 세션에 좌표를 보관한다
			session.setAttribute("lat", params.get("lat"));
			session.setAttribute("lng", params.get("lng"));
			
		}
		
		// 밥 게시판 참가 신청 
		
		@RequestMapping(value = "/mealApply")
		public ModelAndView mealApply(HttpSession session, RedirectAttributes rAttr, @RequestParam HashMap<String, String> params) {
			String loginId = (String) session.getAttribute("loginId");
			String board_idx = (String) params.get("board_idx");
			
			ModelAndView mav = new ModelAndView();
			
			service.mealApply(rAttr,params);
			
			mav.setViewName("redirect:/mealDetail?board_idx="+board_idx);
			
			return mav;
		}
		/*
		@RequestMapping(value = "/mealAppls", method = RequestMethod.POST)
		public ModelAndView mealApplys
		(HttpSession session,
		@RequestParam HashMap<String, Object> params,
		RedirectAttributes rAttr) {
			return service.mealApplys(session, params, rAttr);
		}
		*/
		
		// 참여한 회원 강퇴
		@RequestMapping(value = "/mealBan", method = RequestMethod.GET)
		public ModelAndView mealBan(HttpSession session, RedirectAttributes rAttr, @RequestParam String member_id, @RequestParam String board_idx) {
			logger.info("로그인한 아이디 : " + member_id);
			ModelAndView mav = new ModelAndView();
			
			mav = service.mealBan(member_id,board_idx);
			
			mav.setViewName("redirect:/mealDetail?board_idx="+board_idx);
			
			return mav;
		}
	
		 
	
	
	
	
	
	
	
}
