package com.with.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;

public interface MealDAO {

	/* ArrayList<BoardDTO> list(); */

	int MealWrite(BoardDTO dto);

	void mealFileWrite(String oriFileName, String newFileName, int board_idx, int category_id);

	void hit(String board_idx);

	BoardDTO detail(String board_idx);


//	int allCount(String loginId);
//
//	ArrayList<BoardDTO> mealList(int cnt, int offset, String loginId);

	ArrayList<BoardDTO> searchList(String option, String word);

	ArrayList<BoardDTO> list();

	

	

	
}
