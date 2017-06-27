<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id="pinkIU";
	String pwd="1234";
// 	String name="아이유";
	String name=URLEncoder.encode("아이유","UTF-8");
	
	
	String user_id = request.getParameter("id");
	String pw = request.getParameter("pwd");
	
// 	request.setCharacterEncoding("UTF-8");
	if(id.equals(user_id) && pwd.equals(pw))
	{
		response.sendRedirect("04_main.jsp?name=" + name);		
	}
	else
	{
		out.print("<script> alert('아이디나 비밀번호가 잘못 되었습니다!!!'); javascript:history.back(); </script>");
// 		response.sendRedirect("04_loginForm.jsp");
	}
	
%>