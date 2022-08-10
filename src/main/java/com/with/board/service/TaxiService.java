package com.with.board.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.dao.TaxiDAO;
import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;

@Service
public class TaxiService {
	
	@Autowired TaxiDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public ModelAndView taxiList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		session.setAttribute("loginId", "일반회원");
		// 임시부여한 session 으로 테스트중
		String loginId = (String) session.getAttribute("loginId");
		
		// 나와 같은 대학교에 재학중인 유저의 게시글을 불러오는 코드 
		ArrayList<BoardDTO> list = dao.taxiList(loginId);
		
		// 시간 비교를 통해 마감여부를 update 해주는 코드
		dao.updateEnd();
		int allcnt = dao.allCount(loginId);
		
		// 리스트로 왔을 때 chkHit 세션을 제거해주는 코드
		// 해당 코드가 있어야만 Detail 에 다시 접근했을 때 조회수 기능을 실행할 수 있다.
		session.removeAttribute("chkHit");
		
		mav.addObject("taxiList", list);
		mav.setViewName("taxiBoard/TaxiList");
		
		return mav;
	}

	public ModelAndView taxiSearchList(HttpSession session, String option, String word) {
		ModelAndView mav = new ModelAndView();
		
		session.setAttribute("loginId", "일반회원");
		// 임시부여한 session 으로 테스트중
		String loginId = (String) session.getAttribute("loginId");
		
		// 나와 같은 대학교에 재학중인 유저의 게시글을 불러오는 코드 
		ArrayList<BoardDTO> list = dao.taxiSearchList(loginId, option, word);
		
		// 시간 비교를 통해 마감여부를 update 해주는 코드
		dao.updateEnd();
		int allcnt = dao.allCount(loginId);
		
		// 리스트로 왔을 때 chkHit 세션을 제거해주는 코드
		// 해당 코드가 있어야만 Detail 에 다시 접근했을 때 조회수 기능을 실행할 수 있다.
		session.removeAttribute("chkHit");
		
		mav.addObject("taxiList", list);
		mav.setViewName("taxiBoard/TaxiList");
		
		return mav;
	}

	@Transactional
	public ModelAndView taxiDetail(HttpSession session, String board_idx) {
		ModelAndView mav = new ModelAndView();
		session.setAttribute("loginId", "일반회원");
		String loginId = (String) session.getAttribute("loginId");
		
		// 세션을 확인하는 코드
		String chk = (String) session.getAttribute("chkHit");
		
		// 세션에 값이 없으면 조회수 기능이 실행된다.
		if(chk == null) {
			dao.taxiUpHit(board_idx);
		}
		
		BoardDTO list = dao.taxiDetail(board_idx);
		ArrayList<PhotoDTO> photo = dao.taxiPhotoList(board_idx);
		
		mav.addObject("list", list);
		mav.addObject("photo", photo);
		
		return mav;
	}

}
