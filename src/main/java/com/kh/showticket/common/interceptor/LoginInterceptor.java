package com.kh.showticket.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.showticket.member.model.vo.Member;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response,Object handler)throws Exception {
		
		HttpSession session = request.getSession();
		
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		
		if(memberLoggedIn == null) {
			request.setAttribute("msg", "로그인 후 이용하세요");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
				   .forward(request, response);
			
			return false;//더이상 핸들러로 진행되지 않도록 false 리턴
		}
		
		return super.preHandle(request, response, handler);
	}

	
}
