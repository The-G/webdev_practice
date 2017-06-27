<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@ page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function next_month() {	// parameter 값 넘겨서 하는 방법도 있다!!!
		var f = document.myform;
		f.addmonth.value = 1;
		f.submit();
	}
	function prev_month() {
		var f = document.myform;
		f.addmonth.value = -1;
		f.submit();		
	}
	function next_year() {
		var f = document.myform;
		f.addyear.value = 1;
		f.submit();
	}
	function prev_year() {
		var f = document.myform;
		f.addyear.value = -1;
		f.submit();		
	}
</script>

</head>
<body>

<%
	int year = 0;
	int month = 0;
	int addmonth = 0;
	int addyear = 0;
	Calendar c = Calendar.getInstance();

	try{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		addmonth = Integer.parseInt(request.getParameter("addmonth"));
		addyear = Integer.parseInt(request.getParameter("addyear"));
		c.set(year + addyear, month - 1 + addmonth, 1); // Calendar에 year와 month를 넣음!!
		year = c.get(Calendar.YEAR);		// Calendar에서 다시 얻어온다.
		month = c.get(Calendar.MONTH) + 1;  // 0 부터 시작이니까!!! +1
	} catch (Exception e){
		// 년, 월의 parameter가 없을 때(가장처음)
		year = c.get(Calendar.YEAR);		// Calendar에서 다시 얻어온다.
		month = c.get(Calendar.MONTH) + 1;  // 0 부터 시작이니까!!! +1
		c.set(year, month - 1, 1);
	}
	// 맨처음 여기로 온다!!!
	// 	year = c.get(Calendar.YEAR);		// Calendar에서 다시 얻어온다.
	// 	month = c.get(Calendar.MONTH) + 1;  // 0 부터 시작이니까!!! +1


	int week = c.get(Calendar.DAY_OF_WEEK); // 1일이 몇 요일 인지
	int end_day = c.getActualMaximum(Calendar.DATE); // 몇 일 까지 있는지.
%>
<table style="width:250px">

<caption>
<form name="myform" method="post"> <!-- action이 없으면 자기자신에게 적용된다. 자기자신 page에 새로 값주고 loading -->
	<input type="hidden" name="addmonth" value="0" />
	<input type="hidden" name="addyear" value="0" />
	
	<span onclick="prev_year()" style="cursor: pointer;">◁</span>
	<span onclick="prev_month()" style="cursor: pointer;">◀</span>
	
	<select name="year" onchange="document.myform.submit()">
		<% for(int y = year-5; y <= year+5; y++) {	%>
			<option <%=year == y ? " selected " : "" %>><%=y %></option>	
		<% } %>
	</select>년
	<select name="month" onchange="document.myform.submit()">
		<% for(int m = 1; m <= 12; m++) { %>
			<option <%=month == m ? " selected " : "" %>><%=m %></option>
		<% } %>
	</select>월

	<span onclick="next_month()" style="cursor: pointer;">▶</span>
	<span onclick="next_year()" style="cursor: pointer;">▷</span>
	
</form>
</caption>

<tr>
<%
	String[] day_name = {"일","월","화","수","목","금","토"};
	for(int d = 0; d < 7; d++) {
		out.print("<td align='center'>" + day_name[d] + "</td>");
	}
%>

</tr>
<tr>
<% 
	for (int d = 1; d < week; d++) {
		out.print("<td></td>"); // 앞부분 빈칸 추가하고
	}
	for (int d = 1, w = week; d <= end_day; d++, w++) {
		printDay(out,d,w%7);
		if (w % 7 == 0) {
// 			out.print("<td style='color:blue' align='center'>" + d + "</td>"); // 일자 칸 추가
			out.println("</tr><tr>"); //줄바꿈!!
// 		} else if(w % 7 == 1){
// 			out.print("<td style='color:red' align='center'>" + d + "</td>"); // 일자 칸 추가		
// 		} else {
// 			out.print("<td align='center'>" + d + "</td>"); // 일자 칸 추가			
		}
	}
%>
</tr>
</table>

</body>
</html>

<%!public void printDay(JspWriter out, int d, int w) throws IOException {
		switch (w) {
		case 0:
			out.println("<td style='color:blue' align='center'>" + d + "</td>");
			break;
		case 1:
			out.println("<td style='color:red' align='center'>" + d + "</td>");
			break;
		default:
			out.println("<td>" + d + "</td>");
			break;

		}
	}%> 
