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

	void applyUpdate(HashMap<String, Object> params);


	ArrayList<BoardDTO> mealCount(HashMap<String, Object> map);

	ArrayList<BoardDTO> mealApplyList(HashMap<String, Object> map);


	
	void applyCancle(HashMap<String, String> params);

	void applyDelete(HashMap<String, String> params);

	



	void refuse(HashMap<String, String> params);

	void taxiApplyUpdate(HashMap<String, Object> params);

	void mealApplyUpdate(HashMap<String, Object> params);

	BoardDTO deliList(HashMap<String, String> params);

	BoardDTO taxiList(HashMap<String, String> params);

	BoardDTO mealList(HashMap<String, String> params);

	void part(HashMap<String, Object> params);

	int update(String board_idx);

	int taxiupdate(String board_idx);

	int mealupdate(String board_idx);

	


}