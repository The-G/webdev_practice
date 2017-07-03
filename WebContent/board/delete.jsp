<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	long no = Long.parseLong(request.getParameter("no"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/favicon.ico" />
</head>
<body>
	<form action="delete_action.jsp" method="post">
		<table>
			<caption><h1>게시물 삭제</h1></caption>
			<tr>
				<th>글 번호</th>
				<td><%=no%><input type="hidden" name="no" value="<%=no%>"/></td>
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