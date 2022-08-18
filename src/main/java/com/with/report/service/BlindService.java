package com.with.report.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.with.board.dao.DeliveryDAO;
import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;
import com.with.member.dto.MemberDTO;
import com.with.report.dao.BlindDAO;
import com.with.report.dto.BlindDTO;

@Service
public class BlindService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BlindDAO dao;
	@Autowired DeliveryDAO deliDao;
	
	@Transactional
	public ModelAndView superBlind(String board_idx) {
		// 해당 기능은 조건없이 무조건 블라인드 처리해준다.
		ModelAndView mav = new ModelAndView();
		dao.superBlind(board_idx);
		
		// 글 블라인드 처리와 동시에 블라인드 게시판에 보낸다.
		// 어떤 게시글에서 삭제버튼을 눌렀는지 확인하기 위해 카테고리를 가져온다.
		String category = deliDao.getCategory(board_idx);
		// 블라인드하려는 게시판의 제목과 작성자를 가져온다.
		BoardDTO dto = deliDao.getSubAndWriter(board_idx);
		String member_id = dto.getMember_id();
		String subject = dto.getSubject();
		// 글 삭제와 동시에 블라인드 게시판에 보내야함
		deliDao.blindBoardWrite(category,board_idx,member_id,subject);
		// 글 삭제와 동시에 대기중인 신청내역은 모두 취소처리, 글 상태는 마감으로 변경해준다.
		dao.blindBoardUpdate(board_idx);
		
		return mav;
	}
	
	// 블라인드 게시판 목록 조회 서비스
		public ModelAndView blindList(HashMap<String, String> params) {
			logger.info("블라인드 목록 요청");
			ModelAndView mav = new ModelAndView("admin/blindList");
			
			// 페이징 처리
			HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
			int page = Integer.parseInt(params.get("page"));
			String option = params.get("option");
			String word = params.get("word");
			
			map.put("page", page); // page 입력
			// 검색어를 입력했을 때
			if(word != "" && word != " ") {
				map.put("word", word); // 검색어 입력
				map.put("option", option); // 검색 옵션 입력
			}
			
			ArrayList<BlindDTO> blindList = pagination(map);
			
			logger.info("게시글의 개수 : "+ blindList.size());
			mav.addObject("blindList",blindList);
			mav.addObject("map",map);
			
			return mav;
		}
		
		// 페이징 담당 메서드
		public ArrayList<BlindDTO> pagination(HashMap<String, Object> map) {
			int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
			int page = (int) map.get("page");
			String option = (String) map.get("option");
			String word = (String) map.get("word");
			
			logger.info("보여줄 페이지 : " + map.get("page"));
			logger.info("검색 옵션 / 검색어 : " + map.get("option") + " / " + map.get("word"));
			
			ArrayList<BlindDTO> blindList = new ArrayList<BlindDTO>();
			
			// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
			int allCnt = 0;
			
			// 한 페이지에 보여줄 게시글의 수 map 에 입력
			map.put("cnt", cnt);
			
			ArrayList<BlindDTO> allCount = dao.allCount(map);
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
			
			//리스트 가져오기
			blindList = dao.blindList(map);
			
			logger.info("페이징 체크포인트");
			return blindList;
		}
		
		// 상세보기 서비스
		@Transactional
		public ModelAndView blindDetail(String board_idx, HttpSession session) {
			logger.info("상세보기 서비스 요청");
			ModelAndView mav = new ModelAndView("admin/blindDetail");
			
			// 게시글 상세보기
			BlindDTO info = dao.blindDetail(board_idx);
			mav.addObject("info",info);
			
			return mav;
		}
		
		public void updateList(BlindDTO dto) {						 // 블라인드 : cancel=0,hide=1   <-> 블라인드해제: cancel=1, hide=0  
			logger.info("첫번째 cancel 값:" +dto.getCancel()); 		//블라인드글이면 cancel=0 임. 블라인드해제글이면 cancel=1임.
			
			if(!(dto.getCancel()==1)) {   	 								 //  cancel=1이 아니면
				dto.setCancel(0);												//	cancel=0 (혹시 모를 null 대비 0 직접 지정..)
			}	
				dao.updateBlind(dto);         				 				 
			
			logger.info("두번째 cancel 값:" +dto.getCancel());
			
			if(dto.getCancel()==1) {     										//cancel=1 이면, 
				dto.setCancel(0);													//cancel=0 해주기..  hide=0을 넣어야하기때문
				logger.info("세번째 cancel 값:" +dto.getCancel());
			}else {																	//아니면 (cancel=0 이면),
				dto.setCancel(1);          									   // cancel=1 
			}
			logger.info("네번째 cancel 값:" +dto.getCancel());  //블라인드해제>블라인드 : cancel 0>0>x>1 // 블라인드>블라인드해제 : cancel:1>1>0>0
			
			dao.updateComm(dto);
			
		}
		
}
