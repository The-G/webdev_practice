<%@page import="board.model.BoardDAO"%>
<%@page import="board.model.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	String pwd = request.getParameter("pwd");
	String title = request.getParameter("title");

	BoardVO boardVO = new BoardVO();
	boardVO.setName(name);
	boardVO.setContent(content);
	boardVO.setTitle(title);
	boardVO.setPwd(pwd);

	BoardDAO boardDAO = BoardDAO.getInstance();
	boolean result = boardDAO.insertBoard(boardVO);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/favicon.ico" />
</head>
<body>

	<script type="text/javascript">
		<% if(result) { %>
			alert('글 등록 성공');
			location.href='list.jsp';
		<% } else { %>
			alert('글 등록 실패');
			location.href='javascript:history.back();' // 이렇게 넘기면 글이 그대로 남아 있는다!!
		<% } %>
	</script>

</body>
</html>