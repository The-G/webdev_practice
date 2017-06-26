<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="process.jsp" method="post"> <!-- get, post 다 되네!! -->
		<p>이름 : <input type="text" name="name" autofocus="autofocus" value="루피"/></p>
		<p>나이 : <input type="number" name="age" value="28" /></p>  <!-- 웹에서 전달되는 parameter 값은 무조건 문자열 -->
		<input type="submit" value="확인" /> 
	</form>
</body>
</html>