package com.with.member.dao;

import java.util.ArrayList;

import com.with.member.dto.MemberDTO;

public interface JoinDAO {

	int join(MemberDTO dto);

	ArrayList<MemberDTO> empSearch(String empkeyword);

	ArrayList<MemberDTO> empList();

	ArrayList<MemberDTO> empSearch(int university_idx, String university_name);

}
