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
	String msg1 = (String) session.getAttribute("msg1");
	String msg2 = (String) session.getAttribute("msg2");
%>
msg 1 : <%=msg1 %><br/>
msg 2 : <%=msg2 %><br/>
<a href="session_add.jsp">세션생성</a>
</body>
</html>