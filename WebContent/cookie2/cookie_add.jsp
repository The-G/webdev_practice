<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_id = request.getParameter("user_id");
	String user_name = request.getParameter("user_name");
	int user_level = Integer.parseInt(request.getParameter("user_level"));

	Cookie c1 = new Cookie("user_id", URLEncoder.encode(user_id, "UTF-8"));
	c1.setMaxAge(60);
	response.addCookie(c1);
	
	Cookie c2 = new Cookie("user_name", URLEncoder.encode(user_name, "UTF-8"));
	c2.setMaxAge(60);
	response.addCookie(c2);
	
	Cookie c3 = new Cookie("user_level", URLEncoder.encode(user_level+"", "UTF-8"));
	c3.setMaxAge(60);
	response.addCookie(c3);
	response.sendRedirect("cookie_status.jsp");
%>
