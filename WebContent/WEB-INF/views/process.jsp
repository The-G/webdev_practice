<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<img src="img/Ttat.png" />
	</div>
	<div>
		<%--=request.getAttribute("iam")--%>
		
		<%--
			String iam = (String) request.getAttribute("iam")
			out.println(iam);
		--%>
	
		${iam}! <!-- 위 두개와 동일하다!!! EL(Expression Language)표기법 -->
		
	</div>
</body>
</html>