package com.with.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;
import com.with.member.dto.MemberDTO;

public interface MealDAO {
	
	ArrayList<BoardDTO> mealList(HashMap<String, Object> map);
	
	void hit(String board_idx);
	
	

	
	void endUpdate();

	int writeBcc(BoardDTO dto);
	
	int writeMeal(BoardDTO dto);
	
	int getBoardIdx(BoardDTO dto);

	void mealFileWrite(String oriFileName, String newFileName, int board_idx, String category);


	ArrayList<BoardDTO> allCount(HashMap<String, Object> map);

	MemberDTO getUniversityAddr(String loginid);

	BoardDTO mealDetail(String board_idx);

	ArrayList<PhotoDTO> mealPhotoList(String board_idx, String string);


	
	ArrayList<BoardDTO> partList(String board_idx);

	void mealApply(String member_id, String board_idx);

	

	
	



	


	




	

	

	

	
}
