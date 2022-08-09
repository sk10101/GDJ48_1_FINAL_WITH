package com.with.board.service;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.board.dao.DeliveryDAO;

@Service
public class DeliSchedulerService {
	
	@Autowired DeliveryDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// 모집시간이 지나면 게시글을 마감처리하기
	public void deadline() {
		logger.info("게시글 마감 처리하기 요청");
		
		dao.endUpdate();
	}
	
}
