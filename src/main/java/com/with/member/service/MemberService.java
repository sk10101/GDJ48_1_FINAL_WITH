package com.with.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.member.dao.MemberDAO;
import com.with.member.dto.MannerDTO;
import com.with.member.dto.MemberDTO;

@Service
public class MemberService {
	@Autowired MemberDAO dao;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public HashMap<String, Object> mblist(String member_id) {
		return dao.mblist(member_id);
	}

	public String univer(Object object) {
		return dao.univer(object);
	}

	public void update(String member_pw, String phone, int hide, String member_id) {
		dao.update(member_pw, phone, hide, member_id);

	}

	public int macnt(String member_id) {
		return dao.macnt(member_id);
	}

	public int average(String member_id, String nameBox) {
		return dao.average(member_id, nameBox);
	}

	public ModelAndView madetail(String member_id, int page) {
		// 페이징 처리
		ModelAndView mav = new ModelAndView("myPage/mannerDetail");
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<MannerDTO> mannerList = pagination(member_id, page, map);
		logger.info("게시글의 개수 : " + mannerList.size());
		mav.addObject("manner", mannerList);
		mav.addObject("map", map);
		return mav;
	}

	private ArrayList<MannerDTO> pagination(String idx, int page, HashMap<String, Object> map) {
		int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
		logger.info("페이지 갯수 : {}", page);
		ArrayList<MannerDTO> madetail = new ArrayList<MannerDTO>();

		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = 0;
		int allCount = dao.allCount(idx);
		logger.info("allCount : {}",allCount);
		allCnt = allCount/3;
		logger.info("allCnt : " + allCnt);

		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if (allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			allCnt = 1;
		}

		int pages = allCnt % cnt != 0 ? (allCnt / cnt) + 1 : (allCnt / cnt);
		logger.info("pages : " + pages);

		if (page > pages) {
			page = pages;
		}
		map.put("idx",idx);
		map.put("cnt",cnt);
		map.put("page",page);
		map.put("pages", pages); // 최대 페이지 수
		int offset = cnt * (page - 1);
		logger.info("offset : " + offset);

		map.put("offset", offset);
		map.put("currPage", page); // 현재 페이지

		madetail = dao.madetail(map);
		
		logger.info("페이징 체크포인트");
		return madetail;
	}

	public ModelAndView blockList(String member_id, HashMap<String, Object> params) {
		ModelAndView mav = new ModelAndView("myPage/blockUserList");
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<MemberDTO> name = blockPagination(member_id, params);
		logger.info("게시글의 개수 : " + name.size());
		mav.addObject("name", name);
		mav.addObject("map", map);
		return mav;
	}
	
	private ArrayList<MemberDTO> blockPagination(String idx,HashMap<String, Object> map) {
		int page = Integer.parseInt((String) map.get("page"));
		int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = 0;
		int allCount = dao.blockCount(idx);
		logger.info("allCount : {}",allCount);
		allCnt = allCount;
		logger.info("allCnt : " + allCnt);

		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if (allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			allCnt = 1;
		}
		String word = (String) map.get("word");
		if(word != "") {
			map.put("word", word); // 검색어 입력
		}
		
		int pages = allCnt % cnt != 0 ? (allCnt / cnt) + 1 : (allCnt / cnt);
		logger.info("pages : " + pages);
		
		if (page > pages) {
			page = pages;
		}
		map.put("idx",idx);
		map.put("cnt",cnt);
		map.put("page",page);
		map.put("pages", pages); // 최대 페이지 수
		int offset = cnt * (page - 1);
		logger.info("offset : " + offset);

		map.put("offset", offset);
		map.put("currPage", page); // 현재 페이지
		
		ArrayList<MemberDTO> block = new ArrayList<MemberDTO>();
		block = dao.blockList(map);
		logger.info("페이징 체크포인트");
		return block;
	}

	public void blockDelete(String member_id, String block_member) {
		dao.blockDelete(member_id,block_member);
	}
}
