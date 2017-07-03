<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/favicon.ico" />

</head>
<body>
<a href="member_page.jsp">회원 페이지 가기</a><br>
놀아라~~<br>
<% if (session.getAttribute("user_id") == null) { %>
	<a href="session_form.jsp">로그인하기!</a>
<% } else { %>
	<a href="session_invalidate.jsp">로그아웃하기!</a>
<% } %>

</body>
</html>