<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<h2>회원가입</h2>

	<form method="post" action="insertMemberPro.jsp">
		아이디 : <input type="text" name="id" maxlength="20"><br/>
		비밀번호 : <input type="password" name="password" maxlength="20"><br/>
		이름 : <input type="text" name="name" maxlength="10"><br/>
		생년월일 : <input type="date" name="date_of_birth"><br/>
		주소 : <input type="text" name="address" maxlength="255"><br/>
		전화번호 : <input type="text" name="phone_number" maxlength="11" placeholder="01033331111"><br/>
		<input type="submit" value="회원가입">
	</form>
</body>
</html>