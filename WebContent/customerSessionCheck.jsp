<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String type = (String)session.getAttribute("type");
	String id = (String)session.getAttribute("id");
	if(type != "customer" || id == null || id.equals("")) {
%>
		<script>
		alert("로그인이 필요합니다.");
		location.href="home.jsp";
		</script>
<%
	}
%>