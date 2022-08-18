package com.with.member.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.member.dto.MemberDTO;

public interface AdminDAO {

	ArrayList<MemberDTO> userList(HashMap<String, Object> map);

	MemberDTO userDetail(String member_id);

	void pass(String member_id);

	ArrayList<MemberDTO> allCount(HashMap<String, Object> map);

	String filedetail(String member_id);

}
