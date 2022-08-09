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
	public void update(String member_pw, String phone, int hide, String member_id) {
		dao.update(member_pw,phone,hide,member_id);
		
	}
	public int macnt(String member_id) {
		return dao.macnt(member_id);
	}
	public int average(String member_id, String nameBox) {
		return dao.average(member_id,nameBox);
	}
	
}
