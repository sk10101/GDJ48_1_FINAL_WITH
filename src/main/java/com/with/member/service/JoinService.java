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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.member.dao.JoinDAO;
import com.with.member.dao.MemberDAO;
import com.with.member.dto.MemberDTO;

@Service
public class JoinService {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired JoinDAO dao;
	@Autowired MemberDAO mbdao;
	
	//회원가입
	public ModelAndView join(MultipartFile[] photos, MemberDTO dto, RedirectAttributes rAttr) {
		
		String plainPass = dto.getMember_pw();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		dto.setMember_pw(encoder.encode(plainPass));
		
		// 성공여부 확인
		int row = dao.join(dto);	
		logger.info("join success : "+row);
		
		// 실행 후 Parameter 에 담긴 member_id 추출
		String member_id = dto.getMember_id();
		logger.info("방금 넣은 회원 번호 : " + member_id);
		logger.info("photos : " + photos);
		
		// 파일을 올리지 않아도 fileSave 가 진행되는 것을 방지하는 조건문
		
		if(row > 0) {
			memberFileSave(photos, member_id);
		}
		
		ModelAndView mav = new ModelAndView();
		String msg = "회원가입에 실패 했습니다.";
		String page = "join";
		if(row >0) {
			msg = "회원가입에 성공 했습니다.";
			page = "redirect:/";
			/* 양수빈 매너점수 영역 작업 */
			
			String nameBox[] = {"친절함","응답속도","시간약속"};
			for(int i=0;i<3;i++) {
				mbdao.insert(member_id,nameBox[i],0);
			}
			
			/* 여기까지 */
		}
		/* mav.addObject("msg", msg); */
		rAttr.addFlashAttribute("msg", msg);
		mav.setViewName(page);
		return mav;
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
			String newFileName = System.currentTimeMillis() + ext;
			
			logger.info(oriFileName + " ===> " + newFileName);
			
			try {
				byte[] arr = photo.getBytes();
				Path path = Paths.get("C:/image/certificate/" + newFileName);
				// 같은이름의 파일이 나올 수 없기 떄문에 옵션 설정 안해도된다.
				Files.write(path, arr);
				logger.info(newFileName + " SAVE OK");
				// 4. 업로드 후 photo 테이블에 데이터 입력
				dao.memberFileWrite(oriFileName,newFileName,member_id);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
		
	}

	//모달 뿌려주는 ajax
	public ArrayList<MemberDTO> univList() { 
		  return dao.univList();
	  	}
	  
	//대학검색
	  public ArrayList<MemberDTO> univSearch(String university_name) {
		  return dao.univSearch(university_name); 
	  }

	  
	 //아이디 중복검사
	public HashMap<String, Object> IdOverlay(String chkId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String overId = dao.IdOverlay(chkId);
		logger.info("중복 아이디가 있나? "+overId);
		boolean over = overId==null?false:true; //over == true : 얘 중복이야
		//조건:overId가 null 맞아? 참이면 false(조건1) 거짓이면 true(조건2)
		map.put("IdOverlay", over);
		
		return map;
	}

		//이메일 중복검사
	public HashMap<String, Object> EmailOverlay(String chkEmail) {
		HashMap<String, Object> maps = new HashMap<String, Object>();
		String overEmail = dao.EmailOverlay(chkEmail);
		logger.info("중복 이메일이 있나? "+overEmail);
		boolean overs = overEmail == null ? false : true;
		maps.put("overlays", overs);
		
		return maps;
	}	





}
