package com.with.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInter extends HandlerInterceptorAdapter {
	
	
	// pre handler : CONTROLLER 를 거치기 전에 이곳을 들린다.
	// 반환값이 false 이면, 해당 컨트롤러로 접근하지 못한다. (하얀 화면이 뜬다.)
	// 그래서 false 반환 보다는 response 를 이용해서 다른 요청으로 보낸다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("Controller 진입 전...");
		HttpSession session = request.getSession();
		
		String loginId = (String) session.getAttribute("loginId");
		boolean pass = true; // 원래 이 코드 없이도 작동해야하는데 정상작동이 안돼서 임시방편
		
		if(loginId == null) {
			System.out.println("로그인을 하지 않은 상태");
			// redirect:/ -> http://localhost:8080/{contextPath} 와 같다. 아래의 경우로 사용하기위해 웬만하면 서버설정에서 contextPath 를 지워두자.
			response.sendRedirect("/"); // http://localhost:8080/ 이다. 때문에 만약 contextPath 가 존재하면 404 에러가 발생한다.
			pass = false; // 원래 이 코드 없이도 작동해야하는데 정상작동이 안돼서 임시방편
		}
		
		// 기본은 true 값이어야한다.
		return pass;
	}
	
	
	// post handler : CONTROLLER 를 거치고 난 이후 VIEW에 도달하기 전에 들린다.
	// ModelAndView 를 이용해 원하는 값을 뷰로 보낼 때 활용 한다.
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView mav) throws Exception {
		System.out.println("Controller 에서 나온 후...");
		
		String loginId = (String) request.getSession().getAttribute("loginId");
		
		String content = "<div>안녕하세요 "+ loginId +"님 <a href='logout.do'>로그아웃</a></div>";
		mav.addObject("loginBox",content);
	}
	
}
