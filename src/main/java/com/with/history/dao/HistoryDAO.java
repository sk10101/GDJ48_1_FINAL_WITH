package com.with.history.dao;

import java.util.ArrayList;

import com.with.history.dto.HistoryDTO;

public interface HistoryDAO {

	int sendallCount(String loginId);
	
	ArrayList<HistoryDTO> mygrouplist(int cnt, int offset, String loginId);


}
