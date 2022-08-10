package com.with.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;

public interface MealDAO {
	
	ArrayList<BoardDTO> mealList(HashMap<String, Object> map);
	
	void hit(String board_idx);
	

	BoardDTO detail(String board_idx);

	void endUpdate();

	int writeBcc(BoardDTO dto);
	
	int writeMeal(BoardDTO dto);
	
	int getBoardIdx(BoardDTO dto);

	void mealFileWrite(String oriFileName, String newFileName, int board_idx, String category);


	ArrayList<BoardDTO> allCount(HashMap<String, Object> map);


	


	




	

	

	

	
}
