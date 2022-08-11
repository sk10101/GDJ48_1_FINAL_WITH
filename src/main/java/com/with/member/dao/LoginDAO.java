package com.with.member.dao;

import java.util.HashMap;

import com.with.member.dto.KakaoDTO;

public interface LoginDAO {

	String login(String id,String pw);

	void kakaoinsert(HashMap<String, Object> userInfo);

	KakaoDTO findkakao(HashMap<String, Object> userInfo);

	KakaoDTO kakaoNumber(KakaoDTO userInfo);

	String getMbClass(String id, String pw);

	

}
