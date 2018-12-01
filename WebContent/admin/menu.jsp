<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="sessionCheck.jsp" flush="false"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Menu</title>
</head>
<body>
	<b><%=session.getAttribute("id") %></b>님 환영합니다.
	<form method="post" action="../common/logOut.jsp">
		<button type="button" onclick="location.href='movieList.jsp'">영화 목록 관리</button>
		<button type="button" onclick="location.href='movieTheaterList.jsp'">영화관 목록 관리</button>
		<button type="button" onclick="location.href='signUp.jsp'">영화 티켓 발행</button>
		<button type="button" onclick="location.href='signUp.jsp'">VIP 고객 관리</button>
		<button type="button" onclick="location.href='signUp.jsp'">관리자 등록</button>
		<input type="submit" value="로그아웃">
	</form>
</body>
</html>