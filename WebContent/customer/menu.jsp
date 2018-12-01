<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="sessionCheck.jsp" flush="false"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Menu</title>
</head>
<body>
	<b><%=session.getAttribute("id") %></b>님 환영합니다.
	<form method="post" action="../common/logOut.jsp">
		<button type="button" onclick="location.href='signUp.jsp'">영화 목록</button>
		<button type="button" onclick="location.href='signUp.jsp'">예약 목록</button>
		<button type="button" onclick="location.href='signUp.jsp'">정보 수정</button>
		<button type="button" onclick="location.href='signUp.jsp'">회원 탈퇴</button>
		<input type="submit" value="로그아웃">
	</form>
</body>
</html>