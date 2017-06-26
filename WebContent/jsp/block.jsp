<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	int global_cnt = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <%= request.getRemoteAddr() %> <!-- 접속한 사람의 ip를 뽑아준다!!! --> --%>
<!-- 연습문제 : 옆사람이 접근할 때 첫 접속은 가능 2번 접속은 차단 3번째 접속은 가능하게.. 홀수는 가능 짝수는 불가능하게!!! -->
	<h1>total : <%= global_cnt %></h1>
<%
	if(global_cnt % 2 == 0 && request.getRemoteAddr().equals("70.12.50.70")) {
		out.println("당신은 불량유저이므로 접속을 차단합니다.");
		global_cnt++;
	} else {
		out.println("당신의 아이피는" + request.getRemoteAddr() + "입니다.");		
		global_cnt++;
	}
%>

</body>
</html>