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

import com.with.board.dao.MealDAO;
import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;
import com.with.member.dto.MemberDTO;


@Service
public class MealService {
	@Autowired MealDAO dao;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public ModelAndView mealList(HashMap<String, String> params) {
		logger.info("게시글 목록 요청");
		ModelAndView mav = new ModelAndView("mealBoard/MealList");
		
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
		
		ArrayList<BoardDTO> mealList = pagination(map);
		logger.info("게시글의 개수 : "+ mealList.size());
		mav.addObject("mealList",mealList);
		mav.addObject("map",map);
		
		return mav;
	}
	
	

	@Transactional
	public void write(MultipartFile[] photos, BoardDTO dto,HttpSession session) {
		logger.info("글쓰기 서비스 요청");
		// 이후에 로그인한 아이디를 담아주는 것으로 변경해야함
		//String loginId = (String) session.getAttribute("loginId");
		dto.setMember_id((String) session.getAttribute("loginId"));
		
		// session 에 저장한 좌표를 dto 에 담아준다.
		dto.setAppoint_coords_lat((String) session.getAttribute("lat"));
		dto.setAppoint_coords_lng((String) session.getAttribute("lng"));
		
		// 공통 컬럼 테이블에 작성할 내용
		int row = dao.writeBcc(dto);
		
		// 밥 전용 컬럼 테이블에 작성하기 위해 위에서 작성했던 글의 번호를 가져와야함
		int board_idx = dao.getBoardIdx(dto);
		dto.setBoard_idx(board_idx);
		
		// 밥 전용 컬럼 테이블에 작성할 내용
		int row2 = dao.writeMeal(dto);
		
		// 방장이 글 쓰면 참가자로 자동 참여
		int row3 = dao.partMeal(dto.getMember_id(),board_idx);
		
		// 파일을 올리지 않아도 fileSave 가 진행되는 것을 방지하는 조건문
		if(row > 0 & row2 > 0) {
			mealFileSave(photos, board_idx, "밥게시판");
		}
		
		logger.info("성공 여부 : " + row + " / " + row2);
		
	}


	
	
	
	// 파일 업로드 서비스
		@Transactional
		public void mealFileSave(MultipartFile[] photos, int board_idx, String category_id) {
			
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
						Path path = Paths.get("/Users/hyunsoungkim/GDJ48_FINAL_WITH/src/main/webapp/resources/photo/" + newFileName);
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
		
	public ModelAndView mealDetail(HttpSession session,String board_idx) {
		logger.info("상세보기 서비스 요청");
		ModelAndView mav = new ModelAndView("mealBoard/MealDetail");
		
		String loginId = (String) session.getAttribute("loginId");
		
		// 조회수 올리기
		dao.hit(board_idx);
		// 게시글 상세보기
		BoardDTO info = dao.mealDetail(board_idx);
		ArrayList<PhotoDTO> mealPhotoList = dao.mealPhotoList(board_idx,"밥게시판");
		mav.addObject("info",info);
		mav.addObject("mealPhotoList",mealPhotoList);
		// 참여자 목록 조회하기
		ArrayList<BoardDTO> partList = partList(board_idx);
		mav.addObject("partList",partList);
		
		ArrayList<MemberDTO> partMaster = dao.partMaster(info.getMember_id());

		
		// 참여한 인원 수 확인하기
		int count = dao.mealCount(board_idx);
		mav.addObject("count", count);
		// login person 연락처 가져오기
		String phone = dao.mealPhone(loginId);
		mav.addObject("phone", phone);
		// 시간 비교를 통해 마감여부를 update 해주는 코드
		dao.updateEnd();
		
		// 로그인한 참가자가 명단에 있는지 
		int partMemberChk = dao.partMemberChk((String) session.getAttribute("loginId"),board_idx);
		logger.info("0 이면 참여자 아님 : " + partMemberChk);
		mav.addObject("partMemberChk",partMemberChk);
		mav.addObject("partMaster",partMaster);
		return mav;
	}
	

	private ArrayList<BoardDTO> partList(String board_idx) {
		logger.info("참여 회원 목록 서비스");
		return dao.partList(board_idx);
	}


	private ArrayList<BoardDTO> pagination(HashMap<String, Object> map) {
		int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
		int page = (int) map.get("page");
		String option = (String) map.get("option");
		String word = (String) map.get("word");
		
		logger.info("보여줄 페이지 : " + map.get("page"));
		logger.info("검색 옵션 / 검색어 : " + map.get("option") + " / " + map.get("word"));
		
		ArrayList<BoardDTO> mealList = new ArrayList<BoardDTO>();
		
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
		
		mealList = dao.mealList(map);
		
		logger.info("페이징 체크포인트");
		return mealList;
	}




	public HashMap<String, Object> detailMarker(HashMap<String, String> params) {
		// loginId의 대학교 좌표를 구하기 위해 회원이 등록한 대학교의 주소를 가져온다.
		String loginid = params.get("loginId");
		
		HashMap<String, Object> mealMap = new HashMap<String, Object>(); 
		MemberDTO dto = dao.getUniversityAddr(loginid);
		String university_addr = dto.getUniversity_addr();
		mealMap.put("university_addr", university_addr);
		
		logger.info("가져온 대학교 주소 : " + university_addr);
		
		return mealMap;
	}


	
	 // 밥 게시글 참여 신청
	public void mealApply(RedirectAttributes rAttr, String member_id, String board_idx) {
		logger.info("밥 서비스 참가신청 서비스 도착");
		dao.mealApply(member_id,board_idx);
		rAttr.addFlashAttribute("msg", "모임 참여 신청 성공");
	}
	


	 // 밥 게시글 참여 신청
	public ModelAndView mealApply(RedirectAttributes rAttr, HashMap<String, String> params) {
		logger.info( "게시글 참여 신청 서비스");
		ModelAndView mav = new ModelAndView();
		String member_id = params.get("member_id");
		String board_idx = params.get("board_idx");
	
		logger.info("모임 참여 신청 성공");
		dao.mealApply(member_id,board_idx);
		rAttr.addFlashAttribute("msg", "모임 참여 신청 성공");
		
		return mav;
	}


	//ghldnjs rkdxhl
	public ModelAndView mealBan(String member_id, String board_idx) {
		logger.info("참여 회원 강퇴 서비스");
		ModelAndView mav = new ModelAndView();
		dao.mealBan(member_id,board_idx);
		
		return mav;
	}



	public ModelAndView mannerGo(String board_idx, String member_id) {
		ModelAndView mav = new ModelAndView("taxiBoard/manner");
		
		String chkCate = dao.chkCate(board_idx);
		
		mav.addObject("chkCate", chkCate);
		mav.addObject("board_idx", board_idx);
		mav.addObject("member_id", member_id);
		
		return mav;
	}



	public ModelAndView mannerDo(HttpSession session, HashMap<String, String> params, RedirectAttributes rAttr) {
		ModelAndView mav = new ModelAndView();
		
		String board_idx = params.get("board_idx");
		params.put("loginId", (String) session.getAttribute("loginId"));
		
		String chkCate = dao.chkCate(board_idx);
		
		int row1 = dao.putKind(params);
		int row2 = dao.putResponse(params);
		int row3 = dao.putTime(params);
		
		if(row1 > 0 && row2 > 0 && row3 > 0) {
			rAttr.addFlashAttribute("msg", "평가를 완료했습니다.");
		} else {
			rAttr.addFlashAttribute("msg", "평가에 실패했습니다.");
		}
		
		if(chkCate.equals("배달게시판")) {
			mav.setViewName("redirect:/deliDetail?board_idx=" + board_idx);
		} else if (chkCate.equals("택시게시판")) {
			mav.setViewName("redirect:/taxiDetail?board_idx=" + board_idx);
		} else {
			mav.setViewName("redirect:/mealDetail?board_idx=" + board_idx);
		}
		
		return mav;
	}


/*
	public ModelAndView mealApplys(HttpSession session, HashMap<String, Object> params, RedirectAttributes rAttr) {
		ModelAndView mav = new ModelAndView();
		
		String loginId = (String) session.getAttribute("loginId");
		
		String board_idx = (String) params.get("board_idx");
		String gender = (String) params.get("gender");
//		String member_id = params.get("member_id");
//		String phone = params.get("phone");
		
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
		String chkGender = dao.chkGender(params) + "만";
		
		// 성별 비교를 위해 텍스트를 변환해주는 코드
//		if (chkGender.equals("남자")) {
//			chkGender = "남자만";
//		} else {
//			chkGender = "여자만";
//		}
		
		
		if (recruitEnd == 1) {
			rAttr.addFlashAttribute("msg", "이미 마감된 모임입니다.");
		} else if (chkStatus > 0) {
			rAttr.addFlashAttribute("msg", "이미 수락 대기중이거나 수락된 신청입니다.");
		} else if (chkReject > 0) {
			rAttr.addFlashAttribute("msg", "이미 거절된 신청입니다.");
		} else if (chkElim > 0) {
			rAttr.addFlashAttribute("msg", "이미 모임에서 나간 이력이 있습니다.");
		} else if (!chkGender.equals(gender) && !gender.equals("상관없음")) {
			rAttr.addFlashAttribute("msg", gender + " 신청 가능합니다.");
		}
		else {
			int row = dao.mealApplys(params);
			rAttr.addFlashAttribute("msg", "신청을 완료했습니다.");
		}
		
		mav.setViewName("redirect:/mealDetail?board_idx=" + board_idx);
		
		// 참여자 0, 신청자 0, 마감여부 0 일 경우에만 삭제 가능
		return mav;
	}
*/
	




	






	




	




	
}






	

	
	

	
	

