package com.with.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;

public interface MealDAO {

	/* ArrayList<BoardDTO> list(); */
	ArrayList<BoardDTO> list();


	void hit(String board_idx);

	BoardDTO detail(String board_idx);


	ArrayList<BoardDTO> searchList(String option, String word);

	int writeBcc(BoardDTO dto);
	
	int getBoardIdx(BoardDTO dto);

	int writeMeal(BoardDTO dto);
	
	void mealFileWrite(String oriFileName, String newFileName, int board_idx, String category);
	




	

	

	

	
}
