package sbs.demo.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sbs.demo.controller.DBUtil.*;

public class ArticleController {
	public DBLink dbLink;
	
	public String _list(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		response.getWriter().append("list 실행됨");

		String sql = "SELECT * FROM article ORDER BY id DESC";
		
		List<Map<String, Object>> articles = dbLink.getRows(sql);
		request.setAttribute("articles", articles);
		
		ServletContext context = request.getServletContext();
		RequestDispatcher dispatcher = context.getRequestDispatcher("/article/list.jsp");
		dispatcher.forward(request, response);
				
		return "";
	}
	public void _detail(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		response.getWriter().append("detail 실행됨");
		String id = request.getParameter("id");

		if (id == null) {
			response.getWriter().append("<script> alert('id를 입력해주세요.'); history.back(); </script>");
			return;
		}

		int idid = 0;

		try {
			idid = Integer.parseInt(id);
		} catch (NumberFormatException e) {
			response.getWriter().append("<script> alert('id를 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}

		if (idid < 1) {
			response.getWriter().append("<script> alert('id를 0보다 큰 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}
		
		String sql = "SELECT * FROM article WHERE id='"+id+"';";
		Map<String, Object> article = dbLink.getRow(sql);
		request.setAttribute("article", article);
		
		sql="SELECT * FROM articleReply WHERE articleId='"+id+"';";
		List<Map<String, Object>> articleReplies = dbLink.getRows(sql);
		request.setAttribute("articleReplise", articleReplies);
		
		ServletContext context = request.getServletContext();
		RequestDispatcher dispatcher = context.getRequestDispatcher("/article/detail.jsp?id="+id+"");
		dispatcher.forward(request, response); 
		return;
	}
	public void _doAdd(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String title = request.getParameter("title");
		String body = request.getParameter("body");
		
		if (title == null) {
			response.getWriter().append("<script> alert('제목을 입력해주세요.'); history.back(); </script>");
			return;
		}

		title = title.trim();

		if (title.length() == 0) {
			response.getWriter().append("<script> alert('제목을 입력해주세요.'); history.back(); </script>");
			return;
		}

		title = title.replaceAll("\'", "\\\\'");

		if (body == null) {
			response.getWriter().append("<script> alert('내용을 입력해주세요.'); history.back(); </script>");
			return;
		}

		body = body.trim();

		if (body.length() == 0) {
			response.getWriter().append("<script> alert('내용을 입력해주세요.'); history.back(); </script>");
			return;
		}

		body = body.replaceAll("\'", "\\\\'");
		
		int id = dbLink.getRowIntValue("SELECT MAX(id) FROM article");
		String sql = "INSERT INTO article SET regDate=NOW(), id='"+(id+1)+"', title ='"+title+"', body='"+body+"';";
		dbLink.executeQuery(sql);
		
		response.getWriter().append("<script>alert('게시물이 작성되었습니다.')</script>");
		response.getWriter().append("<script>location.replace('./list.sbs')</script>");
		return;
	}
	
	public void _doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String id = request.getParameter("id");
		
		if (id == null) {
			response.getWriter().append("<script> alert('id를 입력해주세요.'); history.back(); </script>");
			return;
		}

		int idid = 0;

		try {
			idid = Integer.parseInt(id);
		} catch (NumberFormatException e) {
			response.getWriter().append("<script> alert('id를 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}

		if (idid < 1) {
			response.getWriter().append("<script> alert('id를 0보다 큰 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}
		
		String sql = "DELETE FROM article WHERE id='"+id+"';";
		dbLink.executeQuery(sql);
		
		response.getWriter().append("<script>alert('"+id+"번 게시물을 삭제하였습니다.')</script>");
		response.getWriter().append("<script>location.replace('./list.sbs')</script>");
		return;
	}
	
	public void _doModify (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String title = request.getParameter("title");
		String body = request.getParameter("body");
		String id = request.getParameter("id");
		
		if (title == null) {
			response.getWriter().append("<script> alert('제목을 입력해주세요.'); history.back(); </script>");
			return;
		}

		title = title.trim();

		if (title.length() == 0) {
			response.getWriter().append("<script> alert('제목을 입력해주세요.'); history.back(); </script>");
			return;
		}

		title = title.replaceAll("\'", "\\\\'");
		
		if (body == null) {
			response.getWriter().append("<script> alert('내용을 입력해주세요.'); history.back(); </script>");
			return;
		}

		body = body.trim();

		if (body.length() == 0) {
			response.getWriter().append("<script> alert('내용을 입력해주세요.'); history.back(); </script>");
			return;
		}

		body = body.replaceAll("\'", "\\\\'");
		
		if (id == null) {
			response.getWriter().append("<script> alert('id를 입력해주세요.'); history.back(); </script>");
			return;
		}

		int idid = 0;

		try {
			idid = Integer.parseInt(id);
		} catch (NumberFormatException e) {
			response.getWriter().append("<script> alert('id를 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}

		if (idid < 1) {
			response.getWriter().append("<script> alert('id를 0보다 큰 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}
		
		String sql = "UPDATE article SET title='"+title+"', body='"+body+"' WHERE id='"+id+"';";
		dbLink.executeQuery(sql);
		
		response.getWriter().append("<script>alert('"+id+"번 게시물이 수정되었습니다.')</script>");
		response.getWriter().append("<script>location.replace('./detail.sbs?id="+id+"')</script>");
		return;
	}
	
	public void _doAddReply(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String body = request.getParameter("body");
		String articleid = request.getParameter("articleid");
		
		if (articleid == null) {
			response.getWriter().append("<script> alert('id를 입력해주세요.'); history.back(); </script>");
			return;
		}

		int idid = 0;

		try {
			idid = Integer.parseInt(articleid);
		} catch (NumberFormatException e) {
			response.getWriter().append("<script> alert('id를 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}

		if (idid < 1) {
			response.getWriter().append("<script> alert('id를 0보다 큰 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}
		
		String sql = "SELECT MAX(id) FROM articleReply";
		int id = dbLink.getRowIntValue(sql);
		
		
		if (body == null) {
			response.getWriter().append("<script> alert('내용을 입력해주세요.'); history.back(); </script>");
			return;
		}

		body = body.trim();

		if (body.length() == 0) {
			response.getWriter().append("<script> alert('내용을 입력해주세요.'); history.back(); </script>");
			return;
		}

		body = body.replaceAll("\'", "\\\\'");
		
		sql = "INSERT INTO articleReply SET regDate=NOW(), id='"+(id+1)+"', body='"+body+"', articleId='"+articleid+"';";
		dbLink.executeQuery(sql);
		
		response.getWriter().append("<script>alert('댓글을 작성했습니다.')</script>");
		response.getWriter().append("<script>location.replace('./detail.sbs?id="+articleid+"')</script>");
		
		return;
	}
	
	public void _doDeleteReply(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String id = request.getParameter("id");
		
		if (id == null) {
			response.getWriter().append("<script> alert('id를 입력해주세요.'); history.back(); </script>");
			return;
		}

		int idid = 0;

		try {
			idid = Integer.parseInt(id);
		} catch (NumberFormatException e) {
			response.getWriter().append("<script> alert('id를 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}

		if (idid < 1) {
			response.getWriter().append("<script> alert('id를 0보다 큰 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}
		
		String sql = "SELECT articleId FROM articleReply WHERE id='"+id+"';";
		int articleid = dbLink.getRowIntValue(sql);
		
		sql = "DELETE FROM articleReply WHERE id='"+id+"';";
		dbLink.executeQuery(sql);
		
		response.getWriter().append("<script>alert('"+id+"번 댓글을 삭제했습니다.')</script>");
		response.getWriter().append("<script>location.replace('./detail.sbs?id="+articleid+"')</script>");
		
		return;
	}
	public void _doModifyReply(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String id = request.getParameter("id");
		String body = request.getParameter("body");
		
		if (id == null) {
			response.getWriter().append("<script> alert('id를 입력해주세요.'); history.back(); </script>");
			return;
		}

		int idid = 0;

		try {
			idid = Integer.parseInt(id);
		} catch (NumberFormatException e) {
			response.getWriter().append("<script> alert('id를 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}

		if (idid < 1) {
			response.getWriter().append("<script> alert('id를 0보다 큰 숫자로 입력해주세요.'); history.back(); </script>");
			return;
		}
		
		if (body == null) {
			response.getWriter().append("<script> alert('내용을 입력해주세요.'); history.back(); </script>");
			return;
		}

		body = body.trim();

		if (body.length() == 0) {
			response.getWriter().append("<script> alert('내용을 입력해주세요.'); history.back(); </script>");
			return;
		}

		body = body.replaceAll("\'", "\\\\'");
		
		String sql = "SELECT articleId FROM articleReply WHERE id='"+id+"';";
		int articleid = dbLink.getRowIntValue(sql);
		sql = "UPDATE articleReply SET body='"+body+"' WHERE id='"+id+"';";
		dbLink.executeQuery(sql);
		
		response.getWriter().append("<script>alert('"+id+"번 댓글을 수정했습니다.')</script>");
		response.getWriter().append("<script>location.replace('./detail.sbs?id="+articleid+"')</script>");
		return;
	}
	
}