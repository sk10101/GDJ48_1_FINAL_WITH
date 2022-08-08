package com.with.board.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.with.board.dao.MealDAO;
import com.with.board.dto.BoardDTO;

@Service
public class MealService {
	@Autowired MealDAO dao;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	public ArrayList<BoardDTO> list() {
		logger.info("리스트 요청 서비스");
		return dao.list();
		
	}
	public void MealWrite(MultipartFile[] photos, HashMap<String, String> params) {
		logger.info("식사 게시판 글쓰기 서비스 요청");
		
		BoardDTO dto = new BoardDTO();
		dto.setAppoint_place(params.get("appoint_plae"));
		
		int row = dao.MealWrite(dto);
		logger.info(row + "글 작성 성공");
		
		int board_idx = dto.getBoard_idx();
		logger.info("방금 넣은 글 번호 : "+board_idx);
		logger.info("photos : "+ photos);
		
		if(row > 0) {
			mealFileSave(photos, board_idx, 1);
		}
		
	}
	private void mealFileSave(MultipartFile[] photos, int board_idx, int category_id) {
		for(MultipartFile photo : photos) {
			String oriFileName = photo.getOriginalFilename();
			
			if(!oriFileName.equals("")) {
				logger.info("업로드 진행");
				
				String ext = oriFileName.substring(oriFileName.lastIndexOf(".")).toLowerCase();
				
				String newFileName = System.currentTimeMillis() + ext;
				
				logger.info(oriFileName+ "===>" + newFileName);
				
				
				try {
					byte[] arr = photo.getBytes();
					Path path = Paths.get("C:\\Users\\GDJ48\\Documents\\GDJ48_1_FINAL_WITH\\src\\main\\webapp\\resources\\photo\\" + newFileName);
					Files.write(path, arr);
					logger.info(newFileName + "저장 완료");
					dao.mealFileWrite(oriFileName,newFileName,board_idx, category_id);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}	
		}
		//
		
		
	}
	
	
	public BoardDTO detail(String board_idx) {
		// TODO Auto-generated method stub
		return null;
	}
	

	
	
}
