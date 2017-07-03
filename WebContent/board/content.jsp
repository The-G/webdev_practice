<%@page import="java.sql.DriverManager"%>
<%@page import="board.model.BoardVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	long no = Long.parseLong(request.getParameter("no"));
	
	Connection cn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	StringBuffer sql = new StringBuffer();
	sql.append(" select no, name, title, content, regdate, viewcount");
	sql.append(" from TB_BOARD");
	sql.append(" where no = ?");
	
	BoardVO boardVO = null;

	try {
		Class.forName("oracle.jdbc.OracleDriver");
		cn = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe","bigdata","bigdata");
		ps = cn.prepareStatement(sql.toString());
		ps.setLong(1, no);
		rs = ps.executeQuery();
		if (rs.next()) {
			boardVO = new BoardVO();
			boardVO.setNo(rs.getLong("no"));
			boardVO.setName(rs.getString("name"));
			boardVO.setTitle(rs.getString("title"));
			boardVO.setContent(rs.getString("content"));
			boardVO.setViewcount(rs.getInt("viewcount"));
			boardVO.setRegdate(rs.getDate("regdate"));
		}
		
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try{rs.close();} catch(Exception e){}
		if (ps != null) try{rs.close();} catch(Exception e){}
		if (cn != null) try{rs.close();} catch(Exception e){}
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
	<caption>게시물 상세보기</caption>
<tr>
	<th>글번호</th>
	<td><%=boardVO.getNo() %></td>
</tr>
<tr>
	<th>작성자</th>
	<td><%=boardVO.getName() %></td>
</tr>
<tr>
	<th>제목</th>
	<td><%=boardVO.getTitle() %></td>
</tr>
<tr>
	<th>내용</th>
	<td><%=boardVO.getContent() %></td>
</tr>
<tr>
	<th>날짜</th>
	<td><%=boardVO.getRegdate() %></td>
</tr>
<tr>
	<th>조회수</th>
	<td><%=boardVO.getViewcount() %></td>
</tr>
</table><br/>
<a href="list.jsp">리스트</a>
<a href="update.jsp?no=<%=boardVO.getNo()%>">수정</a>
<a href="delete.jsp?no=<%=boardVO.getNo()%>">삭제</a>
</form>
</body>
</html>