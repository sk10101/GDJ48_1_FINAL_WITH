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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.dao.MealDAO;
import com.with.board.dto.BoardDTO;


@Service
public class MealService {
	@Autowired MealDAO dao;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	
	 
	
	
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

	/*
	public HashMap<String, Object> MealList(HashMap<String, String> params, HttpSession session) {
String loginId = (String) session.getAttribute("loginId");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page= Integer.parseInt(params.get("page"));
		logger.info("보여줄 페이지 : "+ page);
		
		//총갯수(allCnt) / 페이지당 보여줄 갯수(cnt) = 생성 가능한 페이지(pages)
		int allCnt = dao.allCount(loginId);
		logger.info("allCnt:"+allCnt);
		int pages = allCnt%cnt > 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		
		if (page > pages) {
			page = pages;
		}
		
		map.put("pages", pages); //만들 수 있는 최대 페이지 수
		map.put("currPage", page); //현재 페이지
		
	
		int offset = (page-1)*cnt;
		logger.info("offset : " + offset);
		
		
		
		ArrayList<BoardDTO> list = dao.mealList(cnt,offset,loginId);
		map.put("mealList", list);
		
		return map;
	}
*/

	public ModelAndView searchList(String option, String word) {
		logger.info("옵션 / 검색어 : " + option + " / " + word);
		ModelAndView mav = new ModelAndView("mealBoard/MealList");
		
		ArrayList<BoardDTO> searchList = dao.searchList(option,word);
		logger.info("검색 건수 : "+ searchList.size());
		mav.addObject("mealList",searchList);
		
		return mav;
	}


	public ArrayList<BoardDTO> list() {
		 logger.info("리스트 요청 서비스"); 
		 return dao.list();
	}
}
	
	

	
	

