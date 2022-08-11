package com.with.member.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.member.dto.MemberDTO;

public interface AdminDAO {

	ArrayList<MemberDTO> userList(HashMap<String, String> params);

	MemberDTO userDetail(String member_id);

	ArrayList<MemberDTO> adminList();

	void pass(String member_id);

	ArrayList<MemberDTO> search(String name);

	ArrayList<MemberDTO> usersearch(String opt, String keyword);

	int allCount();

}
