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
<form action="09_actionTagTest.jsp">
	아이디 : 		<input type="text" name="userID"> <br>
	암 &nbsp; 호 : 	<input type="password" name="userPWD"> <br>
	<input type="radio" name="loginCheck" value="user" checked> 사용자
	<input type="radio" name="loginCheck" value="manager" checked> 관리자 <br>
	<input type="submit" value="로그인" >
</form>
</body>
</html>