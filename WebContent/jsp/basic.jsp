<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
	// request, response, out, session
	for(int i=1; i <= 5; i++) {
		out.println(i + ":<br/>");
	}
%>
 
</body>
</html>