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

	int mealCount(String board_idx);

	String mealPhone(String loginId);

	void updateEnd();

	int partMeal(String member_id, int board_idx);

	int partMemberChk(String attribute, String board_idx);

	void applyDeli(String member_id, String board_idx);

	ArrayList<MemberDTO> partMaster(String member_id);

	void mealBan(String member_id, String board_idx);

	int recruitEnd(String board_idx);

	int chkStatus(HashMap<String, Object> params);

	int chkReject(HashMap<String, Object> params);

	int chkElim(HashMap<String, Object> params);

	String chkGender(HashMap<String, Object> params);

	int mealApplys(HashMap<String, Object> params);

	String chkCate(String board_idx);

	int putKind(HashMap<String, String> params);

	int putResponse(HashMap<String, String> params);

	int putTime(HashMap<String, String> params);

	

	
	



	


	




	

	

	

	
}
