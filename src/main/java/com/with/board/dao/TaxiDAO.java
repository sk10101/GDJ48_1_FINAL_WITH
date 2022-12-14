package com.with.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;
import com.with.member.dto.MannerDTO;
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

	ArrayList<MemberDTO> taxiParticipant(String board_idx, String loginId);

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

	int taxiApply(HashMap<String, Object> params);

	int chkStatus(HashMap<String, Object> params);

	int ptTaxi(BoardDTO dto);

	int chkReject(HashMap<String, Object> params);

	int chkElim(HashMap<String, Object> params);

	int chkSuper(HashMap<String, Object> params);

	String chkGender(HashMap<String, Object> params);

	int chkPt(String board_idx, String loginId);

	int chkSuper(String board_idx, String loginId);

	int putKind(HashMap<String, String> params);

	int putResponse(HashMap<String, String> params);

	int putTime(HashMap<String, String> params);

	String chkCate(String board_idx);

	int elimDo(String board_idx, String member_id);

}
