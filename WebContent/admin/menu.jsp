<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>

<jsp:include page="sessionCheck.jsp" flush="false"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Menu</title>
</head>
<body>
<%
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	
	String end_date = sf.format(now);

	String start_date = sf.format(new Date(now.getTime() - (60*60*24*1000*7)));
%>
	<b><%=session.getAttribute("id") %></b>님 환영합니다.
	<form method="post" action="../common/logOut.jsp">
		<button type="button" onclick="location.href='movieList.jsp'">영화 정보 관리</button>
		<button type="button" onclick="location.href='movieTheaterList.jsp'">영화관 정보 관리</button>
		<button type="button" onclick="location.href='screeningMovieList.jsp'">상영 영화 정보 관리</button>
		<button type="button" onclick="location.href='issueTicket.jsp'">영화 티켓 발행</button>
		<button type="button" onclick="location.href='vipList.jsp?start_date=<%=start_date %>&end_date=<%=end_date %>'">VIP 고객 관리</button>
		<button type="button" onclick="location.href='signUp.jsp'">관리자 등록</button>
		<input type="submit" value="로그아웃">
	</form>
</body>
</html>