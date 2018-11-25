<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="java.sql.*" %> 
<%@ page import="customer.CustomerDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="customer" class="customer.CustomerBean" />
<jsp:setProperty name="customer" property="id" value="<%=request.getParameter(\"id\") %>" />
<jsp:setProperty name="customer" property="password" value="<%=request.getParameter(\"password\") %>" />
<jsp:setProperty name="customer" property="name" value="<%=request.getParameter(\"name\") %>" />
<jsp:setProperty name="customer" property="date_of_birth" value="<%=Timestamp.valueOf(request.getParameter(\"date_of_birth\") + \" 00:00:00\") %>" />
<jsp:setProperty name="customer" property="address" value="<%=request.getParameter(\"address\") %>" />
<jsp:setProperty name="customer" property="phone_number" value="<%=request.getParameter(\"phone_number\") %>" />

<%
 	CustomerDB customerDB = CustomerDB.getInstance();
	customerDB.insertCustomer(customer);
%>


<jsp:getProperty property="id" name="customer"/>님 회원가입을 축하합니다.