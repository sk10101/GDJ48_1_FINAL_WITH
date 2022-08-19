package com.with.history.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;

public interface HistoryDAO {

/*	int allCount();

	ArrayList<BoardDTO> mygrouplistajax(int cnt, int offset, String loginId);

	ArrayList<BoardDTO> mygrouplistajax1(int cnt, int offset, String loginId);

	ArrayList<BoardDTO> mygroupsearch(String opt, String keyword);
*/


	
	


	ArrayList<BoardDTO> allCount(HashMap<String, Object> map);

	ArrayList<BoardDTO> mygList(HashMap<String, Object> map);

	void applyClose(HashMap<String, String> params);

	void mygApplyDelete(HashMap<String, String> params);

	

	//ArrayList<HistoryDTO> myglist(String opt, String keyword);


}
