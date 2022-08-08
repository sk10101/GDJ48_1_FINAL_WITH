package com.with.member.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.with.member.dao.LoginDAO;
import com.with.member.dto.MemberDTO;

@Service
public class LoginService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired LoginDAO dao;


	public String login(String id, String pw) {
		logger.info("로그인 서비스");
		
		String hashPw = dao.login(id);
		String loginId = null;
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if(encoder.matches(pw, hashPw)) {
			loginId = id;
		}
				
		return loginId;		
		
	}
	


}
