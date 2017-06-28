<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/favicon.ico" />
</head>
<body bgcolor="yellow">
<h3> [forward 액션 태그에 대한 예제] </h3>
<hr>
이 파일은 yellow.jsp입니다.
<br>
<hr>
브라우저에 나타나는 URL과 전혀 상관없는 파일입니다. <br>
<%=request.getParameter("username") %>  <!-- 수정필요!! -->
</body>
</html>