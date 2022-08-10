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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.dao.DeliveryDAO;
import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;
import com.with.member.dto.MemberDTO;


@Service
public class DeliveryService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired DeliveryDAO dao;
	
	// 배달 게시판 목록 조회 서비스
	public ModelAndView deliList(HashMap<String, String> params) {
		logger.info("게시글 목록 요청");
		ModelAndView mav = new ModelAndView("deliveryBoard/DeliList");
		
		// 마감 여부 확인 후 업데이트 (스케쥴러 대체)
		dao.endUpdate();
		
		// 페이징 처리
		HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		
		map.put("page", page); // page 입력
		// 검색어를 입력했을 때
		if(word != "") {
			map.put("word", word); // 검색어 입력
			map.put("option", option); // 검색 옵션 입력
		}
		
		ArrayList<BoardDTO> deliList = pagination(map);
		logger.info("게시글의 개수 : "+ deliList.size());
		mav.addObject("deliList",deliList);
		mav.addObject("map",map);
		
		return mav;
	}
	
	/* 검색기능 개선으로 인해 주석처리함
	// 검색목록 조회 서비스
	public ModelAndView searchList(String option, String word, int page) {
		logger.info("옵션 / 검색어 : " + option + " / " + word);
		ModelAndView mav = new ModelAndView("deliveryBoard/DeliList");
		
		// 마감 여부 확인 후 업데이트 (스케쥴러 대체)
		dao.endUpdate();
		
		// 페이징 처리
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("page", page); // page 입력
		map.put("word", word); // 검색어 입력
		map.put("option", option); // 검색 옵션 입력
		ArrayList<BoardDTO> deliList = pagination(map);
		logger.info("게시글의 개수 : "+ deliList.size());
		mav.addObject("deliList",deliList);
		mav.addObject("map",map);
		
		return mav;
	}
	*/
	
	// 상세보기 서비스
	@Transactional
	public ModelAndView deliDetail(String board_idx) {
		logger.info("상세보기 서비스 요청");
		ModelAndView mav = new ModelAndView("deliveryBoard/DeliDetail");
		
		// 조회수 올리기
		dao.upHit(board_idx);
		// 게시글 상세보기
		BoardDTO info = dao.deliDetail(board_idx);
		ArrayList<PhotoDTO> deliPhotoList = dao.deliPhotoList(board_idx,"배달게시판");
		mav.addObject("info",info);
		mav.addObject("deliPhotoList",deliPhotoList);
		
		return mav;
	}

	
	// 글쓰기 서비스
	@Transactional
	public void write(MultipartFile[] photos, BoardDTO dto) {
		logger.info("글쓰기 서비스 요청");
		// 이후에 로그인한 아이디를 담아주는 것으로 변경해야함
		dto.setMember_id("tester");
		// 공통 컬럼 테이블에 작성할 내용
		int row = dao.writeBcc(dto);
		// 배달 전용 컬럼 테이블에 작성하기 위해 위에서 작성했던 글의 번호를 가져와야함
		int board_idx = dao.getBoardIdx(dto);
		dto.setBoard_idx(board_idx);
		// 배달 전용 컬럼 테이블에 작성할 내용
		int row2 = dao.writeDeli(dto);
		
		// 파일을 올리지 않아도 fileSave 가 진행되는 것을 방지하는 조건문
		if(row > 0 & row2 > 0) {
			deliFileSave(photos, board_idx, "배달게시판");
		}
		
		logger.info("성공 여부 : " + row + " / " + row2);
	}

	
	// 파일 업로드 서비스
	@Transactional
	public void deliFileSave(MultipartFile[] photos, int board_idx, String category_id) {
		
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
					Path path = Paths.get("C:\\STUDY\\SPRING_ADVANCE\\GDJ48_1_FINAL_WITH\\src\\main\\webapp\\resources\\photo\\" + newFileName);
					// 같은이름의 파일이 나올 수 없기 떄문에 옵션 설정 안해도된다.
					Files.write(path, arr);
					logger.info(newFileName + " SAVE OK");
					// 4. 업로드 후 photo 테이블에 데이터 입력
					dao.deliFileWrite(oriFileName,newFileName,board_idx,category);
					
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
	// 페이징 담당 메서드
	public ArrayList<BoardDTO> pagination(HashMap<String, Object> map) {
		int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
		int page = (int) map.get("page");
		String option = (String) map.get("option");
		String word = (String) map.get("word");
		
		logger.info("보여줄 페이지 : " + map.get("page"));
		logger.info("검색 옵션 / 검색어 : " + map.get("option") + " / " + map.get("word"));
		
		ArrayList<BoardDTO> deliList = new ArrayList<BoardDTO>();
		
		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = 0;
		
		// 한 페이지에 보여줄 게시글의 수 map 에 입력
		map.put("cnt", cnt);
		
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
		logger.info("offset : "+offset);
		
		map.put("offset", offset);
		map.put("currPage", page); // 현재 페이지
		
		deliList = dao.deliList(map);
		
		logger.info("페이징 체크포인트");
		return deliList;
	}

	public HashMap<String, Object> detailMarker(HashMap<String, String> params) {
		// 작성자의 대학교 좌표를 구하기 위해 회원이 등록한 대학교의 주소를 가져온다.
		String loginid = params.get("loginId");
		
		HashMap<String, Object> deliMap = new HashMap<String, Object>(); 
		MemberDTO dto = dao.getUniversityAddr(loginid);
		String university_addr = dto.getUniversity_addr();
		deliMap.put("university_addr", university_addr);
		
		logger.info("가져온 대학교 주소 : " + university_addr);
		
		return deliMap;
	}
}
