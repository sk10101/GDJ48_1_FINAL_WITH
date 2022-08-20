package com.with.member.dao;

import java.util.ArrayList;

import com.with.member.dto.MemberDTO;

public interface JoinDAO {

	int join(MemberDTO dto);

	ArrayList<MemberDTO> univList();

	ArrayList<MemberDTO> univSearch(String university_name);

	void memberFileWrite(String oriFileName, String newFileName, String member_id);

	String IdOverlay(String chkId);

	String EmailOverlay(String chkEmail);
}
