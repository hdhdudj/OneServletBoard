package sbs.demo.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sbs.demo.controller.DBUtil.*;

public class MemberController {
	public DBLink dbLink;
	
	public String _login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		RequestDispatcher rd = request.getRequestDispatcher("./login.jsp");
		rd.forward(request, response); 
		return "";
	}
	public String _myPage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		RequestDispatcher rd = request.getRequestDispatcher("./myPage.jsp");
		rd.forward(request, response); 
		return "";
	}
	public String _doLogin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String loginId = request.getParameter("id");
		String loginPw = request.getParameter("pw");
		
		int memberid = -1;
		String sql = "SELECT * FROM member;";
		
		List<Map<String, Object>> memberInfos = dbLink.getRows(sql); 
		
		for(int i = 0 ; i < memberInfos.size() ; i++) {
			if(loginId.equals(memberInfos.get(i).get("loginId")) && loginPw.equals(memberInfos.get(i).get("loginPw"))) {
				memberid = Integer.parseInt(memberInfos.get(i).get("id").toString());
				break;
			}
		}
		
		if(memberid == -1) {
			response.getWriter().append("<script>alert('없는 회원이거나 비번이 잘못되었습니다.'); history.back();</script>");
		}else {
			sql = "SELECT * FROM member WHERE id='"+memberid+"';";
			Map<String, Object> memberInfo = dbLink.getRow(sql);
			
			Cookie idCook = new Cookie("id", (String)memberInfo.get("loginId"));
			Cookie pwCook = new Cookie("pw", (String)memberInfo.get("loginPw"));
			Cookie nmCook = new Cookie("nm", URLEncoder.encode((String)memberInfo.get("erum"), "UTF-8"));
			Cookie nickCook = new Cookie("nickname", (String)memberInfo.get("nickname"));
			
			response.addCookie(idCook);
			response.addCookie(pwCook);			
			response.addCookie(nickCook);
			response.addCookie(nmCook);

			request.setAttribute("idCook", idCook);
			request.setAttribute("pwCook", pwCook);
			request.setAttribute("nickCook", nickCook);
			request.setAttribute("nmCook", nmCook);
			
			ServletContext context = request.getServletContext();
			RequestDispatcher dispatcher = context.getRequestDispatcher("/member/myPage.jsp");
			dispatcher.forward(request, response);
		}
		return "";
	}
	
}