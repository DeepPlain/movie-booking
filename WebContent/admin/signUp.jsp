<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Sign Up</title>
</head>
<body>
	<h2>관리자 등록</h2>

	<form method="post" action="signUpHandler.jsp">
		아이디 : <input type="text" name="id" maxlength="20"><br/>
		비밀번호 : <input type="password" name="password" maxlength="20"><br/>
		<input type="submit" value="관리자 등록">
	</form>
</body>
</html>