package com.with.main.dao;

import java.util.ArrayList;

import com.with.board.dto.BoardDTO;

public interface MainDAO {

	String getUniv(String loginId);

	ArrayList<BoardDTO> recruitIng(String loginId);

	ArrayList<BoardDTO> partIng(String loginId);

	int recruitCnt(String loginId);

	int partCnt(String loginId);

}
