<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
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
	
	
	Connection cn = null;
	PreparedStatement ps = null;
	
	boolean result = false;
	
	StringBuffer sql = new StringBuffer();
	sql.append(" INSERT INTO tb_board(no, title, name, content, pwd)");
	sql.append(" VALUES(seq_board.nextval, ?, ?, ?, ?)");
	
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		cn = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe","bigdata","bigdata");
		ps = cn.prepareStatement(sql.toString());
		ps.setString(1, boardVO.getTitle());
		ps.setString(2, boardVO.getName());
		ps.setString(3, boardVO.getContent());
		ps.setString(4, boardVO.getPwd());
	 	ps.executeUpdate();
	 	result = true;
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if (ps != null) try{ps.close();} catch(Exception e){}
		if (cn != null) try{cn.close();} catch(Exception e){}
	}
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