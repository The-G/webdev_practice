<%@page import="java.util.InputMismatchException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	public String comment(String play) {
		return play + "가 하고 싶어요!!";
	}
%>
<%	
	String play = request.getParameter("play");
	try {
		if(!(play.equals("야구") || 
			 play.equals("농구") || 
			 play.equals("축구"))){
			throw new InputMismatchException();
		}
	
	} catch (Exception e){
		response.sendRedirect("form.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(want.css);
</style>
</head>
<body>
<div id="want"><img src="want.png" width="60%" /></div>
<div class="say"><h3><%=comment(play)%></h3></div>
</body>
</html>