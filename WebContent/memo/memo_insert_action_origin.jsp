<%@page import="memo.model.MemoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String name = request.getParameter("name");
	
	MemoVO memo_vo = new MemoVO();
	memo_vo.setName(name);
	memo_vo.setTitle(title);
	memo_vo.setContent(content);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/favicon.ico" />
</head>
<body>

<%=memo_vo %>

</body>
</html>