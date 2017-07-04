<%@page import="board.model.BoardDAO"%>
<%@page import="board.model.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	long no = Long.parseLong(request.getParameter("no"));
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	String pwd = request.getParameter("pwd");
	String title = request.getParameter("title");

	BoardVO boardVO = new BoardVO();
	boardVO.setNo(no);
	boardVO.setName(name);
	boardVO.setContent(content);
	boardVO.setTitle(title);
	boardVO.setPwd(pwd);
	
	BoardDAO boardDAO = BoardDAO.getInstance();
 	boolean result = boardDAO.updateBoard(boardVO);
	
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
			alert('글 수정 성공');
			location.href='content.jsp?no=<%=boardVO.getNo()%>';
		<% } else { %>
			alert('비밀번호를 확인해 주세요!!');
			location.href='javascript:history.back();' // 이렇게 넘기면 글이 그대로 남아 있는다!!
		<% } %>
	</script>

</body>
</html>