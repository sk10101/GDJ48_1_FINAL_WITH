package com.with.history.dao;

import java.util.ArrayList;

import com.with.board.dto.BoardDTO;

public interface HistoryDAO {

/*	int allCount();

	ArrayList<BoardDTO> mygrouplistajax(int cnt, int offset, String loginId);

	ArrayList<BoardDTO> mygrouplistajax1(int cnt, int offset, String loginId);

	ArrayList<BoardDTO> mygroupsearch(String opt, String keyword);
*/
	ArrayList<BoardDTO> mygList(String loginId);

	ArrayList<BoardDTO> mygList1(String loginId);

	

	//ArrayList<HistoryDTO> myglist(String opt, String keyword);


}
