package com.with.board.dao;

import java.util.ArrayList;

import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;
import com.with.member.dto.MemberDTO;

public interface TaxiDAO {

	ArrayList<BoardDTO> taxiList(String loginId);

	int allCount(String loginId);

	void updateEnd();

	ArrayList<BoardDTO> taxiSearchList(String loginId, String option, String word);

	void taxiUpHit(String board_idx);

	BoardDTO taxiDetail(String board_idx);

	ArrayList<PhotoDTO> taxiPhotoList(String board_idx);

	int taxiCount(String board_idx);

	ArrayList<MemberDTO> taxiParticipant(String board_idx);

}
