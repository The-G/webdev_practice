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
<%
	RequestDispatcher dispatcher = 
		request.getRequestDispatcher("../quiz02/calendar.jsp");
	dispatcher.forward(request, response);

%>

</body>
</html>