package com.with.inquery.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.inquery.dao.InqueryDAO;
import com.with.inquery.dto.InqueryDTO;
import com.with.member.dto.MemberDTO;
@Service
public class InqueryService {
	
	@Autowired InqueryDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public ModelAndView inqueryList(String member_id, HashMap<String, Object> params) {
		ModelAndView mav = new ModelAndView("myPage/inqueryList");
		ArrayList<InqueryDTO> name = pagination(member_id,params);
		logger.info("게시글의 개수 : " + name.size());
		mav.addObject("name", name);
		mav.addObject("map", params);
		logger.info("map의 값 : {}",params);
		return mav;
	}
		
	private ArrayList<InqueryDTO> pagination(String idx, HashMap<String, Object> map) {
		int page = Integer.parseInt((String) map.get("page"));
		logger.info("page 값 : {}",page);
		int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = 0;
		int allCount = dao.allCount(idx);
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
			logger.info("word의 값 : "+word);
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
		
		ArrayList<InqueryDTO> inqueryList = new ArrayList<InqueryDTO>();
		inqueryList = dao.inqueryList(map);
		logger.info("list 값 : {}",inqueryList);
		logger.info("페이징 체크포인트");
		return inqueryList;
	}

	public int inqueryWrite(HashMap<String, Object> map) {
		return dao.inqueryWrite(map);
	}

	public HashMap<String, Object> inqueryDetail(int idx) {
		return dao.inqueryDetail(idx);
	}

	public int inqueryDelete(int idx) {
		return dao.inqueryDelete(idx);
	}

}
