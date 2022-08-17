package com.with.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.with.member.dao.MemberDAO;
import com.with.member.dto.MannerDTO;
import com.with.member.dto.MemberDTO;

@Service
public class MemberService {
	@Autowired MemberDAO dao;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public HashMap<String, Object> mblist(String member_id) {
		return dao.mblist(member_id);
	}

	public void update(String member_pw, String phone, int hide, String member_id) {
		dao.update(member_pw, phone, hide, member_id);

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

}
