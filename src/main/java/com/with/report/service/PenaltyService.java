package com.with.report.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.report.dao.PenaltyDAO;

@Service
public class PenaltyService {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired PenaltyDAO dao;
}
