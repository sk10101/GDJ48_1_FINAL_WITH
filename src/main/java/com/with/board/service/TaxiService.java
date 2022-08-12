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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		
		String loginId = (String) session.getAttribute("loginId");
		
		// 나와 같은 대학교에 재학중인 유저의 게시글을 불러오는 코드
//		ArrayList<BoardDTO> list = dao.taxiList(loginId);
		
		// 시간 비교를 통해 마감여부를 update 해주는 코드
		dao.updateEnd();
//		int allcnt = dao.allCount(loginId);
		
		// 리스트로 왔을 때 chkHit 세션을 제거해주는 코드
		// 해당 코드가 있어야만 Detail 에 다시 접근했을 때 조회수 기능을 실행할 수 있다.
		// history.back() 을 사용한다면 아래 코드는 먹히지 않음
		session.removeAttribute("chkHit");
		
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

	@Transactional
	public ModelAndView taxiDetail(HttpSession session, String board_idx) {
		ModelAndView mav = new ModelAndView();
		String loginId = (String) session.getAttribute("loginId");
		
		// 세션을 확인하는 코드
		// history.back() 을 사용하기 때문에 아래 코드는 먹히지 않음
		String chk = (String) session.getAttribute("chkHit");
		
		// 세션에 값이 없으면 조회수 기능이 실행된다.
		if(chk == null) {
			dao.taxiUpHit(board_idx);
		}
		
		session.setAttribute("chkHit", "chkHit");
		
		// 시간 비교를 통해 마감여부를 update 해주는 코드
		dao.updateEnd();
		
		BoardDTO list = dao.taxiDetail(board_idx);
		
		// 로그인 회원의 연락처를 불러오는 코드
		String phone = dao.findPhone(loginId);
		
		// 사진을 불러오는 코드
		ArrayList<PhotoDTO> photo = dao.taxiPhotoList(board_idx, "택시게시판");
		
		// 참여한 인원 수를 불러오는 코드 (본인은 포함해야 하기 때문에 +1)
		int count = dao.taxiCount(board_idx);
		
		// 참여해있는 인원의 이름, 성별, 연락처를 불러오는 코드
		ArrayList<MemberDTO> pt = dao.taxiParticipant(board_idx);
		
//		int recruitEnd = dao.recruitEnd(board_idx);
		
		mav.addObject("list", list);
		mav.addObject("photo", photo);
		mav.addObject("count", count);
		mav.addObject("pt", pt);
		mav.addObject("phone", phone);
		mav.setViewName("taxiBoard/TaxiDetail");
		
		return mav;
	}

	@Transactional
	public ModelAndView taxiWrite(MultipartFile[] photos, BoardDTO dto, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String loginId = (String) session.getAttribute("loginId");
		
		dto.setMember_id(loginId);
		
		// session 에 저장한 좌표를 dto 에 담아준다.
		dto.setAppoint_coords_lat((String) session.getAttribute("lat"));
		dto.setAppoint_coords_lng((String) session.getAttribute("lng"));
		
		// 공통 컬럼 테이블에 작성할 내용
		int row = dao.writeBcc(dto);
		// 택시 전용 컬럼 테이블에 작성하기 위해 위에서 작성했던 글의 번호를 가져와야함
		int board_idx = dao.getBoardIdx(dto);
		dto.setBoard_idx(board_idx);
		// 택시 전용 컬럼 테이블에 작성할 내용
		int row2 = dao.writeTaxi(dto);
		// 방장도 참가자 테이블 들어가야함
		int row3 = dao.ptTaxi(dto);
		
		// 파일을 올리지 않아도 fileSave 가 진행되는 것을 방지하는 조건문
		if(row > 0 & row2 > 0 & row3 > 0) {
			taxiFileSave(photos, board_idx, "택시게시판");
		}
		
		logger.info("성공 여부 : " + row + " / " + row2 + " / " + row3);
		
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

		public ModelAndView taxiKakao(HttpSession session) {
			ModelAndView mav = new ModelAndView();
			
			String loginId = (String) session.getAttribute("loginId");
			
			String univ = dao.univFind(loginId);
			logger.info("대학교 주소: " + univ);
			
			mav.addObject("univ", univ);
			mav.setViewName("taxiBoard/kakao");
			return mav;
		}

		public ModelAndView taxiApply(HttpSession session, HashMap<String, Object> params, RedirectAttributes rAttr) {
			ModelAndView mav = new ModelAndView();
			
			String loginId = (String) session.getAttribute("loginId");
			
			String board_idx = (String) params.get("board_idx");
			String gender = (String) params.get("gender");
//			String member_id = params.get("member_id");
//			String phone = params.get("phone");
			
			params.put("loginId", loginId);
			params.put("gender", gender);
			
			
			// 신청하기 전 마감여부를 마지막으로 업데이트하는 코드
			dao.updateEnd();
			
			// 마감여부를 불러오는 코드
			int recruitEnd = dao.recruitEnd(board_idx);
			logger.info("마감여부 : " + recruitEnd);
			
			// 대기중 또는 수락 상태의 신청 데이터가 있는지 확인해주는 코드
			int chkStatus = dao.chkStatus(params);
			logger.info("대기중 또는 수락 상태의 데이터 수 : " + chkStatus);
			
			// 해당 글에 신청했다가 거절당한 이력이 있을 때
			int chkReject = dao.chkReject(params);
			
			// 해당 글에서 강퇴당하거나 스스로 나간 이력이 있을 때
			int chkElim = dao.chkElim(params);
			
			
			// 로그인 회원의 성별을 확인해주는 코드
			// chkGender 의 값은 '남자' 또는 '여자'
			// gender 의 값은 '남자만' 또는 '여자만' 또는 '상관없음'

			// 만약 chkGender 의 값이 '남자' 라면 '남자만' 으로 바꿔준다. 
			// 아니면 '여자만' 으로 바꿔준다.
			
			// 이후 gender(ex '남자만') 와 chkGender(ex '남자') 가 일치하거나 or gender 가 '상관없음' 이라면 신청을 허가한다.
			String chkGender = dao.chkGender(params);
			
			// 성별 비교를 위해 텍스트를 변환해주는 코드
			if (chkGender.equals("남자")) {
				chkGender = "남자만";
			} else {
				chkGender = "여자만";
			}
			
			
			if (recruitEnd == 1) {
				rAttr.addFlashAttribute("msg", "이미 마감된 모임입니다.");
			} else if (chkStatus > 0) {
				rAttr.addFlashAttribute("msg", "이미 수락 대기중이거나 수락된 신청입니다.");
			} else if (chkReject > 0) {
				rAttr.addFlashAttribute("msg", "이미 거절된 신청입니다.");
			} else if (chkElim > 0) {
				rAttr.addFlashAttribute("msg", "이미 모임에서 나간 이력이 있습니다.");
			} else if (!chkGender.equals(gender) && !gender.equals("상관없음")) {
				rAttr.addFlashAttribute("msg", gender + " 가능한 신청입니다.");
			}
			else {
				int row = dao.taxiApply(params);
				rAttr.addFlashAttribute("msg", "신청을 완료했습니다.");
			}
			
			mav.setViewName("redirect:/taxiDetail?board_idx=" + board_idx);
			
			// 참여자 0, 신청자 0, 마감여부 0 일 경우에만 삭제 가능
			return mav;
		}

}
