package com.with.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

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

import com.with.board.dto.BoardDTO;
import com.with.board.service.DeliveryService;
import com.with.member.dto.MemberDTO;

@Controller
public class DeliveryController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired DeliveryService service;
	
	// 배달 게시판 목록 페이지 이동
	@RequestMapping(value = "/deliListGo", method = RequestMethod.GET)
	public String deliList(HttpSession session) {
		
		return "redirect:/deliList?page="+1+"&option="+"&word=";
	}
	
	
	// 배달 게시판 목록 조회
	@RequestMapping(value = "/deliList", method = RequestMethod.GET)
	public ModelAndView deliList(HttpSession session, @RequestParam HashMap<String, String> params) {
		
		logger.info("게시판 목록 컨트롤러 접속");
		
		// 검색어 저장을 위해 세션 활용
		if(params.get("word") != "" || params.get("word") != " ") {
			session.setAttribute("option", params.get("option"));
			session.setAttribute("word", params.get("word"));
		}
		ModelAndView mav = new ModelAndView();
		mav = service.deliList(params);
		
		return mav;
	}
	
	
	// 상세보기
	@RequestMapping(value = "/deliDetail", method = RequestMethod.GET)
	public ModelAndView deliDetail(HttpSession session, @RequestParam String board_idx) {
		logger.info(board_idx + " 번 글 상세보기 요청 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		
		mav = service.deliDetail(board_idx,session);
		
		return mav;
	}
	
	
	// 글쓰기 페이지 이동
	@RequestMapping(value = "/writeGo", method = RequestMethod.GET)
	public ModelAndView writePage(HttpSession session, RedirectAttributes rAttr) {
		logger.info("글쓰기 페이지 이동");
		ModelAndView mav = new ModelAndView();

		mav.setViewName("deliveryBoard/DeliWrite");
		
		return mav;
	}
	
	
	// 글쓰기
	@RequestMapping(value = "/write")
	public ModelAndView write(MultipartFile[] photos, HttpSession session, @ModelAttribute BoardDTO dto, RedirectAttributes rAttr) {
		logger.info("게시글 작성 컨트롤러 접속");
		ModelAndView mav = new ModelAndView();
		
		service.write(photos, dto, session);
		mav.setViewName("redirect:/deliListGo");
		// 사용했던 세션을 비워주기
		session.removeAttribute("lat");
		session.removeAttribute("lng");
		
		return mav;
	}
	
	
	// 상세위치 모달 ajax
	@RequestMapping("/getUnivAddr")
	@ResponseBody public HashMap<String, Object> getUnivAddr(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("상세위치 마커 컨트롤러 접속");
		logger.info("로그인한 아이디 : " + params.get("loginId"));
		
		HashMap<String, Object> deliMap = service.getUnivAddr(params);
		
		return deliMap;
	}
	
	
	// 카카오 팝업 창 이동
	@RequestMapping(value = "/deliKakaoMap", method = RequestMethod.GET)
	public ModelAndView kakao(HttpSession session, RedirectAttributes rAttr) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("deliveryBoard/kakao");
		
		return mav;
	}
	
	
	// 카카오 팝업 창에서 가져온 좌표를 잠시 세션에 보관
	@RequestMapping(value = "/getCoords", method = RequestMethod.GET)
	public void getCoords(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("가져온 좌표 : " + params.get("lat") + "," + params.get("lng"));
		// 혹시 남아있을지 모를 session 을 비워준다
		session.removeAttribute("lat");
		session.removeAttribute("lng");
		// 세션에 좌표를 보관한다
		session.setAttribute("lat", params.get("lat"));
		session.setAttribute("lng", params.get("lng"));
	}

	
	// 참가신청하기 기능
	@RequestMapping(value = "/applyDeli", method = RequestMethod.GET)
	public ModelAndView applyDeli(HttpSession session, RedirectAttributes rAttr, @RequestParam String member_id, @RequestParam String board_idx, @RequestParam String investment) {
		logger.info("로그인한 아이디 : " + member_id);
		ModelAndView mav = new ModelAndView();
		
		service.applyDeli(rAttr,member_id,board_idx,investment);
		
		mav.setViewName("redirect:/deliDetail?board_idx="+board_idx);
		
		return mav;
	}
	
	
	// 참가한 회원 강퇴하는 기능
	@RequestMapping(value = "/deliBan", method = RequestMethod.GET)
	public ModelAndView deliBan(HttpSession session, RedirectAttributes rAttr, @RequestParam String member_id, @RequestParam String board_idx) {
		logger.info("로그인한 아이디 : " + member_id);
		ModelAndView mav = new ModelAndView();
		
		mav = service.deliBan(member_id,board_idx);
		
		mav.setViewName("redirect:/deliDetail?board_idx="+board_idx);
		
		return mav;
	}
	
	
	// 참가한 회원 강퇴하는 기능
	@RequestMapping(value = "/deliDelete", method = RequestMethod.GET)
	public ModelAndView deliDelete(HttpSession session, RedirectAttributes rAttr, @RequestParam String board_idx) {
		logger.info("삭제하려는 게시글 번호 : " + board_idx);
		ModelAndView mav = new ModelAndView();
		
		mav = service.deliDelete(board_idx);
		
		mav.setViewName("redirect:/deliListGo");
		
		return mav;
	}
}
