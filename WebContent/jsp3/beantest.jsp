<%@page import="basic.exam5.Dice"%>
<%@page import="oop.exam6.Circle"%>
<%@page import="oop.exam6.Shape"%>
<%@page import="unit01.Point2D"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/favicon.ico" />
</head>
<body>
<%--
	Point2D pt = new Point2D();
	pt.setX(100);
	pt.setY(200);
--%>
<%--=pt --%>
<hr/> 
<jsp:useBean id="pt" class="unit01.Point2D"></jsp:useBean>  <!-- 이렇게 instance가 만들어 지는 거다 pt라는!! -->
<jsp:setProperty property="x" name="pt" value="1000" />
<jsp:setProperty property="y" name="pt" value="2000" />
<%=pt %>

<hr/>

<%
	Shape s = new Circle();
	s.area();
%>
<%= s.res %>
<hr/>
주사위를 굴립니다 : <%= Dice.rolling() %>
</body>
</html>