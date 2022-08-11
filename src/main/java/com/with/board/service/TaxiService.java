package com.with.board.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.dao.TaxiDAO;
import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;
import com.with.member.dto.MemberDTO;

@Service
public class TaxiService {
	
	@Autowired TaxiDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public ModelAndView taxiList(HttpSession session, HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView();
		
		session.setAttribute("loginId", "일반회원");
		// 임시부여한 session 으로 테스트중
		String loginId = (String) session.getAttribute("loginId");
		
		// 나와 같은 대학교에 재학중인 유저의 게시글을 불러오는 코드
//		ArrayList<BoardDTO> list = dao.taxiList(loginId);
		
		// 시간 비교를 통해 마감여부를 update 해주는 코드
		dao.updateEnd();
//		int allcnt = dao.allCount(loginId);
		
		// 리스트로 왔을 때 chkHit 세션을 제거해주는 코드
		// 해당 코드가 있어야만 Detail 에 다시 접근했을 때 조회수 기능을 실행할 수 있다.
		// history.back() 을 사용하기 때문에 아래 코드는 먹히지 않음
//		session.removeAttribute("chkHit");
		
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
		
		ArrayList<BoardDTO> taxiList = pagination(map, session);
		mav.addObject("taxiList", taxiList);
		mav.addObject("map",map);
		mav.setViewName("taxiBoard/TaxiList");
		
		return mav;
	}

//	public ModelAndView taxiSearchList(HttpSession session, String option, String word) {
//		ModelAndView mav = new ModelAndView();
//		
//		session.setAttribute("loginId", "일반회원");
//		// 임시부여한 session 으로 테스트중
//		String loginId = (String) session.getAttribute("loginId");
//		
//		// 나와 같은 대학교에 재학중인 유저의 게시글을 불러오는 코드 
//		ArrayList<BoardDTO> list = dao.taxiSearchList(loginId, option, word);
//		
//		// 시간 비교를 통해 마감여부를 update 해주는 코드
//		dao.updateEnd();
//		
//		
//		int allcnt = dao.allCount(loginId);
//		
//		// 리스트로 왔을 때 chkHit 세션을 제거해주는 코드
//		// 해당 코드가 있어야만 Detail 에 다시 접근했을 때 조회수 기능을 실행할 수 있다.
//		session.removeAttribute("chkHit");
//		
//		mav.addObject("taxiList", list);
//		mav.setViewName("taxiBoard/TaxiList");
//		
//		return mav;
//	}

	@Transactional
	public ModelAndView taxiDetail(HttpSession session, String board_idx) {
		ModelAndView mav = new ModelAndView();
		session.setAttribute("loginId", "일반회원");
		String loginId = (String) session.getAttribute("loginId");
		
		// 세션을 확인하는 코드
		// history.back() 을 사용하기 때문에 아래 코드는 먹히지 않음
//		String chk = (String) session.getAttribute("chkHit");
		
		// 세션에 값이 없으면 조회수 기능이 실행된다.
//		if(chk == null) {
//			dao.taxiUpHit(board_idx);
//		}
		
		dao.taxiUpHit(board_idx);
		
		// 세션에 "chkHit" name 값과 value 값을 부여한다.
//		session.setAttribute("chkHit", "chkHit");
		
		BoardDTO list = dao.taxiDetail(board_idx);
		
		// 사진을 불러오는 코드
		ArrayList<PhotoDTO> photo = dao.taxiPhotoList(board_idx, "택시게시판");
		
		// 참여한 인원 수를 불러오는 코드 (본인은 포함해야 하기 때문에 +1)
		int count = dao.taxiCount(board_idx) + 1;
		
		// 참여해있는 인원의 이름, 성별, 연락처를 불러오는 코드
		ArrayList<MemberDTO> pt = dao.taxiParticipant(board_idx);
		
		// 시간 비교를 통해 마감여부를 update 해주는 코드
		dao.updateEnd();
		
		mav.addObject("list", list);
		mav.addObject("photo", photo);
		mav.addObject("count", count);
		mav.addObject("pt", pt);
		mav.setViewName("taxiBoard/TaxiDetail");
		
		return mav;
	}

	@Transactional
	public ModelAndView taxiWrite(MultipartFile[] photos, BoardDTO dto) {
		ModelAndView mav = new ModelAndView();
		
		// 이후에 로그인한 아이디를 담아주는 것으로 변경해야함
		dto.setMember_id("일반회원");
		// 공통 컬럼 테이블에 작성할 내용
		int row = dao.writeBcc(dto);
		// 택시 전용 컬럼 테이블에 작성하기 위해 위에서 작성했던 글의 번호를 가져와야함
		int board_idx = dao.getBoardIdx(dto);
		dto.setBoard_idx(board_idx);
		// 택시 전용 컬럼 테이블에 작성할 내용
		int row2 = dao.writeTaxi(dto);
		
		// 파일을 올리지 않아도 fileSave 가 진행되는 것을 방지하는 조건문
		if(row > 0 & row2 > 0) {
			taxiFileSave(photos, board_idx, "택시게시판");
		}
		
		logger.info("성공 여부 : " + row + " / " + row2);
		
		mav.setViewName("redirect:/taxiListGo");
		
		return mav;
	}

	@Transactional
	private void taxiFileSave(MultipartFile[] photos, int board_idx, String category_id) {
		// 카테고리 번호 전달(1. 공지사항, 2. 건의사항, 3. 답변)
		String category = category_id;
		logger.info(category);
		
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
					Path path = Paths.get("/Users/hyunmin/GDJ48_1_FINAL_WITH/src/main/webapp/resources/photo/" + newFileName);
					// 같은이름의 파일이 나올 수 없기 떄문에 옵션 설정 안해도된다.
					Files.write(path, arr);
					logger.info(newFileName + " SAVE OK");
					// 4. 업로드 후 photo 테이블에 데이터 입력
					dao.taxiFileWrite(oriFileName,newFileName,board_idx,category);
					
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
		// 페이징 담당 메서드
		public ArrayList<BoardDTO> pagination(HashMap<String, Object> map, HttpSession session) {
			
			session.setAttribute("loginId", "일반회원");
			String loginId = (String) session.getAttribute("loginId");
			
			int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
			int page = (int) map.get("page");
			String option = (String) map.get("option");
			String word = (String) map.get("word");
			
			logger.info("보여줄 페이지 : " + page);
			logger.info("검색 옵션 / 검색어 : " + option + " / " + word);
			
			ArrayList<BoardDTO> taxiList = new ArrayList<BoardDTO>();
			
			// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
			int allCnt = 0;
			
			// 한 페이지에 보여줄 게시글의 수 map 에 입력
			map.put("cnt", cnt);
			map.put("loginId", loginId);
					
			allCnt = dao.allCount(map);
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
			
			taxiList = dao.taxiList(map);
			
			logger.info("페이징 체크포인트");
			return taxiList;
		}

}
