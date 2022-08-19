package com.with.member.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.member.dto.MannerDTO;
import com.with.member.dto.MemberDTO;

public interface MemberDAO {

	HashMap<String, Object> mblist(String member_id);

	String univer(Object object);

	int update(HashMap<String, Object> params);
	
	int macnt(String member_id);

	int average(String member_id, String nameBox);

	ArrayList<MannerDTO> madetail(HashMap<String, Object> map);

	int allCount(String idx);

	int blockCount(String idx);
	
	ArrayList<MemberDTO> blockList(HashMap<String, Object> map);

	void blockDelete(String member_id, String block_member);

	void mannerCnt(String member_id, String string, float avg);

	float avg(String member_id, String string);

	void insert(String member_id, String nameBox, int i);

	void blockUser(String member, String mb_id);

	void memberFileUpdate(String oriFileName, String newFileName, String member_id);

	String FileName(String member_id);

	String boardName(int board);

	

}
