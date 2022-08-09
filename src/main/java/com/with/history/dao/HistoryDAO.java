package com.with.history.dao;

import java.util.ArrayList;

import com.with.board.dto.BoardDTO;

public interface HistoryDAO {

	int allCount();

	ArrayList<BoardDTO> mygrouplistajax(int cnt, int offset, String loginId);

	ArrayList<BoardDTO> mygrouplistajax1(int cnt, int offset, String loginId);

	//ArrayList<HistoryDTO> myglist(String opt, String keyword);


}
