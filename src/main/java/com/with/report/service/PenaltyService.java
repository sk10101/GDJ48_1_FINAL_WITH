package com.with.report.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.report.dao.PenaltyDAO;
import com.with.report.dto.PenaltyDTO;
import com.with.report.dto.ReportDTO;

@Service
public class PenaltyService {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired PenaltyDAO dao;

	public ModelAndView penaltyList(HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView("admin/penaltyList");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info(params.get("page"));
		int page = Integer.parseInt(params.get("page"));
		String word = params.get("word");
		
		map.put("page", page); //page 값 넣어줌
		//검색어가 있을경우
		if(word != "") {
			map.put("word", word);
		}
		
		ArrayList<PenaltyDTO> list = pagination(map);
		logger.info("페널티 회원 수 : " + list.size());
		mav.addObject("penalty", list);
		mav.addObject("map", map);
		return mav;
		
	}
	
	// 페이징 담당 메서드
		public ArrayList<PenaltyDTO> pagination(HashMap<String, Object> map) {
			int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
			int page = (int) map.get("page");
			String word = (String) map.get("word");
			logger.info("보여줄 페이지 : " + map.get("page"));
			logger.info("검색어 : " + " / " + map.get("word"));
			
			ArrayList<PenaltyDTO> penaltyList = new ArrayList<PenaltyDTO>();
			
			// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
			int allCnt = 0;
			
			// 한 페이지에 보여줄 게시글의 수 map 에 입력
			map.put("cnt", cnt);
			
			ArrayList<PenaltyDTO> allCount = dao.allCount(map);
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
			penaltyList = dao.penaltyList(map);
			
			logger.info("페이징 체크포인트");
			return penaltyList;
			}

		public ModelAndView penaltydetail(String penalty_idx) {
			ModelAndView mav = new ModelAndView("admin/penaltyDetail");
			logger.info("이용제한내역 상세보기 서비스");
			PenaltyDTO dto = dao.penaltydetail(penalty_idx);
			mav.addObject("list", dto);
			mav.addObject("params", penalty_idx);
			return mav;
		}

		public ModelAndView update(HashMap<String, String> params) {
			ModelAndView mav = new ModelAndView("redirect:/penaltyList.go");
			logger.info("이용제한 해제 서비스");
			String msg = "수정에 실패 했습니다.";
			boolean success = dao.update(params);
			if(success == true) {
				msg = "수정에 성공 했습니다.";
			}
			logger.info("성공 여부 :"+msg);
			logger.info("페널티 번호 : "+params.get("penalty_idx"));
			mav.addObject("msg", msg);
			return mav;
		}
}
