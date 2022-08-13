package com.with.member.utils;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.with.member.dao.LoginDAO;


public class PenaltyInter extends HandlerInterceptorAdapter {
	
	@Autowired LoginDAO dao;
	
	// pre handler : CONTROLLER 를 거치기 전에 이곳을 들린다.
	// 반환값이 false 이면, 해당 컨트롤러로 접근하지 못한다. (하얀 화면이 뜬다.)
	// 그래서 false 반환 보다는 response 를 이용해서 다른 요청으로 보낸다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("사용자의 이용제한여부를 체크합니다.");
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		// 로그인을 시도하는 아이디가 이용제한을 받고있는지/ 있다면 제한종료 날짜를 가져온다.
		Date chkPenalty = dao.chkPenalty(loginId);
		System.out.println("가져온 제한종료날짜 : " + chkPenalty);
		// 현재 시간을 가져온다.
		long miliseconds = System.currentTimeMillis();
        Date currDate = new Date(miliseconds);
        
		boolean pass = true; // 원래 이 코드 없이도 작동해야하는데 정상작동이 안돼서 임시방편
		
		if(currDate.compareTo(chkPenalty) < 0) {
			System.out.println("이용제한을 받고 있는 상태");
			// redirect:/ -> http://localhost:8080/{contextPath} 와 같다. 아래의 경우로 사용하기위해 웬만하면 서버설정에서 contextPath 를 지워두자.
			response.sendRedirect("/penaltyLogout?chkPenalty="+chkPenalty); // http://localhost:8080/ 이다. 때문에 만약 contextPath 가 존재하면 404 에러가 발생한다.
			pass = false; // 원래 이 코드 없이도 작동해야하는데 정상작동이 안돼서 임시방편
		}
		
		// 기본은 true 값이어야한다.
		return pass;
	}
	

}
