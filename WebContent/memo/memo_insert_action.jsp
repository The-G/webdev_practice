<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="memo.model.MemoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memoVO" class="memo.model.MemoVO" /> <!-- instance 생성!! -->
<jsp:setProperty name="memoVO" property="*" />
<%
	Connection cn = null;
	PreparedStatement ps = null;
	
	StringBuffer sql = new StringBuffer(); 
	sql.append(" insert into t_memo(no, name, title, content)");
	sql.append(" values(seq_memo.nextval, ?, ?, ?)");
	boolean result = false;
	
	try{
		Class.forName("oracle.jdbc.OracleDriver");
// 		out.println("드라이버로드 성공");
		cn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bigdata","bigdata");
// 		out.println("연결 성공");
		ps = cn.prepareStatement(sql.toString());
		ps.setString(1, memoVO.getName());
		ps.setString(2, memoVO.getTitle());
		ps.setString(3, memoVO.getContent());
		ps.executeUpdate(); // insert, update, delete / DML 할 때
		// UPDATE / DELETE 는 구문정상 수행이지만 0로 반환 할 수 있다.
		// if 로 result 1인지 확인도 해줘야지.. 하지만, insert에서는 필요 없다.
		result = true;
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if(ps != null) try{ps.close();} catch(Exception e){}
		if(cn != null) try{cn.close();} catch(Exception e){}
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

<%=memoVO.getNo() %>
<%=memoVO %>
<% if(result == true) { %>
메모 등록 성공		
<% } else { %>
메모 등록 실패
<% } %>

</body>
</html>