package com.with.report.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class BlindInter extends HandlerInterceptorAdapter{
	
	// pre handler : CONTROLLER 를 거치기 전에 이곳을 들린다.
	// 반환값이 false 이면, 해당 컨트롤러로 접근하지 못한다. (하얀 화면이 뜬다.)
	// 그래서 false 반환 보다는 response 를 이용해서 다른 요청으로 보낸다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("Controller 진입 전...");
		HttpSession session = request.getSession();
		
		String loginId = (String) session.getAttribute("loginId");
		String member_class = (String) session.getAttribute("member_class");
		boolean pass = true; // 원래 이 코드 없이도 작동해야하는데 정상작동이 안돼서 임시방편
		
		if(loginId == null || (loginId != null && member_class.equals("일반회원"))) {
			System.out.println("일반회원이 관리자 페이지에 접근을 시도함");
			// 일단은 메인페이지로 보낸다.
			response.sendRedirect("/forcedMainGo");
			pass = false; // 원래 이 코드 없이도 작동해야하는데 정상작동이 안돼서 임시방편
		}
		
		// 기본은 true 값이어야한다.
		return pass;
	}
}
