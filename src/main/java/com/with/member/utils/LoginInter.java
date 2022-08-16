package com.with.member.utils;

import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.with.member.dao.LoginDAO;
import com.with.member.dto.MemberDTO;
import com.with.member.service.LoginService;

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

		if(loginId == null) {
			System.out.println("로그인을 하지 않은 상태");			
			//response.sendRedirect("/"); //로그인을 하지않고 /main 에서 배달,택시,식사를 누르면 로그인화면으로 가게하기..
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printwriter = response.getWriter();
			printwriter.print("<script>alert('로그인이 필요한 서비스입니다.'); location.href='/'</script>");
			printwriter.flush();
			printwriter.close();			
			return false;
		}else	{						
			return true;
		}
	}
}
	
/*
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
*/
