<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="admin.AdminDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
 	AdminDB adminDB = AdminDB.getInstance();
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	adminDB.insertAdmin(id, password);
%>


<%=id %>님 회원가입을 축하합니다.