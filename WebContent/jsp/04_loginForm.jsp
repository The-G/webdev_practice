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
	<form name="myform" method="post" action="04_testLogin.jsp">
		<label for="userid"> 아이디 : </label>
		<input type="text" name="id" id="userid"><br>
		<label for="userpw"> 암 &nbsp; 호 : </label>
		<input type="password" name="pwd" id="userpwd"><br>
		
		<input type="button" value="로그인" onclick="input_check()" />
	</form>

<script>
	function input_check() {
		console.log('input_check 수행중')
		var f = document.myform
		console.log('userid : ' + f.id.value)	// name으로 접근
		console.log('userpw : ' + f.pwd.value)
		console.log('----------------------')
		console.log('userid : ' + document.getElementById('userid').value); // id로 접근
		console.log('userid : ' + document.getElementById('userpwd').value);

		var user_id = document.getElementById('userid').value;
		var user_pw = document.getElementById('userpwd').value;
		if (user_id.trim() === '') {
			alert('아이디를 입력하세요!!!');
			return;
		}
		if (user_pw.trim() === '') {
			alert('비밀번호를 입력하세요!!!');
			return;
		}
		f.submit();
	}
</script>
</body>
</html>