<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>     
<%@ page import="admin.AdminDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
 	AdminDB adminDB = AdminDB.getInstance();
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	boolean isCorrected = adminDB.selectAdminByIdAndPw(id, password);
	if(isCorrected) {
		session.setAttribute("type", "admin");
		session.setAttribute("id", id);
		response.sendRedirect("adminMenu.jsp");
	}
	else {
%>
		<script>
		alert("아이디 또는 비밀번호를 확인해주세요.");
		history.go(-1);
		</script>
<% 
	}
%>

