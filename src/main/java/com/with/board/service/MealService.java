package com.with.board.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.with.board.dao.MealDAO;
import com.with.board.dto.BoardDTO;
import com.with.history.dto.HistoryDTO;

@Service
public class MealService {
	@Autowired MealDAO dao;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	public ArrayList<BoardDTO> list() {
		logger.info("리스트 요청 서비스");
		return dao.list();
		
	}
	/*
	public void MealWrite(MultipartFile[] photos, HashMap<String, String> params) {
		try {
			logger.info("식사 게시판 글쓰기 서비스 요청");
			
			BoardDTO dto = new BoardDTO();
			dto.setAppoint_place(params.get("appoint_place"));
			dto.setMember_id(params.get("member_id"));
			dto.setCategory_id(params.get("category_id"));
			dto.setSubject(params.get("subject"));
			dto.setContent(params.get("content"));
			dto.setGender(params.get("gender"));
			dto.setAppoint_coords(params.get("appoint_coords"));
			dto.setMember_cnt(Integer.parseInt(params.get("option")));
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        String strDate = params.get("Deadline");
	        Date date = sdf.parse(strDate);
	        			 
			    		
			
			int row = dao.MealWrite(dto);
			logger.info(row + "글 작성 성공");
			
			int board_idx = dto.getBoard_idx();
			logger.info("방금 넣은 글 번호 : "+board_idx);
			logger.info("photos : "+ photos);
			
			if(row > 0) {
				mealFileSave(photos, board_idx, 1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	*/
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
		logger.info("상세보기 서비스 요청");
		dao.hit(board_idx);
		return dao.detail(board_idx);
	}
	public HashMap<String, Object> MealList(HashMap<String, String> params) {
		/*
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		logger.info("서비스 리스트 요청 : {}", params);
		logger.info("보여줄 페이지 : " + page);
		
		ArrayList<BoardDTO> searchList = new ArrayList<BoardDTO>();
		
		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = 0;
		
		map.put("cnt", cnt);
		
		if (word != null && word != "") {
			map.put("word", word);
			map.put("option", option);
		}
		// 출력할 게시글의 개수를 세어준다.
		ArrayList<BoardDTO> allCount = dao.allCount(map);
		allCnt = allCount.size();
		logger.info("allCnt : " + allCnt);
		
		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if(allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			allCnt = 1;
		}
		
		
		int pages = allCnt%cnt != 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		
		logger.info("pages : " + pages);
		if (page > pages) {
			page = pages;
		}
		map.put("pages", pages); // 최대 페이지 수
		
		int offset = cnt * (page-1);
		
		map.put("offset", offset);
		map.put("currPage", page); // 현재 페이지
		
		logger.info("offset : "+offset);
		//검색 관련 설정하는 조건문
		if(word == null || word.equals("")) {
			ArrayList<BoardDTO> MealList = dao.MealList(cnt, offset);
			
			map.put("MealList", MealList);
		} else {
			
			  logger.info("검색어 (옵션) : " + word+ " (" + option + ")");
			  
			  // 검색 옵션에 따라 SQL 문이 달라지기 때문에 조건문으로 분리했음 
			  if(option.equals("아이디")) { 
				  searchList= dao.memberSearch(cnt,offset,word); 
				  logger.info("회원 옵션 설정"); 
			  }  else if(option.equals("제목")){ 
				  searchList = dao.subjectSearch(cnt,offset,word);
			  	  logger.info("제목 옵션 설정"); 
			  }else {
				  searchList = dao.placeSearch(cnt,offset,word);
			  	  logger.info("약속장소 옵션 설정"); 
			  }
			 
			
			logger.info("검색결과 건수 : " +searchList.size());
			map.put("penaltyList", searchList);
			
		}
		logger.info("서비스 체크포인트");
		return map;
			
}
*/
		HashMap<String, Object> map = new HashMap<String, Object>();
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		logger.info("보여줄 페이지 : " + page);
	
		
		int allCnt = dao.mealallCount();
		logger.info("allCnt:" + allCnt);
		
		int pages = allCnt%cnt > 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		logger.info("pages : " + pages);
		
		//currPage = pages
		//currPage가 pages보다 크면 currPage를 pages로 맞춰준다?
		if(page > pages) {
			page = pages;
		}
		map.put("pages", pages);		//만들 수 있는 최대 페이지 수
		map.put("currPage", page); //현재 페이지

		int offset = (page-1) * cnt;
		if(offset == -5) {
	         offset = 5;
	      }
		logger.info("offset : " + offset);
		ArrayList<BoardDTO> mealList = dao.mealList(cnt, offset);
		map.put("mealList", mealList);
		return map;
}
}
	
	

	
	

