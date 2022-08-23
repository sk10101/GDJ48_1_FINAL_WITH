package com.with.member.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.with.main.dao.MainDAO;
import com.with.member.dao.MemberDAO;
import com.with.member.dto.MannerDTO;
import com.with.member.dto.MemberDTO;

@Service
public class MemberService {
	@Autowired MemberDAO dao;
	@Autowired MainDAO mainDao;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public HashMap<String, Object> mblist(String member_id) {
		return dao.mblist(member_id);
	}
	
	private void memberFileSave(MultipartFile[] photos, String member_id) {
		// 이미지 파일 업로드
		for (MultipartFile photo : photos) {
			String oriFileName = photo.getOriginalFilename();
			
			// 이미지 파일을 업로드 안했을 때를 제외하기 위한 조건문 처리
			if(!oriFileName.equals("")) {
				logger.info("업로드 진행");
				// 확장자 추출
				String ext = oriFileName.substring(oriFileName.lastIndexOf(".")).toLowerCase();
				// 새 파일 이름으로 업로드 당시 시간을 붙인다.
				String newFileName = dao.FileName(member_id);
				logger.info(oriFileName + " ===> " + newFileName);
				try {
					byte[] arr = photo.getBytes();
					Path path = Paths.get("C:\\STUDY\\SPRING_ADVANCE\\GDJ48_1_FINAL_WITH\\src\\main\\webapp\\resources\\certificate\\" + newFileName);
					// 같은이름의 파일이 나올 수 없기 떄문에 옵션 설정 안해도된다.
					Files.write(path, arr);
					logger.info(newFileName + " SAVE OK");
					// 4. 업로드 후 photo 테이블에 데이터 입력
					dao.memberFileUpdate(oriFileName,newFileName,member_id);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public ModelAndView madetail(String member_id, int page) {
		// 페이징 처리
		ModelAndView mav = new ModelAndView("myPage/mannerDetail");
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<MannerDTO> mannerList = pagination(member_id, page, map);
		logger.info("게시글의 개수 : " + mannerList.size());
		mav.addObject("manner", mannerList);
		mav.addObject("map", map);
		return mav;
	}

	private ArrayList<MannerDTO> pagination(String idx, int page, HashMap<String, Object> map) {
		int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
		logger.info("페이지 갯수 : {}", page);
		ArrayList<MannerDTO> madetail = new ArrayList<MannerDTO>();

		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = 0;
		int allCount = dao.allCount(idx);
		logger.info("allCount : {}",allCount);
		allCnt = allCount/3;
		logger.info("allCnt : " + allCnt);

		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if (allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			allCnt = 1;
		}

		int pages = allCnt % cnt != 0 ? (allCnt / cnt) + 1 : (allCnt / cnt);
		logger.info("pages : " + pages);

		if (page > pages) {
			page = pages;
		}
		map.put("idx",idx);
		map.put("cnt",cnt);
		map.put("page",page);
		map.put("pages", pages); // 최대 페이지 수
		int offset = cnt * (page - 1);
		logger.info("offset : " + offset);

		map.put("offset", offset);
		map.put("currPage", page); // 현재 페이지

		madetail = dao.madetail(map);
		
		logger.info("페이징 체크포인트");
		return madetail;
	}

	public ModelAndView blockList(String member_id, HashMap<String, Object> params) {
		ModelAndView mav = new ModelAndView("myPage/blockUserList");
		ArrayList<MemberDTO> name = blockPagination(member_id, params);
		logger.info("게시글의 개수 : " + name.size());
		mav.addObject("name", name);
		mav.addObject("map", params);
		return mav;
	}
	
	private ArrayList<MemberDTO> blockPagination(String idx,HashMap<String, Object> map) {
		int page = Integer.parseInt((String) map.get("page"));
		int cnt = 10; // 한 페이지에 10 건의 게시글 (고정)
		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = 0;
		int allCount = dao.blockCount(idx);
		logger.info("allCount : {}",allCount);
		allCnt = allCount;
		logger.info("allCnt : " + allCnt);

		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if (allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			allCnt = 1;
		}
		String word = (String) map.get("word");
		logger.info("word의 값 : "+word);
		if(word != "") {
			map.put("word", word); // 검색어 입력
		}
		
		int pages = allCnt % cnt != 0 ? (allCnt / cnt) + 1 : (allCnt / cnt);
		logger.info("pages : " + pages);
		
		if (page > pages) {
			page = pages;
		}
		map.put("idx",idx);
		map.put("cnt",cnt);
		map.put("page",page);
		map.put("pages", pages); // 최대 페이지 수
		int offset = cnt * (page - 1);
		logger.info("offset : " + offset);

		map.put("offset", offset);
		map.put("currPage", page); // 현재 페이지
		
		ArrayList<MemberDTO> block = new ArrayList<MemberDTO>();
		block = dao.blockList(map);
		logger.info("페이징 체크포인트");
		return block;
	}

	public void blockDelete(String member_id, String block_member) {
		dao.blockDelete(member_id,block_member);
	}

	public HashMap<String, Object> infoAll(String member_id, HashMap<String, Object> map) {
		String name = dao.univer(map.get("university_idx"));
		String nameBox[] = {"친절함","응답속도","시간약속"};
		float mannerAvg = dao.avg(member_id,nameBox[0]);
		int cnt=0;
		float avg[]= new float[4];
		int result[]= new int[4]; 
		if(mannerAvg!=0) {
			cnt = dao.macnt(member_id)/3; // 매너점수를 작성한 회원들 예) 12명
		}
		for(int i=0;i<3;i++) {
			if(mannerAvg!=0) {
				result[i]+=dao.average(member_id,nameBox[i]); //
				avg[i]=(float)result[i]/cnt;
				dao.mannerCnt(member_id,nameBox[i],avg[i]);
			} else {
				result[i]=0;
			}
			avg[3]+=avg[i];
		}
		int num[] = new int[4];
		for(int i=0;i<3;i++) {
			num[i]=(int)Math.round(avg[i]*1)/1;
			num[3]+=num[i];
		}
		map.put("university_idx",name);
		map.put("manner_cnt",cnt);
		map.put("avg_kindFloat",Math.round(avg[0]*10)/10.0);
		map.put("avg_answerFloat",Math.round(avg[1]*10)/10.0);
		map.put("avg_timeFloat",Math.round(avg[2]*10)/10.0);
		map.put("avg_allAvg",Math.round((avg[3]/3)*10)/10.0);
		map.put("avg_kindInt",num[0]);
		map.put("avg_answerInt",num[1]);
		map.put("avg_timeInt",num[2]);
		return map;
	}

	public void blockUser(String member, String mb_id) {
		dao.blockUser(member,mb_id);
	}

	public String boardName(int board) {
		return dao.boardName(board);
	}

	public int whoId(String mb_id, String member) {
		return dao.whoId(mb_id,member);
	}

	public int pwUpdate(HashMap<String, Object> params) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String pw = (String) params.get("pw");
		params.put("pw", encoder.encode(pw));
		return dao.pwUpdate(params);
	}

	public void photoUpdate(MultipartFile[] photo_idx, HashMap<String, Object> params) {
		memberFileSave(photo_idx, (String) params.get("member_id"));
	}

	public void mbPhone(HashMap<String, Object> params) {
		dao.mbPhone(params);
	}

	public void hideUpdate(HashMap<String, Object> params) {
		dao.hideUpdate(params);
	}

	public void univer_add(HashMap<String, Object> params) {
		dao.univer_add(params);
	}
	public int blockChk(String member, String mb_id) {
		// 차단했는지 여부 확인용
		
		return dao.blockChk(member,mb_id);
	}

}
