<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>
<body>
<%
	Cookie idCook = (Cookie)request.getAttribute("idCook");
	Cookie pwCook = (Cookie)request.getAttribute("pwCook");
	Cookie nickCook = (Cookie)request.getAttribute("nickCook");
	Cookie nmCook = (Cookie)request.getAttribute("nmCook");
	String name = URLDecoder.decode(nmCook.getValue(),"UTF-8");
%>
<div>
	 <%=name %>님 환영합니다!
</div>
<div>
	아이디 : <%=idCook.getValue() %> 
</div>
<div>
	별명 : <%=nickCook.getValue() %>
</div>
</body>
</html>