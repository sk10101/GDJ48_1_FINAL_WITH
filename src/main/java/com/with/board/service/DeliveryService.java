package com.with.board.service;

import java.io.File;
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

import com.with.board.dao.DeliveryDAO;
import com.with.board.dto.BoardDTO;
import com.with.board.dto.PhotoDTO;
import com.with.member.dto.MemberDTO;


@Service
public class DeliveryService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired DeliveryDAO dao;
	
	// 배달 게시판 목록 조회 서비스
	public ModelAndView deliList(HashMap<String, String> params, HttpSession session) {
		logger.info("게시글 목록 요청");
		ModelAndView mav = new ModelAndView("deliveryBoard/DeliList");
		
		// 마감 여부 확인 후 업데이트 (스케쥴러 대체)
		dao.endUpdate();
		
		// 페이징 처리
		HashMap<String, Object> map = new HashMap<String, Object>(); // map 객체화
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		// 로그인한 사람이 차단한 회원이 작성한 게시글은 보여주지 않기 위해 가져온다.
		String loginId = (String) session.getAttribute("loginId");
		String member_class = (String) session.getAttribute("member_class");
		
		map.put("page", page); // page 입력
		map.put("loginId", loginId);
		map.put("member_class",member_class);
		// 검색어를 입력했을 때
		if(word != "" && word != " ") {
			map.put("word", word); // 검색어 입력
			map.put("option", option); // 검색 옵션 입력
		}
		
		ArrayList<BoardDTO> deliList = pagination(map);
		
		logger.info("게시글의 개수 : "+ deliList.size());
		mav.addObject("deliList",deliList);
		mav.addObject("map",map);
		
		return mav;
	}
	
	
	// 상세보기 서비스
	@Transactional
	public ModelAndView deliDetail(String board_idx, HttpSession session) {
		logger.info("상세보기 서비스 요청");
		ModelAndView mav = new ModelAndView("deliveryBoard/DeliDetail");
		
		// 조회수 올리기
		dao.upHit(board_idx);
		// 게시글 상세보기
		BoardDTO info = dao.deliDetail(board_idx);
		ArrayList<PhotoDTO> deliPhotoList = dao.deliPhotoList(board_idx,"배달게시판");
		mav.addObject("info",info);
		mav.addObject("deliPhotoList",deliPhotoList);
		// 참여자 목록 조회
		// 한 번 평가한 회원은 다시 평가할 수 없도록 평가하기 버튼을 가린다.
		String loginId = (String) session.getAttribute("loginId");
		ArrayList<BoardDTO> partList = partList(board_idx, loginId);
		
		
		mav.addObject("partList",partList);
		// 참여자 명단에 방장을 맨위에 따로 그려준다 (방장은 investment 변수에 입력한 값이 없어 부득이하게 따로 입력)
		ArrayList<MemberDTO> partMaster = dao.partMaster(info.getMember_id());
		// 참여자 명단에 로그인한 아이디가 있는지 확인한다.
		int partMemberChk = dao.partMemberChk((String) session.getAttribute("loginId"),board_idx);
		logger.info("0 이면 참여자 아님 : " + partMemberChk);
		mav.addObject("partMemberChk",partMemberChk);
		mav.addObject("partMaster",partMaster);
		
		
		return mav;
	}


	// 글쓰기 서비스
	@Transactional
	public void write(MultipartFile[] photos, BoardDTO dto, HttpSession session) {
		logger.info("글쓰기 서비스 요청");
		// 이후에 로그인한 아이디를 담아주는 것으로 변경해야함
		dto.setMember_id((String) session.getAttribute("loginId"));
		// session 에 저장한 좌표를 dto 에 담아준다.
		dto.setAppoint_coords_lat((String) session.getAttribute("lat"));
		dto.setAppoint_coords_lng((String) session.getAttribute("lng"));
		
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
			// 글을 작성함과 동시에 참여자 목록에 작성자 본인을 추가해준다.
			dao.applyMaster(dto.getMember_id(),board_idx);
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

	public HashMap<String, Object> getUnivAddr(HashMap<String, String> params) {
		// 작성자의 대학교 좌표를 구하기 위해 회원이 등록한 대학교의 주소를 가져온다.
		String loginid = params.get("loginId");
		
		HashMap<String, Object> deliMap = new HashMap<String, Object>(); 
		MemberDTO dto = dao.getUnivAddr(loginid);
		String university_addr = dto.getUniversity_addr();
		deliMap.put("university_addr", university_addr);
		
		logger.info("가져온 대학교 주소 : " + university_addr);
		
		return deliMap;
	}

	
	private ArrayList<BoardDTO> partList(String board_idx, String loginId) {
		logger.info("참여 회원 목록 서비스");
		
		return dao.partList(board_idx, loginId);
	}


	public ModelAndView applyDeli(RedirectAttributes rAttr, HashMap<String, String> params) {
		logger.info("배달 게시글 참여 신청 서비스");
		ModelAndView mav = new ModelAndView();
		String member_id = params.get("member_id");
		String board_idx = params.get("board_idx");
		String investment = params.get("investment");
		String gd_restriction = params.get("gd_restriction");
		
		// 성별 제한에 걸렸을 때
		if(!(dao.getGender(member_id)+'만').equals(gd_restriction) && !gd_restriction.equals("상관없음")) {
			rAttr.addFlashAttribute("msg",gd_restriction + " 가능한 신청입니다.");
		}
		// 이미 신청했을 때, 방장이 수락했을 때
		else if (dao.isApplied(member_id,board_idx) > 0) {
			rAttr.addFlashAttribute("msg","이미 수락 대기중이거나 수락된 신청입니다.");
		}
		// 해당 글에 신청했다가 거절당한 이력이 있을 때
		else if(dao.isRejected(member_id,board_idx) > 0) {
			rAttr.addFlashAttribute("msg","이미 거절된 신청입니다.");
		}
		// 해당 글에서 강퇴당하거나 스스로 나간 이력이 있을 때
		else if(dao.isBanned(member_id,board_idx) > 0) {
			rAttr.addFlashAttribute("msg","이미 모임에서 나간 이력이 있습니다.");
		} else {
			// 위 세 경우에 모두 해당되지 않아야 신청이 가능하도록 조건 설정함
			logger.info("모임 참여 신청 성공");
			rAttr.addFlashAttribute("msg","정상적으로 신청되었습니다.");
			dao.applyDeli(member_id,board_idx,investment);
		}
		
		return mav;
	}


	public ModelAndView deliBan(String member_id, String board_idx) {
		logger.info("참여 회원 강퇴 서비스");
		ModelAndView mav = new ModelAndView();
		dao.deliBan(member_id,board_idx);
		
		return mav;
	}

	@Transactional
	public ModelAndView deliDelete(RedirectAttributes rAttr, String board_idx) {
		logger.info("배달 게시글 삭제 서비스");
		ModelAndView mav = new ModelAndView();
		// 어떤 게시글에서 삭제버튼을 눌렀는지 확인하기 위해 카테고리를 가져온다.
		String category = dao.getCategory(board_idx);
		// 카테고리 별로 요청명을 달리하여 보내진다.
		if(category.equals("배달게시판")) {
			mav.setViewName("redirect:/deliListGo");
		} else if (category.equals("밥게시판")) {
			mav.setViewName("redirect:/mealList.go");
		} else if (category.equals("택시게시판")) {
			mav.setViewName("redirect:/taxiListGo");
		}
		
		// 신청자 > 0 인 경우
		if(dao.applyCnt(board_idx) > 0) {
			if(category.equals("배달게시판")) {
				mav.setViewName("redirect:/deliDetail?board_idx="+board_idx);;
			}
			rAttr.addFlashAttribute("msg","이미 모임에 참여신청한 회원이 있습니다.");
		}
		// 참여자 > 1 인 경우
		else if(dao.partCnt(board_idx) > 1) {
			if(category.equals("배달게시판")) {
				mav.setViewName("redirect:/deliDetail?board_idx="+board_idx);;
			}
			rAttr.addFlashAttribute("msg","이미 모임에 참여한 회원이 있습니다.");
		}
		// 글상태 = '마감' 인 경우
		else if(dao.isEnd(board_idx) > 0) {
			if(category.equals("배달게시판")) {
				mav.setViewName("redirect:/deliDetail?board_idx="+board_idx);;
			}
			rAttr.addFlashAttribute("msg","이미 마감된 게시글입니다.");
		} else {
			// 위 세 경우에 모두 해당되지 않아야 글 삭제가 가능하도록 조건 설정함 
			// 해당 board_idx 에 사진이 있는지 확인 (동시에 이름확보)
			int delCount = dao.deliDelete(board_idx);
			
			// 블라인드하려는 게시판의 제목과 작성자를 가져온다.
			BoardDTO dto = dao.getSubAndWriter(board_idx);
			String member_id = dto.getMember_id();
			String subject = dto.getSubject();
			// 글 삭제와 동시에 블라인드 게시판에 보내야함
			dao.blindBoardWrite(category,board_idx,member_id,subject);
			
			
			/* 사진을 삭제하면 블라인드 게시판에서 사진을 확인못하는 상황이 발생... 일단 사진 삭제기능은 빼는 걸로
			ArrayList<PhotoDTO> deliPhotoList = dao.deliPhotoList(board_idx, "배달게시판");
		    logger.info(board_idx + " 번 게시물에 업로드된 사진 수 : " + deliPhotoList.size());
			
			
			// 글을 지울 때 사진이 있다면 사진도 함께 지워줘야 한다
			if(delCount > 0 && deliPhotoList.size() > 0) {
				// DB 에서 사진정보를 지워준다.
				dao.photoDel(board_idx);
				
				for (PhotoDTO photo : deliPhotoList) {
			        File f = new File("C:/STUDY/SPRING_ADVANCE/GDJ48_1_FINAL_WITH/src/main/webapp/resources/photo/" + photo.getNewFileName());
			        logger.info("삭제하려는 이미지의 파일명 : " + photo.getNewFileName());
			        
			        if(f.exists()) {
			            boolean success = f.delete();
			            logger.info(photo.getNewFileName() + " 의 삭제 여부 : " + success);
			        }
				}
		        
			}
			 // 이미지를 지워도 파일이름이 남아있어서 비워줌
	         deliPhotoList.clear();
			*/
		}
			
		return mav;
	}


	public String getMin_fund(String board_idx) {
		
		return dao.getMin_fund(board_idx);
	}
}
