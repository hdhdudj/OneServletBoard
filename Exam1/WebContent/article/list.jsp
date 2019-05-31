<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<style>
.listtable {
	border-collapse:collapse;
}
.listtable > thead > tr > th, td {
	padding:10px;
}
</style>
<meta charset="UTF-8">
<title>게시물 리스트</title>
</head>
<body>
	<h1>게시물 리스트</h1>
	<%
		List<Map<String, Object>> articles = (List<Map<String, Object>>)request.getAttribute("articles"); 
	%>
	<div>
		<a href="./add.jsp">작성하기</a>
	</div>
	<br>
	<% 
		if(articles.size() > 0){
		%>
	<table border=5 class="listtable">
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>제목</th>
				<th>비고</th>
			</tr>
		</thead>
		<% for(int i = 0 ; i < articles.size() ; i++){
				Map<String, Object> article = articles.get(i); %>
		<tbody>
			<tr>
				<td><%=article.get("id")%></td>
				<td><%=article.get("regDate").toString().substring(0,19)%></td>
				<td><a href="./detail.sbs?id=<%=article.get("id")%>"><%=article.get("title")%></a></td>
				<td><a href="./doDelete.sbs?id=<%=article.get("id")%>" onclick="return confirm('렬루 <%=article.get("id")%>번 게시물을 삭제하시겠습니까?!')">삭제</a></td>
			</tr>
		</tbody>
		<% } %>
	</table>
	<% 
		} else {
	%>
	<div>게시물이 없습니다. 첫 게시물 작성의 주인공이 되어보세요!</div>
	<% } %>
</body>
</html>