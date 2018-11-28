<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="adminSessionCheck.jsp" flush="false"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Menu</title>
</head>
<body>
	<b><%=session.getAttribute("id") %></b>님 환영합니다.
	<form method="post" action="logOut.jsp">
		<input type="button" value="영화 등록" onClick="location.href='registerMovie.jsp'">
		<input type="button" value="영화 검색" onClick="location.href='adminSignUp.jsp'">
		<input type="button" value="영화 수정" onClick="location.href='adminSignUp.jsp'">
		<input type="button" value="영화관 등록" onClick="location.href='adminSignUp.jsp'">
		<input type="button" value="영화 티켓 발권" onClick="location.href='adminSignUp.jsp'">
		<input type="button" value="VIP 회원 관리" onClick="location.href='adminSignUp.jsp'">
		<input type="button" value="관리자 등록" onClick="location.href='adminSignUp.jsp'">
		<input type="submit" value="로그아웃">
	</form>
</body>
</html>