package com.with.board.controller;

import java.util.HashMap;
import java.util.Map;

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
import com.with.board.service.TaxiService;

@Controller
public class TaxiController {
	
	@Autowired TaxiService service;

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// 택시게시판 목록 페이지 이동
	@RequestMapping(value = "/taxiListGo", method = RequestMethod.GET)
	public String taxiListGo(HttpSession session) {
		return "redirect:/taxiList?page="+1+"&option="+"&word=";
	}
	
	// 택시게시판 목록
	@RequestMapping(value = "/taxiList", method = RequestMethod.GET)
	public ModelAndView taxiList(HttpSession session, @RequestParam HashMap<String, String> params) {
		// 검색어 저장을 위해 세션 활용
//		if(params.get("word") != "") {
		session.setAttribute("page", params.get("page"));
		session.setAttribute("option", params.get("option"));
		session.setAttribute("word", params.get("word"));
//		}
		
		return service.taxiList(session, params);
	}
	
	// 택시 상세보기
	@RequestMapping(value = "/taxiDetail", method = RequestMethod.GET)
	public ModelAndView taxiDetail(HttpSession session, @RequestParam String board_idx) {
		return service.taxiDetail(session, board_idx);
	}

	// 택시 글쓰기 이동
	@RequestMapping(value = "/taxiWrite", method = RequestMethod.GET)
	public String taxiWrite(HttpSession session) {
		// 혹시 남아있을지 모를 session 을 비워준다
		session.removeAttribute("lat");
		session.removeAttribute("lng");
		return "taxiBoard/TaxiWrite";
	}
	
	// 택시 글쓰기
	@RequestMapping(value = "/taxiWriteDo")
	public ModelAndView taxiWriteDo(MultipartFile[] photos, HttpSession session, @ModelAttribute BoardDTO dto) {
		return service.taxiWrite(photos, dto, session);
	}
	
	// 카카오 팝업 창 이동
	@RequestMapping(value = "/taxiKakaoGo", method = RequestMethod.GET)
	public ModelAndView kakao(HttpSession session) {
		return service.taxiKakao(session);
	}
	
	// 카카오 팝업 창에서 가져온 좌표를 잠시 세션에 보관
	@RequestMapping(value = "/taxiGetCoords", method = RequestMethod.GET)
	public void getCoords(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("가져온 좌표 : " + params.get("lat") + "," + params.get("lng"));
		// 혹시 남아있을지 모를 session 을 비워준다
		session.removeAttribute("lat");
		session.removeAttribute("lng");
		// 세션에 좌표를 보관한다
		session.setAttribute("lat", params.get("lat"));
		session.setAttribute("lng", params.get("lng"));
	}
	
	// 택시 모임 참여신청
	// RedirectAttributes 를 사용하는 이유 ? addFlashAttribute 는 일회성이므로 리다이렉트 후 새로고침하게 되면 파라미터가 소멸된다.
	// 즉, alert 로 메시지를 띄어야할 때 쓰기 좋음
	// 새로고침할때마다 alert 이 계속해서 뜨는 것을 막을 수 있음.
	@RequestMapping(value = "/taxiApplyDo", method = RequestMethod.POST)
	public ModelAndView taxiApplyDo
	(HttpSession session,
	@RequestParam HashMap<String, Object> params,
	RedirectAttributes rAttr) {
		return service.taxiApply(session, params, rAttr);
	}
	
}
