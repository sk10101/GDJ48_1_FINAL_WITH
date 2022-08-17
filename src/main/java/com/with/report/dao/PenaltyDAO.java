package com.with.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.report.dto.PenaltyDTO;

public interface PenaltyDAO {

	void updateMbStatus();

	ArrayList<PenaltyDTO> allCount(HashMap<String, Object> map);

	ArrayList<PenaltyDTO> penaltyList(HashMap<String, Object> map);

	PenaltyDTO penaltydetail(String penalty_idx);

	boolean update(HashMap<String, String> params);

}
