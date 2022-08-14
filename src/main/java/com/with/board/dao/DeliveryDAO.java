package com.with.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;
import com.with.member.dto.MemberDTO;

public interface DeliveryDAO {

	ArrayList<BoardDTO> deliList(HashMap<String, Object> map);

	void upHit(String board_idx);
	
	BoardDTO deliDetail(String board_idx);

	void endUpdate();

	int writeBcc(BoardDTO dto);

	int writeDeli(BoardDTO dto);

	int getBoardIdx(BoardDTO dto);

	void deliFileWrite(String oriFileName, String newFileName, int board_idx, String category);

	ArrayList<PhotoDTO> deliPhotoList(String board_idx, String string);

	ArrayList<BoardDTO> allCount(HashMap<String, Object> map);

	MemberDTO getUnivAddr(String loginid);

	ArrayList<BoardDTO> partList(String board_idx);

	void applyDeli(String member_id, String board_idx, String investment);

	int isApplied(String member_id, String board_idx);

	int isRejected(String member_id, String board_idx);

	int isBanned(String member_id, String board_idx);

	void deliBan(String member_id, String board_idx);

	ArrayList<MemberDTO> partMaster(String member_id);

	int partMemberChk(String member_id, String board_idx);

	int applyCnt(String board_idx);

	int partCnt(String board_idx);

	int isEnd(String board_idx);

	int deliDelete(String board_idx);

	void photoDel(String board_idx);

	void applyMaster(String member_id, int board_idx);

	String getCategory(String board_idx);

	String getGender(String member_id);




}
