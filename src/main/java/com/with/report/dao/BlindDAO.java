package com.with.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.report.dto.BlindDTO;

public interface BlindDAO {

	void superBlind(String board_idx);
	
	ArrayList<BlindDTO> blindList(HashMap<String, Object> map);
	
	ArrayList<BlindDTO> allCount(HashMap<String, Object> map);
	
	BlindDTO blindDetail(String board_idx);
	
	int updateBlind(BlindDTO dto);
	
	int updateComm(BlindDTO dto);

	void blindBoardUpdate(String board_idx);

	void blindBoardReport(String category, String board_idx, String member_id, String subject);
}
