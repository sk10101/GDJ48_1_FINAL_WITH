package com.with.member.dao;

import java.util.ArrayList;

import com.with.member.dto.MemberDTO;

public interface JoinDAO {

	int join(MemberDTO dto);

	ArrayList<MemberDTO> empList();

	ArrayList<MemberDTO> empSearch(String university_name);

}
