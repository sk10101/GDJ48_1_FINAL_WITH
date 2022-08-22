package com.with.member.dao;

import java.sql.Date;
import java.util.HashMap;

import com.with.member.dto.KakaoDTO;
import com.with.member.dto.MemberDTO;

public interface LoginDAO {

	String login(String id,String pw);
	
	MemberDTO getMbInfo(String id);

	void kakaoinsert(HashMap<String, Object> userInfo);

	KakaoDTO findkakao(HashMap<String, Object> userInfo);

	KakaoDTO kakaoNumber(KakaoDTO userInfo);

	String getMbClass(String id);

	String idFind(String name, String email);

	int pwFind(String id, String email);

	boolean newPw(String id, String pw);

	Date chkPenalty(String loginId);

	// 8.20 정현민 추가
	String chkGender(String loginId);

}
