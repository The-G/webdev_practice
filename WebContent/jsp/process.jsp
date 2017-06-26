<%@ page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	public String commentAge(int age) { // out에 대한 exception은 따로 잡아줘야 하네!!
	   				 				  // out 객체를 넘기는 것은 안좋다. view는 한곳에서 출력하는게 좋다
		if(age < 20) {
			return("묘령");
		} else if(age <= 29) {
			return("약관");	
		} else if(age <= 39) {
			return("이립");	
		} else if(age <= 49) {
			return("불혹");
		} else if(age <= 59) {
			return("지천명");
		} else if(age <= 69) {
			return("이순");
		} else {
			return("종심");
		}
	}
%>
<%
	String name = request.getParameter("name");
// 	String age = request.getParameter("age");
	int age = Integer.parseInt(request.getParameter("age")); //이렇게 int로 받을 수도 있지만 그렇게 안한다 string으로 하지!!!
%>

<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>그래, 난 <%=name %>. 포기를 모르는 해적왕!!</h1>
나이 : <%=age %> 세( <%=commentAge(age) %>)
</body>
</html>