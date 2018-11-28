<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="customerSessionCheck.jsp" flush="false"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Menu</title>
</head>
<body>
	<b><%=session.getAttribute("id") %></b>님 환영합니다.
	<form method="post" action="logOut.jsp">
		<input type="button" value="정보 수정" onClick="location.href='adminSignUp.jsp'">
		<input type="button" value="회원 탈퇴" onClick="location.href='adminSignUp.jsp'">
		<input type="button" value="영화 검색" onClick="location.href='adminSignUp.jsp'">
		<input type="button" value="영화 예약" onClick="location.href='adminSignUp.jsp'">
		<input type="button" value="영화 예약 취소" onClick="location.href='adminSignUp.jsp'">
		<input type="button" value="영화 결제" onClick="location.href='adminSignUp.jsp'">
		<input type="submit" value="로그아웃">
	</form>
</body>
</html>