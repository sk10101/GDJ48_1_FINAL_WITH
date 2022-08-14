package com.with.report.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.report.dao.ReportDAO;
import com.with.report.dto.ReportDTO;

@Service
public class ReportService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired ReportDAO dao;

	public ModelAndView reportlist() {
		logger.info("신고 내역 요청 서비스");
		ModelAndView mav = new ModelAndView("admin/reportList");
		ArrayList<ReportDTO> list = dao.reportlist();
		mav.addObject("list", list);
		return mav;
	}
	
	public ModelAndView reportsend(HashMap<String, String> params) {
		logger.info("게시글 신고 서비스");
		ModelAndView mav = new ModelAndView("admin/reportWrite");
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
			dao.reportsend(map);
		}
		mav.addObject("msg", msg);
		return mav;
		}

	public ModelAndView reportdetail(String report_idx) {
		ModelAndView mav = new ModelAndView("admin/reportDetail");
		ReportDTO list = dao.reportdetail(report_idx);
		mav.addObject("info", list);
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
	
	
}


