package com.with.apply.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.board.dto.BoardDTO;

public interface ApplyDAO {

	ArrayList<BoardDTO> allCount(HashMap<String, Object> map);

	ArrayList<BoardDTO> myApplyList(HashMap<String, Object> map);

}
