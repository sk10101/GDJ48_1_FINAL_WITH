package com.with.board.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

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
	
	// 글쓰기 서비스
	public void write(MultipartFile[] photos, BoardDTO dto) {
		logger.info("글쓰기 서비스 요청");
		// 이후에 로그인한 아이디를 담아주는 것으로 변경해야함
		dto.setMember_id("gustn0055");
		// 공통 컬럼 테이블에 작성할 내용
		int row = dao.writeBcc(dto);
		// 밥 전용 컬럼 테이블에 작성하기 위해 위에서 작성했던 글의 번호를 가져와야함
		int board_idx = dao.getBoardIdx(dto);
		dto.setBoard_idx(board_idx);
		// 밥 전용 컬럼 테이블에 작성할 내용
		int row2 = dao.writeMeal(dto);
		
		// 파일을 올리지 않아도 fileSave 가 진행되는 것을 방지하는 조건문
		if(row > 0 & row2 > 0) {
			mealFileSave(photos, board_idx, "배달게시판");
		}
		
		logger.info("성공 여부 : " + row + " / " + row2);
	}
		
	
	

	
	
	// 파일 업로드 서비스
	@Transactional
	private void mealFileSave(MultipartFile[] photos, int board_idx, String category_id) {
		 {
		// 카테고리 번호 전달(1. 공지사항, 2. 건의사항, 3. 답변)
			String category = category_id;
			
		// 이미지 파일 업로드
		for (MultipartFile photo : photos) {
			String oriFileName = photo.getOriginalFilename();
			
			// 이미지 파일을 업로드 안했을 때를 제외하기 위한 조건문 처리
			if(!oriFileName.equals("")) {
				logger.info("업로드 진행");
				// 확장자 추출
				String ext = oriFileName.substring(oriFileName.lastIndexOf(".")).toLowerCase();
				// 새 파일 이름으로 업로드 당시 시간을 붙인다.
				String newFileName = System.currentTimeMillis() + ext;
				
				logger.info(oriFileName + " ===> " + newFileName);
				
				try {
					byte[] arr = photo.getBytes();
					Path path = Paths.get("C:\\Users\\GDJ48\\Documents\\GDJ48_1_FINAL_WITH\\src\\main\\webapp\\resources\\photo\\" + newFileName);
					// 같은이름의 파일이 나올 수 없기 떄문에 옵션 설정 안해도된다.
					Files.write(path, arr);
					logger.info(newFileName + " SAVE OK");
					// 4. 업로드 후 photo 테이블에 데이터 입력
					dao.mealFileWrite(oriFileName,newFileName,board_idx,category);
					
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
			
		}
	
		
	}
	
	
	public BoardDTO detail(String board_idx) {
		logger.info("상세보기 서비스 요청");
		dao.hit(board_idx);
		return dao.detail(board_idx);
	}

	

	public ModelAndView searchList(String option, String word) {
		logger.info("옵션 / 검색어 : " + option + " / " + word);
		ModelAndView mav = new ModelAndView("mealBoard/MealList");
		
		ArrayList<BoardDTO> searchList = dao.searchList(option,word);
		logger.info("검색 건수 : "+ searchList.size());
		mav.addObject("mealList",searchList);
		
		return mav;
	}






	
}
	
	

	
	

