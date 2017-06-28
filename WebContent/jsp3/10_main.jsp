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
<%@ include file="10_header.jsp" %>

메인 화면 입니다. <br>
<a href="10_sub.jsp"> 서브 페이지로 이동 </a>
<%-- <jsp:include page="10_footer.jsp" /> --%>
<!-- 위 두개의 차이점은, 위방법 java로 변환되는 과정에서 합쳐져서 저장된다. 그러니 변수같은 것도 공유되지!!, 파일이 무거워 지겠지. -->
<!-- 아래 방법은, footer와 header가 따로 생기고, main 파일에서도 동적으로 불러다 쓰기만 한다. 모듈화 된거다!! 이게 action tag 
	 변수 공유 안된다. 다른페이지게 변수 값 넘기듯이 해야 한다!! 
-->
<%@ include file="10_footer.jsp" %>
</body>
</html>