package com.with.board.dao;

import java.util.ArrayList;

import com.with.board.dto.BoardDTO;

public interface DeliveryDAO {

	ArrayList<BoardDTO> deliList();

	void upHit(String board_idx);
	
	BoardDTO deliDetail(String board_idx);


}
