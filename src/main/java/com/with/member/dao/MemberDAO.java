package com.with.member.dao;

import java.util.HashMap;

public interface MemberDAO {

	HashMap<String, Object> mblist(String idx);

	String univer(Object object);

	void update(String member_pw, String phone, int hide, String member_id);

	int macnt(String member_id);

	int average(String member_id, String nameBox);

}
