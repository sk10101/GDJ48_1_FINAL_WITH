package com.with.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;
import com.with.member.dto.MemberDTO;

public interface TaxiDAO {

//	ArrayList<BoardDTO> taxiList(String loginId);

//	int allCount(String loginId);

	void updateEnd();

	ArrayList<BoardDTO> taxiSearchList(String loginId, String option, String word);

	void taxiUpHit(String board_idx);

	BoardDTO taxiDetail(String board_idx);

	ArrayList<PhotoDTO> taxiPhotoList(String board_idx, String string);

	int taxiCount(String board_idx);

	ArrayList<MemberDTO> taxiParticipant(String board_idx);

	int writeBcc(BoardDTO dto);

	int getBoardIdx(BoardDTO dto);

	int writeTaxi(BoardDTO dto);

	void taxiFileWrite(String oriFileName, String newFileName, int board_idx, String category);

//	ArrayList<BoardDTO> allCount(HashMap<String, Object> map, String loginId);


	int allCount(HashMap<String, Object> map);

	ArrayList<BoardDTO> taxiList(HashMap<String, Object> map);

	String univFind(String loginId);

	String findPhone(String loginId);

	int recruitEnd(String board_idx);

	int taxiApply(String board_idx);


}
