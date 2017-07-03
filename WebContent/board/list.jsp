<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="javax.swing.border.Border"%>
<%@page import="board.model.BoardVO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%

	long pg = 1;		// 현재 페이지!!
	try {
		pg = Long.parseLong(request.getParameter("pg"));
	} catch(Exception e) {
		
	}

	Connection cn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String sql_total_count = " select count(no) as cnt from tb_board";
	
	
	StringBuffer sql = new StringBuffer();
	sql.append(" select B.*");
	sql.append(" from (select rownum AS rnum, A.*");
	sql.append("       from (select no, title, name, regdate, viewcount");
	sql.append("             from tb_board");
	sql.append("             order by no desc) A) B");
	sql.append(" where rnum between ? and ?");

	int pageSize = 10;		// 한 페이지에 출력할 게시물 수 
	long startnum = (pg - 1) * pageSize + 1;	// 출력페이지 시작번호
	long endnum = pg * pageSize;				// 출력페이지 끝번호
	long totalCount = 0;						// 전체 페이지 수
	long pageCount = 0;							// 전체 게시물 수
	
	List<BoardVO> list = new ArrayList<BoardVO>();
	try{
		Class.forName("oracle.jdbc.OracleDriver");
		cn = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe","bigdata","bigdata");
		
		ps = cn.prepareStatement(sql_total_count);
		rs = ps.executeQuery();
		
		if (rs.next()) {
			totalCount = rs.getLong("cnt");		
		}
		pageCount = totalCount / pageSize; // 전체 페이지 수
		if (totalCount % pageSize != 0) {
			pageCount++;
		}
		
		ps = cn.prepareStatement(sql.toString());
		ps.setLong(1, startnum);
		ps.setLong(2, endnum);
		
		rs = ps.executeQuery();
		while(rs.next()) { // 맨 윗줄은 빈줄이라고 하네, 그래서 next가 있으면 계속 돌아감!!
			BoardVO boardVO = new BoardVO();
			boardVO.setNo(rs.getLong("no"));
			boardVO.setName(rs.getString("name"));
			boardVO.setTitle(rs.getString("title"));
			boardVO.setRegdate(rs.getDate("regdate"));
			boardVO.setViewcount(rs.getInt("viewcount"));
			
			list.add(boardVO);			
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if (rs !=null) try{rs.close();} catch(Exception e) {}
		if (ps !=null) try{rs.close();} catch(Exception e) {}
		if (cn !=null) try{rs.close();} catch(Exception e) {}
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
	
		<% for(long p=(pg/10)*10-1; p <= (pg/10)*10+10; p++){ %>
			<% if(pg == p) { %>
				<a href="list.jsp?pg=<%=p %>"><strong><%=p %></strong></a>
			<% } else if(p <= 0 || p > pageCount) { %>
			
			<% } else { %>
				<a href="list.jsp?pg=<%=p %>"><%=p %></a>			
			<% } %>
		<% } %>
	</td>
	<td><a href="list.jsp?pg=<%=pageCount%>">Last</a></td>
</tr>

</table><br/>

<!-- 그냥 생각 없이 짠 코드 ↓ -->
<!-- <div> -->
<%-- 	<% for(long i = pg-4; i <= pg+4; i++){ %> --%>
<%-- 		<% if(pg == i){ %> --%>
<%-- 			<a href="list.jsp?pg=<%=i%>"><strong><%=i%></strong></a> --%>
<%-- 		<% } else if (i <= 0) { %> --%>
		
<%-- 		<% } else { %> --%>
<%-- 			<a href="list.jsp?pg=<%=i%>"><%=i%></a>		 --%>
<%-- 		<% } %> --%>
<%-- 	<% } %> --%>
<!-- </div> -->



<div>
	<a href="insert.jsp">글쓰기</a><br/>
</div>
</body>
</html>