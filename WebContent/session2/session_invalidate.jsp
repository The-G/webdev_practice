<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	session.removeAttribute("user_id"); // 이렇게 하나씩도 제거할 수 있다.
	session.invalidate(); // 한번에 다 session 지우기!
	response.sendRedirect("session_form.jsp");
%>