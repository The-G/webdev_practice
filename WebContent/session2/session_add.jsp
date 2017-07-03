<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_id = request.getParameter("user_id").trim();
	String user_name = request.getParameter("user_name").trim();
	
	if(user_id.equals("") || user_name.equals("")){
		request.setAttribute("msg", "아이디와 이름은 꼭 입력해야 합니다..");
		request.setAttribute("url", request.getContextPath() + "/session2/session_form.jsp");
		RequestDispatcher dispatcher = 
				request.getRequestDispatcher("/result.jsp");
		dispatcher.forward(request, response);
		return; // 더이상 실행 안하고 끝
	}
	
	session.setAttribute("user_id", request.getParameter("user_id"));
	session.setAttribute("user_name", request.getParameter("user_name"));
	session.setAttribute("user_level", request.getParameter("user_level"));
	response.sendRedirect("main.jsp");
%>
