package com.with.report.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.member.dto.MemberDTO;
import com.with.report.dao.ReportDAO;
import com.with.report.dto.ReportDTO;

@Service
public class ReportService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired ReportDAO dao;

	public ModelAndView reportlist(HashMap<String, String> params) {
		logger.info("신고 내역 요청 서비스");
		ModelAndView mav = new ModelAndView("admin/reportList");
		// 페이징 처리
		HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		
		map.put("page", page); // page 입력
		// 검색어를 입력했을 때
		if(word != "") {
			map.put("word", word); // 검색어 입력
			map.put("option", option); // 검색 옵션 입력
		}
		
		ArrayList<ReportDTO> reportList = pagination(map);
		logger.info("일반 회원 인원 : "+ reportList.size());
		mav.addObject("list", reportList);	
		mav.addObject("map",map);
		return mav;
		
	}

	public ModelAndView reportsend(HashMap<String, String> params) {
		logger.info("게시글 신고 서비스");
		ModelAndView mav = new ModelAndView("reportWrite");
		HashMap<String, String> map = new HashMap<String, String>();
		int reportchk = dao.reportchk(params);
		logger.info("신고 횟수 : "+reportchk);
		String msg = "이미 신고한 게시글 입니다.";
		if(reportchk == 0) {
			msg = "신고에 성공 했습니다.";
			map.put("board_idx", params.get("board_idx"));
			if(params.get("check").equals("기타")) {
				map.put("report_content", params.get("textbox"));
			} else {
				map.put("report_content", params.get("check"));			
			}
			map.put("loginId", params.get("loginId"));
			dao.reportsend(map);
		}
		logger.info(msg);
		mav.addObject("msg", msg);
		return mav;
		}

	public ModelAndView reportdetail(String report_idx) {
		ModelAndView mav = new ModelAndView("admin/reportDetail");
		ReportDTO list = dao.reportdetail(report_idx);
		logger.info("가져온값 : "+list.getBoard_idx());
		// dto 에서 member_id 뽑아와서 이걸로 penalty 테이블가서 가져온다. (조건 1. member_id 같아야하고, 조건 2. penalty_end < now()
		ReportDTO penaltylist = dao.penaltydetail(list.getMember_id());
		//logger.info("페널티에서 가져온 값 : " + penaltylist.getPenalty_end());
		mav.addObject("info", list);
		mav.addObject("penaltyinfo", penaltylist);
		return mav;
	}

	public String reportcom(HashMap<String, String> params) {
		logger.info("신고 처리 서비스");
		//ModelAndView mav = new ModelAndView("admin/reportDetail");
		logger.info(params.get("report_reason")+params.get("penalty_end")+params.get("status")+params.get("member_id")+params.get("report_idx"));
		String msg = "신고 처리에 실패 했습니다.";
		boolean success = dao.reportcom(params);
		dao.penaltycom(params);
		logger.info("success");
		/*if(success == true) {
			msg = "신고 처리 되었습니다.";
		}
		mav.addObject("msg", msg);*/
		return "redirect:/reportList.go";
	}
	
	// 페이징 담당 메서드
	public ArrayList<ReportDTO> pagination(HashMap<String, Object> map) {
		int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
		int page = (int) map.get("page");
		String option = (String) map.get("option");
		String word = (String) map.get("word");
		logger.info("보여줄 페이지 : " + map.get("page"));
		logger.info("검색 옵션 / 검색어 : " + map.get("option") + " / " + map.get("word"));
		
		ArrayList<ReportDTO> reportList = new ArrayList<ReportDTO>();
		
		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = 0;
		
		// 한 페이지에 보여줄 게시글의 수 map 에 입력
		map.put("cnt", cnt);
		
		ArrayList<ReportDTO> allCount = dao.allCount(map);
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
		reportList = dao.reportList(map);
		
		logger.info("페이징 체크포인트");
		return reportList;
		}
	
}


