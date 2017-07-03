<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
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
	
	
	Connection cn = null;
	PreparedStatement ps = null;
	
	boolean result = false;
	
	StringBuffer sql = new StringBuffer();
	sql.append(" UPDATE tb_board SET");
	sql.append(" 		title = ?, name=?, content=?");
	sql.append(" WHERE  no=? AND pwd=?");
	
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		cn = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe","bigdata","bigdata");
		ps = cn.prepareStatement(sql.toString());
		ps.setString(1, boardVO.getTitle());
		ps.setString(2, boardVO.getName());
		ps.setString(3, boardVO.getContent());
		ps.setLong(4, boardVO.getNo());
		ps.setString(5, boardVO.getPwd());
		
		if (ps.executeUpdate() > 0) {
			result = true;
		} // 잘 수행 되었으면, 비밀번호도 맞으면 true(1) 이 반환되니까!!
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
			alert('글 수정 성공');
			location.href='content.jsp?no=<%=boardVO.getNo()%>';
		<% } else { %>
			alert('비밀번호를 확인해 주세요!!');
			location.href='javascript:history.back();' // 이렇게 넘기면 글이 그대로 남아 있는다!!
		<% } %>
	</script>

</body>
</html>