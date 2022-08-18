package com.with.apply.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;

public interface ApplyDAO {

	ArrayList<BoardDTO> allCount(HashMap<String, Object> map);

	ArrayList<BoardDTO> myApplyList(HashMap<String, Object> map);

	ArrayList<BoardDTO> deliallCount(HashMap<String, Object> map);

	ArrayList<BoardDTO> deliApplyList(HashMap<String, Object> map);

	ArrayList<BoardDTO> taxiallCount(HashMap<String, Object> map);

	ArrayList<BoardDTO> taxiApplyList(HashMap<String, Object> map);

	void applyUpdate(HashMap<String, String> params);

	void taxiApplyUpdate(HashMap<String, String> params);
	

	ArrayList<BoardDTO> mealCount(HashMap<String, Object> map);

	ArrayList<BoardDTO> mealApplyList(HashMap<String, Object> map);


	void mealApplyUpdate(HashMap<String, String> params);

	void applyCancle(HashMap<String, String> params, String board_idx, String apply_idx);

	void applyDelete(HashMap<String, String> params);

	void part(HashMap<String, String> params);

}