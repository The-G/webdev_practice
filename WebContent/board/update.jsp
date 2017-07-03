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
	<form action="update_action.jsp" method="post">
		<table>
			<caption><h1>게시물 수정</h1></caption>
			<tr>
				<th>글 번호</th>
				<td><input type="hidden" name="no" value="<%= boardVO.getNo()%>"/></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="name" value="<%=boardVO.getName() %>" /></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title"  value="<%=boardVO.getTitle()%>" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea cols="40" rows="5" name="content" ><%=boardVO.getContent()%></textarea></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd" />
					<span style="color:red">
						<strong>
						* 처음 글 등록시 비밀번호를 재입력 *
						</strong>
					</span>
				</td>
			</tr>
		</table>
		<input type="submit" value="완료" />
	</form>
	<a href="list.jsp">리스트</a>
</body>
</html>