package com.with.board.dao;

import java.util.ArrayList;

import com.with.board.dto.BoardDTO;

public interface TaxiDAO {

	ArrayList<BoardDTO> taxiList(int cnt, int offset, String loginId);

	int allCount(String loginId);

	void updateEnd();

}
