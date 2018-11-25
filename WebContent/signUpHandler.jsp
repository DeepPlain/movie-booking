<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="java.sql.*" %> 
<%@ page import="customer.CustomerDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="customer" class="customer.CustomerBean" />
<jsp:setProperty name="customer" property="*" />

<%
	CustomerDB customerDB = CustomerDB.getInstance();
	customerDB.insertCustomer(customer);
%>

<jsp:getProperty property="id" name="customer"/>님 회원가입을 축하합니다.