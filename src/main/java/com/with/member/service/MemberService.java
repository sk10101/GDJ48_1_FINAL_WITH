package com.with.member.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.member.dao.MemberDAO;

@Service
public class MemberService {
	@Autowired MemberDAO dao;
	public HashMap<String, Object> mblist(String idx) {
		return dao.mblist(idx);
	}
	public String univer(Object object) {
		return dao.univer(object);
	}
	
	
	
}
