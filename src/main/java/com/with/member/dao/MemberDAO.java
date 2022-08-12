package com.with.member.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.member.dto.MannerDTO;
import com.with.member.dto.MemberDTO;

public interface MemberDAO {

	HashMap<String, Object> mblist(String member_id);

	String univer(Object object);

	void update(String member_pw, String phone, int hide, String member_id);

	int macnt(String member_id);

	int average(String member_id, String nameBox);

	ArrayList<MannerDTO> madetail(HashMap<String, Object> map);

	int allCount(String idx);

	int blockCount(String idx);
	
	ArrayList<MemberDTO> blockList(HashMap<String, Object> map);

	void blockDelete(String member_id, String block_member);

}
