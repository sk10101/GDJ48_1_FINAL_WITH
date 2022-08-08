package com.with.history.dao;

import java.util.ArrayList;

import com.with.history.dto.HistoryDTO;

public interface HistoryDAO {

	ArrayList<HistoryDTO> mygrouplist(int cnt, int offset, String loginId);

	int historyallCount(String loginId);

	//ArrayList<HistoryDTO> myglist(String opt, String keyword);


}
