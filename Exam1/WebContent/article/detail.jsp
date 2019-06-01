<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js">
	
</script>
<meta charset="UTF-8">
<style>
.popup-bg {
	position: fixed;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	background-color: rgba(0, 0, 0, 0.5);
	display: none;
}

.popup, .popup-reply, .popup-modify {
	top: 50%; 
	left : 50%; 
	transform : translateX( -50%) translateY( -50%);
	background-color : red; 
	border : 2px solid black; 
	position : fixed;
	display: none;
}

.listtable {
	border-collapse: collapse;
}

.listtable>thead>tr>th, td {
	padding: 10px;
}

.article-reply-list {
	border-collapse: collapse;
}

.article-reply-list>thead>tr>th, td {
	padding: 10px;
}

.article-reply-list>tbody>tr .edit-mode-visible {
	display: none;
}

.article-reply-list>tbody>tr.edit-mode .edit-mode-visible {
	display: block;
}

.article-reply-list>tbody>tr.edit-mode .read-mode-visible {
	display: none;
}
.popup div, .popup-reply div, .popup-modify div {
	padding:10px;
}
</style>
<script>
	function onclickDelete1() {
		$('.popup,.popup-bg').css('display', 'block');
	}
	function enableEditModepw(el){
		var el = String(el);
		var el2 = '.popup-modify.';
		var el3 = el2.concat(el);
		$(el3).css('display', 'block');
		$('.popup-bg').css('display', 'block');
	}
	function onclickDelete(el) {
		var el = String(el);
		var el2 = '.popup-reply.';
		var el3 = el2.concat(el);
		$(el3).css('display', 'block');
		$('.popup-bg').css('display', 'block');
	}
	function onclickDeleteCancel() {
		$('.popup,.popup-bg,.popup-reply,.popup-modify').css('display', 'none');
	}
	function enableEditMode(el) {
		var $el = $(el);
		var $tr = $el.closest('tr');
		$tr.addClass('edit-mode');
	}

	function disableEditMode(el) {
		var $el = $(el);
		var $tr = $el.closest('tr');
		$tr.removeClass('edit-mode');
	}
</script>
<title>게시물 상세보기</title>
</head>
<body>
	<%
		Map<String, Object> article = (Map<String, Object>) request.getAttribute("article");
		List<Map<String, Object>> articleReplies = (List<Map<String, Object>>) request
				.getAttribute("articleReplise");
	%>
	<div>
		<a href="./list.sbs">글목록</a> <a href="./add.jsp">글작성</a> <a
			href="./modify.jsp?id=<%=article.get("id")%>">글수정</a> <a
			href="javascript:;" onclick="onclickDelete1();">글삭제</a>
	</div>
	<br>
	<table border=5 class="listtable">
		<tr>
			<th>번호</th>
			<td><%=article.get("id")%></td>
		</tr>
		<tr>
			<th>날짜</th>
			<td><%=article.get("regDate").toString().substring(0, 19)%></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=article.get("title")%></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%=article.get("body")%></td>
		</tr>
	</table>
	<div class="popup-bg"></div>
	<div class="popup">
		<form action="./doDelete.sbs" method="POST">
			<div>
				<%=article.get("id")%>번 글을 삭제하실?!
			</div>
			<div>
				비번 : <input type="password" name="passwd">
			</div>
			<div>
				<input type="hidden" name="id" value="<%=article.get("id")%>">
			</div>
			<div>
				<button type="submit">입력</button>
				<input type="button" onclick="javascript:onclickDeleteCancel();"
					value="취소">
			</div>
		</form>
	</div>
	<h2>댓글</h2>
	<%
		if (articleReplies.size() > 0) {
	%>
	<table class="article-reply-list" border=5>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>내용</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<%
				for (int i = 0; i < articleReplies.size(); i++) {
						Map<String, Object> articleReply = articleReplies.get(i);
			%>
			<tr>
				<td><%=articleReply.get("id")%></td>
				<td><%=articleReply.get("regDate").toString().substring(0, 19)%></td>
				<td>
					<div class="read-mode-visible">
						<%=articleReply.get("body")%>
					</div>
					<div class="edit-mode-visible">
						<form action="./doModifyReply.sbs">
							<input type="hidden" name="id"
								value="<%=articleReply.get("id")%>">
							<div>
								<textarea name="body"><%=articleReply.get("body")%></textarea>
							</div>
							<div>
								<input type="submit" value="댓글수정"> <input
									onclick="disableEditMode(this);" type="reset" value="수정취소">
							</div>
						</form>
					</div>
				</td>
				<td><a href="javascript:;" onclick="onclickDelete(<%=articleReply.get("id")%>)">삭제</a> 
					<a class="read-mode-visible" href="javascript:;" onclick="enableEditModepw(<%=articleReply.get("id")%>);">수정</a>
				</td>
			</tr>
			<div class="popup-reply <%=articleReply.get("id")%>">
				<form action="./doDeleteReply.sbs" method="POST">
					<div>
						<%=articleReply.get("id")%>번 댓글 삭제하실?
					</div>
					<div>
						<input type="hidden" name="id" value="<%=articleReply.get("id")%>">
					</div>
					<div>
						비번 : <input type="password" name="passwd">
					</div>
					<div>
						<button type="submit">확인</button>
						<input type="button" onclick="javascript:onclickDeleteCancel();" value="취소">
					</div>
				</form>
			</div>
			<div class="popup-modify <%=articleReply.get("id")%>">
				<form action="./doReplyModify.sbs" method="POST">
					<div>
						<%=articleReply.get("id")%>번 댓글 수정하실?
					</div>
					<div>
						<input type="hidden" name="id" value="<%=articleReply.get("id")%>">
					</div>
					<div>
						비번 : <input type="password" name="passwd">
					</div>
					<div>
						<button type="submit">확인</button>
						<input type="button" onclick="javascript:onclickDeleteCancel();" value="취소">
					</div>
				</form>
			</div>
		</tbody>
		<%
			}
		%>
	</table>
	<%
		} else {
	%>
	댓글이 없습니다.
	<%
		}
	%>
	<h3>댓글쓰기</h3>
	<form action="./doAddReply.sbs" method="POST">
		<div>
			<input type="password" name="passwd" placeholder="비번을 입력하세욤.">
		</div>
		<div>
			<input type="hidden" name="articleid" value="<%=article.get("id")%>">
		</div>
		<div>
			<textarea type="text" name="body"></textarea>
		</div>
		<div>
			<button type="submit">댓글작성</button>
			<input type="reset" value="취소">
		</div>
	</form>
</body>
</html>