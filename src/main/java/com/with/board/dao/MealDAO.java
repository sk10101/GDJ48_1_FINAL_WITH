package com.with.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;

public interface MealDAO {

	ArrayList<BoardDTO> list();

	int MealWrite(BoardDTO dto);

	void mealFileWrite(String oriFileName, String newFileName, int board_idx, int category_id);

	void hit(String board_idx);

	BoardDTO detail(String board_idx);

	ArrayList<BoardDTO> allCount(HashMap<String, Object> map);

	ArrayList<BoardDTO> MealList(int cnt, int offset);

	ArrayList<BoardDTO> memberSearch(int cnt, int offset, String word);

	ArrayList<BoardDTO> subjectSearch(int cnt, int offset, String word);

	ArrayList<BoardDTO> placeSearch(int cnt, int offset, String word);

	int mealallCount();

	ArrayList<BoardDTO> mealList(int cnt, int offset);

	

	

	
}
