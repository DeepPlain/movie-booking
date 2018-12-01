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
	int isCompleted = customerDB.insertCustomer(customer);
	if(isCompleted == 1) {
%>
		<script>
		alert("회원가입이 완료되었습니다.");
		location.href = "signIn.jsp";
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