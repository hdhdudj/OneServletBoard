package sbs.demo.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sbs.demo.controller.*;

/**
 * Servlet implementation class FrontServlet
 */
@WebServlet("*.sbs")
public class FrontServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String[] uriBits = request.getRequestURI().split("/");
		
		String controllerName = uriBits[2];
		String funcName = uriBits[3];
		
		if(controllerName.contentEquals("article")) { 
			ArticleController controller = new ArticleController();
			
			controller.dbLink = DBUtil.getNewDbLink();
			
			if(funcName.equals("list.sbs")) {
				controller._list(request, response);
			}
			else if(funcName.equals("detail.sbs")) {
				controller._detail(request, response);
			}
			
			controller.dbLink.close();
		}
		else if(controllerName.contentEquals("member")) { 
			MemberController controller = new MemberController();
			
			controller.dbLink = DBUtil.getNewDbLink();
			
			if(funcName.equals("login.sbs")) {
				controller._login(request, response);
			}
			else if(funcName.equals("myPage.sbs")) {
				controller._myPage(request, response);
			}
			
			controller.dbLink.close();
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String[] uriBits = request.getRequestURI().split("/");
		
		String controllerName = uriBits[2];
		String funcName = uriBits[3];
		
		
		if(controllerName.contentEquals("article")) {
			ArticleController controller = new ArticleController();
			
			controller.dbLink = DBUtil.getNewDbLink();
			if(funcName.equals("doAddReply.sbs")) {
				controller._doAddReply(request, response);
			}
			else if(funcName.equals("doAdd.sbs")) {
				controller._doAdd(request, response);
			}
			else if(funcName.equals("doModify.sbs")) {
				controller._doModify(request, response);
			}
			else if(funcName.equals("doDelete.sbs")) {
				controller._doDelete(request,response);
			}
			else if(funcName.equals("doDeleteReply.sbs")) {
				controller._doDeleteReply(request,response);
			}
			else if(funcName.equals("doModifyReply.sbs")) {
				controller._doModifyReply(request,response);
			}
			
			controller.dbLink.close();
		}
		else if(controllerName.contentEquals("member")) { 
			MemberController controller = new MemberController();
			
			controller.dbLink = DBUtil.getNewDbLink();
			
			if(funcName.equals("doLogin.sbs")) {
				controller._doLogin(request, response);
			}
			
			controller.dbLink.close();
		}
	}
}
