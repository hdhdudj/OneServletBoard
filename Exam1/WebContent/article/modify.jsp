<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="sbs.demo.controller.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>번 게시물 수정하기</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		ArticleController controller = new ArticleController();
		controller.dbLink = DBUtil.getNewDbLink();

		String sql = "SELECT id, title, body FROM article WHERE id='" + id + "';";
		Map<String, Object> article = controller.dbLink.getRow(sql);
	%>
	<h1><%=article.get("id")%>번 게시물 수정하기
	</h1>
	<form action="./doModify.sbs" method="POST">
		<div>
			<input type="hidden" name="id" value="<%=article.get("id")%>">
		</div>
		<div>
			<input type="password" name="passwd" placeholder="비번을 입력하세요.">
		</div>
		<div>
			<input type="text" name="title" value="<%=article.get("title")%>">
		</div>
		<div>
			<textarea type="text" name="body"><%=article.get("body")%></textarea>
		</div>
		<br>
		<div>
			<button type="submit">수정</button>
			<input type="reset" value="리셋"> <input type="button"
				onclick="javascript:history.back();" value="취소">
		</div>
	</form>
</body>
</html>