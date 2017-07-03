<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.setAttribute("msg1", "안녕하세요~");	
	session.setAttribute("msg2", "실수란 신을 용서하는 인간의 행위이다");
	session.setMaxInactiveInterval(10);
	response.sendRedirect("session_status.jsp");
%>