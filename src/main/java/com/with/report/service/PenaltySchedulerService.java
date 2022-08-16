package com.with.report.service;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.report.dao.PenaltyDAO;


@Service
public class PenaltySchedulerService {
	
	@Autowired PenaltyDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// 매일 00시 마다 이용제한 기간에 따른 회원 상태 업데이트
	public void updateMbStatus() {
		logger.info("회원 상태 업데이트 스케쥴러 요청");
		
		dao.updateMbStatus();
	}
	
}
