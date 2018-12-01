<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>     
<%@ page import="admin.AdminDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="admin" class="admin.AdminBean" />
<jsp:setProperty name="admin" property="*" />

<%
 	AdminDB adminDB = AdminDB.getInstance();
	int isCompleted = adminDB.selectAdminByIdAndPw(admin.getId(), admin.getPassword());
	if(isCompleted == 1) {
		session.setAttribute("type", "admin");
		session.setAttribute("id", admin.getId());
		response.sendRedirect("menu.jsp");
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

