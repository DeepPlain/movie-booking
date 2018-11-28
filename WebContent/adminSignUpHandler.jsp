<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="admin.AdminDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="admin" class="admin.AdminBean" />
<jsp:setProperty name="admin" property="id" value="<%=request.getParameter(\"id\") %>" />
<jsp:setProperty name="admin" property="password" value="<%=request.getParameter(\"password\") %>" />

<%
 	AdminDB adminDB = AdminDB.getInstance();
	int isCompleted = adminDB.insertAdmin(admin);
	if(isCompleted == 1) {
%>
		<script>
		alert("관리자 등록이 완료되었습니다.");
		location.href = "adminMenu.jsp";
		</script>
<% 
	}
	else {
%>
		<script>
		alert("중복된 아이디가 이미 있거나 오류가 발생했습니다.");
		history.go(-1);
		</script>
<% 
	}
%>