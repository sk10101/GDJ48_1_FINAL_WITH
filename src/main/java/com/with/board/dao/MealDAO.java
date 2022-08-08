package com.with.board.dao;

import java.util.ArrayList;

import com.with.board.dto.BoardDTO;

public interface MealDAO {

	ArrayList<BoardDTO> list();

	int MealWrite(BoardDTO dto);

	void mealFileWrite(String oriFileName, String newFileName, int board_idx, int category_id);



	
}
