<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/favicon.ico" />
</head>
<body>
	<%
		Cookie c = new Cookie("id", URLEncoder.encode("신해철", "UTF-8"));
		c.setMaxAge(60 * 60 * 24);
		response.addCookie(c);

		response.addCookie(new Cookie("pwd", "test1234"));
		response.addCookie(new Cookie("age", "20"));
		response.sendRedirect("getCookies.jsp");
	%>
	<h3>쿠키 설정</h3>
	
</body>
</html>