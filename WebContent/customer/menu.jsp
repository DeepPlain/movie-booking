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
		<button type="button" onclick="location.href='screeningMovieList.jsp'">영화 차트 검색</button>
		<button type="button" onclick="location.href='bookingList.jsp'">예약 확인</button>
		<button type="button" onclick="location.href='modifyCustomer.jsp'">회원 정보 수정</button>
		<input type="submit" value="로그아웃">
	</form>
</body>
</html>