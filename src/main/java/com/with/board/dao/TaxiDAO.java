package com.with.board.dao;

import java.util.ArrayList;

import com.with.board.dto.BoardDTO;

public interface TaxiDAO {

	ArrayList<BoardDTO> taxiList();

	int allCount();

}
