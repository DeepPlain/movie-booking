<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Sign In</title>
</head>
<body>
	<form method="post" action="customerSignInHandler.jsp">
		아이디 : <input type="text" name="id" maxlength="20"><br/>
		비밀번호 : <input type="password" name="password" maxlength="20"><br/>
		<input type="submit" value="로그인">
		<input type="button" value="회원가입" onClick="location.href='signUp.jsp'">
	</form>
</body>
</html>