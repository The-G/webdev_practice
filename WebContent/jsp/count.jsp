<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	int global_cnt = 1; //session 닫고 실행해도 계속 저장되어 있네!!! 
						//공유가 된다!!
%>

<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int local_cnt = 0;

	out.print("<br> local_cnt : ");
	out.print(++local_cnt);
	
	out.print("<br> global_cnt : ");
	out.print(++global_cnt);
	
%>
</body>
</html>