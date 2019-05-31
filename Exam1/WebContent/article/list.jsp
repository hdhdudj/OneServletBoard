<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js">
</script>
<script>
function deleteOnclick(el){
	var $el = $(el);    
    var $div = $el.closest('div');
    $div.addClass('.popup');	
	$('.popup').css('display','block');
};
function deleteOnclickdelete(){
	$('.popup').css('display','none');
};
</script>
<style>
.listtable {
	border-collapse:collapse;
}
.listtable > thead > tr > th, td {
	padding:10px;
}

.listtable > tbody > form > div {
	top:50%;
	left:50%;
	transform:translateX(-50%) translateY(-50%);
	background-color:red;
	border:2px solid black;
	position:fixed;
	display:none;
}
div > span >div {
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
				<td><a href="javascript:;" onclick="deleteOnclick(this);">삭제</a></td>
			</tr>
			<form action="./doDelete.sbs" method="POST">
					<div>
						<span>
							<div>
								<%=article.get("id")%>번 게시물을 삭제하실?
							</div>
							<div>
								비번 : <input type="password" name="passwd">
							</div>
							<div>
								<button type="submit">입력</button>
								<input type="button" onclick="javascript:deleteOnclickdelete();" value="취소">
							</div>
						</span>
					</div>
			</form>
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