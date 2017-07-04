<%@page import="board.model.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="javax.swing.border.Border"%>
<%@page import="board.model.BoardVO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%

	long pg = 1;		// 현재 페이지!!
	try {
		pg = Long.parseLong(request.getParameter("pg"));
	} catch(NumberFormatException e) {
		
	}
	
	int pageSize = 10;		// 한 페이지에 출력할 게시물 수 
	long startnum = (pg - 1) * pageSize + 1;	// 출력페이지 시작번호
	long endnum = pg * pageSize;				// 출력페이지 끝번호
	long totalCount = 0;						// 전체 페이지 수
	long pageCount = 0;							// 전체 게시물 수
	long blockSize = 10;											// 한 페이지에 출력할 페이지 수
	long startPage = ((pg-1) / blockSize) * blockSize +1;			// 페이지 블럭 시작 페이지
	long endPage = ((pg-1) / blockSize) * blockSize + blockSize;	// 페이지 블럭 끝 페이지
	
	BoardDAO boardDAO = BoardDAO.getInstance();
	totalCount =  boardDAO.getTotalCount();						   // 전체 게시물 개수 조회
	List<BoardVO> list = boardDAO.getBoardList(startnum, endnum);  // 현재페이지에 출력할 게시물을 조회
	
	pageCount = totalCount / pageSize; // 전체 페이지 수
	if (totalCount % pageSize != 0) {
		pageCount++;
	}
	if (pageCount < endPage) {
		endPage = pageCount;
	}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/favicon.ico" />
</head>
<body>
<table>
	<caption>게시물 리스트</caption>
<tr>
	<th>번호</th>
	<th>작성자</th>
	<th>제목</th>
	<th>작성일</th>
	<th>조회수</th>
</tr>
<%for(BoardVO boardVO : list){ %>	
<tr>
	<td><%= boardVO.getNo() %></td>
	<td><%= boardVO.getName() %></td>
	<td><a href="content.jsp?no=<%= boardVO.getNo() %>"><%= boardVO.getTitle() %></a></td>
	<td><%= boardVO.getRegdate() %></td>
	<td><%= boardVO.getViewcount() %></td>
</tr>
<% } %>
<tr>
	<td><a href="list.jsp">First</a></td>
	<td>
<!-- 	ex) 43 이면 40~49 까지 뽑을 거다!! -->
<!-- 	x값 버림 한것 시작, x값 올림한 것 - 1을 해서 pagination에 뿌림!! -->
		<% if(startPage == 1) {%>
			Prev
		<% } else { %>
			<a href="list.jsp?pg=<%=startPage-1%>">Prev</a>
		<% } %>
		
		<% for(long p=startPage; p <= endPage; p++){ %>
			<% if(pg == p) { %>
				<strong><%=p%></strong>
			<% } else { %>
				<a href="list.jsp?pg=<%=p%>"><%=p%></a>			
			<% } %>
		<% } %>
		
		<% if(endPage == pageCount) { %>
			Next
		<% } else { %>
			<a href="list.jsp?pg=<%=endPage+1%>">Next</a>
		<% } %>
	</td>
	<td><a href="list.jsp?pg=<%=pageCount%>">Last</a></td>
</tr>

</table><br/>

<div>
	<a href="insert.jsp">글쓰기</a><br/>
</div>
</body>
</html>