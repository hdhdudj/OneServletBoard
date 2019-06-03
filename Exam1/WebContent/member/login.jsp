<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.loginbox {
		border:2px solid black;
		display:inline-block;
	}
	.loginbox div{
		padding:10px;
	}
</style>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<h1>로그인 페이지</h1>
	<div class="loginbox">
		<form action="./doLogin.sbs" method="POST">
			<div>
				아이디 : <input type="text" name="id" placeholder="아이디를 입력하세요.">
			</div>
			<div>
				비번 : <input type="password" name="pw" placeholder="비번을 입력하세요.">
			</div>
			<div>
				<input type="submit" value="로그인">
			</div>
		</form>
	</div>
</body>
</html>