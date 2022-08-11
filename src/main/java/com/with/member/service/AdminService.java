package com.with.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.dto.BoardDTO;
import com.with.member.dao.AdminDAO;
import com.with.member.dto.MemberDTO;

@Service
public class AdminService {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired AdminDAO dao;
	
	public ModelAndView userList(HashMap<String, String> params) {
		logger.info("유저 목록 조회 서비스");
		
		String member_class = "일반회원";
		if(params.get("member_class") != null) {
			if(params.get("member_class").equals("관리자")) {
				member_class = params.get("member_class");
			}
		}

		String pagePath = "admin/userList";
		if(member_class.equals("관리자")) {
			pagePath = "admin/managerList";
		}
		ModelAndView mav = new ModelAndView(pagePath);

		// 페이징 처리
		HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		logger.info(params.get("member_class"));
		if((word != null || word != "") && member_class.equals("일반회원")) {
			if(option.equals("certficate") && (word.equals("n") || word.equals("N"))) {
				word = "0";
			} else if(option.equals("certficate") && (word.equals("y") || word.equals("Y"))) {
				word = "1";
			}
		}
		map.put("member_class",member_class);
		map.put("page", page); // page 입력
		// 검색어를 입력했을 때
		if(word != "") {
			map.put("word", word); // 검색어 입력
			if(member_class.equals("일반회원")) {
				map.put("option", option); // 검색 옵션 입력
			}
		}
		
		ArrayList<MemberDTO> userList = pagination(map);
		logger.info("일반 회원 인원 : "+ userList.size());
		mav.addObject("list", userList);	
		mav.addObject("map",map);
		return mav;
	}

	public ModelAndView userDetail(String member_id) {
		logger.info("유저 상세보기 서비스 요청");
		ModelAndView mav = new ModelAndView("admin/userDetail");
		MemberDTO dto = dao.userDetail(member_id);
		mav.addObject("dto", dto);
		
		return mav;
	}

	public void pass(String member_id) {
		logger.info("대학교 인증 요청 서비스");
		dao.pass(member_id);
	}

	// 페이징 담당 메서드
	public ArrayList<MemberDTO> pagination(HashMap<String, Object> map) {
		int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
		int page = (int) map.get("page");
		String option = (String) map.get("option");
		String word = (String) map.get("word");
		String member_class = (String) map.get("member_class");
		logger.info("검색할때 멤버 클래스 가져오는지 ? :"+member_class);
		logger.info("보여줄 페이지 : " + map.get("page"));
		logger.info("검색 옵션 / 검색어 : " + map.get("option") + " / " + map.get("word"));
		
		ArrayList<MemberDTO> userList = new ArrayList<MemberDTO>();
		
		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = 0;
		
		// 한 페이지에 보여줄 게시글의 수 map 에 입력
		map.put("cnt", cnt);
		
		ArrayList<MemberDTO> allCount = dao.allCount(map);
		allCnt = allCount.size();
		logger.info("allCnt : " + allCnt);
		
		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if(allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			allCnt = 1;
		}
		
		int pages = allCnt%cnt != 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		logger.info("pages : " + pages);
		
		if (page > pages) {
			page = pages;
		}
		
		map.put("pages", pages); // 최대 페이지 수
		int offset = cnt * (page-1);
		logger.info("offset : "+offset);
		
		map.put("offset", offset);
		map.put("currPage", page); // 현재 페이지
		map.put("member_class", member_class);
		userList = dao.userList(map);
		
		logger.info("페이징 체크포인트");
		return userList;
		}
	
	
	
}
