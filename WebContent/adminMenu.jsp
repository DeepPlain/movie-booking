<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String type = (String)session.getAttribute("type");
	String id = (String)session.getAttribute("id");
	if(type != "admin" || id == null || id.equals("")) {
%>
		<script>
		alert("로그인이 필요합니다.");
		location.href="home.jsp";
		</script>
<%
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Menu</title>
</head>
<body>
	<b><%=id %></b>님 환영합니다.
	<form method="post" action="logOut.jsp">
		<input type="button" value="관리자 등록" onClick="location.href='adminSignUp.jsp'">
		<input type="submit" value="로그아웃">
	</form>
</body>
</html>