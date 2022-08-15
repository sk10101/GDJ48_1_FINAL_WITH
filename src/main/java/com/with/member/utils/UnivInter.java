package com.with.member.utils;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.with.member.dto.MemberDTO;

public class UnivInter extends HandlerInterceptorAdapter {

	// pre handler : CONTROLLER 를 거치기 전에 이곳을 들린다.
	// 반환값이 false 이면, 해당 컨트롤러로 접근하지 못한다. (하얀 화면이 뜬다.)
	// 그래서 false 반환 보다는 response 를 이용해서 다른 요청으로 보낸다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println(" Controller 진입 전.........");
		HttpSession session = request.getSession(); 
		
		String loginId = (String) session.getAttribute("loginId"); 
		int certficate_chk = (Integer) session.getAttribute("certficate_chk"); 
		//MemberDTO dto = dao.getMbInfo(loginId);
		//dto.getCertficate_chk();
		
		System.out.println(certficate_chk);
		
		if(loginId == null ||  (loginId != null ) && certficate_chk == 0){
			System.out.println("대학인증이 안 된 상태");			
			//response.sendRedirect("/"); 
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printwriter = response.getWriter();
			printwriter.print("<script>alert('대학인증이 되지 않은 회원입니다.'); location.href='/main'</script>");
			printwriter.flush();
			printwriter.close();			
			return false;
		}else	{						
			return true;
		}
	}
}	
	
	
	
	
	/*
	 * // pre handler : CONTROLLER 를 거치기 전에 이곳을 들린다. // 반환값이 false 이면, 해당 컨트롤러로 접근하지
	 * 못한다. (하얀 화면이 뜬다.) // 그래서 false 반환 보다는 response 를 이용해서 다른 요청으로 보낸다.
	 * 
	 * @Override public boolean preHandle(HttpServletRequest request,
	 * HttpServletResponse response, Object handler) throws Exception {
	 * System.out.println("Controller 진입 전................"); HttpSession session =
	 * request.getSession();
	 * 
	 * String loginId = (String) session.getAttribute("loginId"); String
	 * member_class = (String) session.getAttribute("member_class"); boolean pass =
	 * true; // 원래 이 코드 없이도 작동해야하는데 정상작동이 안돼서 임시방편
	 * 
	 * if(loginId == null || (loginId != null && member_class.equals("일반회원"))) {
	 * System.out.println("대학인증이 안된 회원이 관리자 페이지에 접근을 시도!"); // 일단은 메인페이지로 보낸다.
	 * response.sendRedirect("/forcedMainGo"); pass = false; // 원래 이 코드 없이도 작동해야하는데
	 * 정상작동이 안돼서 임시방편 }
	 * 
	 * // 기본은 true 값이어야한다. return pass; }
	 */
	
	

