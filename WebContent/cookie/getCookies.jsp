<%@page import="java.net.URLDecoder"%>
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
		Cookie[] cookies = request.getCookies();

		for (Cookie c : cookies) { 
			out.println("Domain : " + c.getDomain() + "<br/>");
			out.println("Path : " + c.getPath() + "<br/>");
			out.println("Version : " + c.getVersion() + "<br/>");
			out.println(c.getName() + " : " + URLDecoder.decode(c.getValue(),"UTF-8") + "<br/>");
			out.println(c.getMaxAge());
			out.println("<hr/>");
		}
	%>
</body>
</html>