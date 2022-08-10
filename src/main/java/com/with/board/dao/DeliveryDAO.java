package com.with.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;

public interface DeliveryDAO {

	ArrayList<BoardDTO> deliList(HashMap<String, Object> map);

	void upHit(String board_idx);
	
	BoardDTO deliDetail(String board_idx);

	ArrayList<BoardDTO> searchList(String option, String word);

	void endUpdate();

	int writeBcc(BoardDTO dto);

	int writeDeli(BoardDTO dto);

	int getBoardIdx(BoardDTO dto);

	void deliFileWrite(String oriFileName, String newFileName, int board_idx, String category);

	ArrayList<PhotoDTO> deliPhotoList(String board_idx, String string);

	ArrayList<BoardDTO> allCount(HashMap<String, Object> map);



}
