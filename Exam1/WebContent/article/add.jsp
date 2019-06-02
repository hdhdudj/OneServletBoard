<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>
</head>
<body>
	<h1>게시물 작성</h1>
	<form action="./doAdd.sbs" method="POST">
		<div>
			<input type="password" name="passwd" placeholder="비밀번호를 입력하세요.">
		</div>
		<br>
		<div>
			<input type="text" name="writer" placeholder="글쓴이를 입력하세요.">
		</div>
		<div>
			<input type="text" name="title" placeholder="제목을 입력하세요.">
		</div>
		<div>
			<textarea name="body" placeholder="내용을 입력하세요."></textarea>
		</div>
		<br>
		<div>
			<button type="submit">작성</button><input type="button" onclick="javascript:history.back();" value="취소">
		</div>
	</form>
</body>
</html>