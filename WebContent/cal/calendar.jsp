<%@ page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 노출되는 주석 --> 
<%-- 노출되지 않는 주석 --%>

<% //scriptlet, 이 html 안에 java 코드를 사용할 수 있네!!
/* 	for(int i=1; i<=3; i++) {
		out.println("hello");
	}
 */

	int year = 2017;
	int month = 6;
	
	Calendar c = Calendar.getInstance();
	c.set(year, month - 1, 1);
	int week = c.get(Calendar.DAY_OF_WEEK); // 1일이 몇 요일 인지
	int end_day = c.getActualMaximum(Calendar.DATE); // 몇 일 까지 있는지.
%>
<%= year + "년 " + month + "월 " %>	

<table>
<tr>
	<td>일</td>
	<td>월</td>
	<td>화</td>
	<td>수</td>
	<td>목</td>
	<td>금</td>
	<td>토</td>
</tr>
<tr>
<% 
	for (int d = 1; d < week; d++) {
		out.print("<td></td>"); // 앞부분 빈칸 추가하고
	}
	for (int d = 1, w = week; d <= end_day; d++, w++) {
		out.print("<td>" + d + "</td>"); // 일자 칸 추가
		if (w % 7 == 0) out.println("</tr><tr>"); //줄바꿈!!
	}
%>
</tr>
</table>

</body>
</html>
<!--  -->
