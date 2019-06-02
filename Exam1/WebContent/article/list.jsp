<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js">
	
</script>
<script>
function writerColor(el){
    if(el == '관리자' || el == '주인장'){
    	var name = '.';
		var name2 = name.concat(el);
		$(name2).css('color', 'blue');
		$(name2).css('font-family', 'D2coding');
    	document.write(el);
    }
    else{
    	document.write(el);
    }
}
function deleteOnclick(el){
    var el = String(el);
    var el2 = '.';
    var el3 = el2.concat(el);
	$(el3).css('display','block');
};
function deleteOnclickCancel() {
	$('.popup,.popup-bg').css('display','none');
};
</script>
<style>
.popup-close::before, .popup-close::after {
    content:"";
    position:absolute;
    top:0;
    left:50%;
    width:20%;
    height:100%;
    background-color:black;
    transform:translateX(-50%) rotate(45deg);
}

.popup-close::after {
    transform:translateX(-50%) rotate(-45deg);
}
.popup-close:hover {
    transform:rotate(-10deg);
}
.popup-close {
	float:right;
    width:20px;
    height:20px;
    position:relative;
    cursor:pointer;
}
body{
	padding-left:50px;
	padding-bottom:50px;
}
.listtable {
	border-collapse: collapse;
}

.listtable>thead>tr>th, td {
	padding: 10px;
	text-align:center;
}
.articleTitle {
	text-align:inherit;
	padding-left: 20px;
}
.popup-bg {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.5);
	display: none;
}

.popup {
	top: 50%;
	left: 50%;
	width:400px;
	transform: translateX(-50%) translateY(-50%);
	background-color: red;
	border: 2px solid black;
	position: fixed;
	display: none;
}
div>nav>div {
	padding: 30px;
}
h1 > a {
	text-decoration:none;
	color:inherit;
}
</style>
<meta charset="UTF-8">
<title>게시물 리스트</title>
</head>
<body>
	<h1><a href="./list.sbs">게시물 리스트</a></h1>
	<%
		String el = "";
		List<Map<String, Object>> articles = (List<Map<String, Object>>) request.getAttribute("articles");
	%>
	<div>
		<a href="./add.jsp">작성하기</a>
	</div>
	<br>
	<%
		if (articles.size() > 0) {
	%>
	<table border=5 class="listtable">
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>글쓴이</th>
				<th>제목</th>
				<th>비고</th>
			</tr>
		</thead>
		<%
			for (int i = 0; i < articles.size(); i++) {
					Map<String, Object> article = articles.get(i);
		%>
		<tbody>
			<tr>
				<td><%=article.get("id")%></td>
				<td><%=article.get("regDate").toString().substring(0, 19)%></td>
				<td>
				<%  el = (String)article.get("writer");%>
					<div class="<%=article.get("writer")%>">
						<script>
							var name = '<%=el%>';
    						writerColor(name);
						</script>
					</div>
				</td>
				<td class="articleTitle"><a href="./detail.sbs?id=<%=article.get("id")%>"><%=article.get("title")%></a> (<%=article.get("replyNum")%>)</td>
				<td><a href="javascript:;"
					onclick="deleteOnclick(<%=article.get("id")%>);">삭제</a></td>
			</tr>
			<div class="popup-bg <%=article.get("id")%>" onclick="deleteOnclickCancel();"></div>
			<div class="popup <%=article.get("id")%>">
				<nav>
					<div class="popup-close" onclick="deleteOnclickCancel();">
        			</div>
					<form action="./doDelete.sbs" method="POST">
						<div>
							<%=article.get("id")%>번 게시물을 삭제하실?
						</div>
						<div>
							비번 : <input type="password" name="passwd">
						</div>
						<div>
							<input type="hidden" name="id" value="<%=article.get("id")%>">
						</div>
						<div>
							<button type="submit">입력</button>
							<input type="button" onclick="javascript:deleteOnclickCancel();"
								value="취소">
						</div>
					</form>
				</nav>
			</div>
		</tbody>
		<%
			}
		%>
	</table>
	<%
		} else {
	%>
	<div>게시물이 없습니다. 첫 게시물 작성의 주인공이 되어보세요!</div>
	<%
		}
	%>
</body>
</html>