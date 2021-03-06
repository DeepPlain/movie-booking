<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>     
<%@ page import="customer.CustomerDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="customer" class="customer.CustomerBean" />
<jsp:setProperty name="customer" property="*" />

<%
 	CustomerDB customerDB = CustomerDB.getInstance();
	int isCompleted = customerDB.selectCustomerByIdAndPw(customer.getId(), customer.getPassword());
	if(isCompleted == 1) {
		session.setAttribute("type", "customer");
		session.setAttribute("id", customer.getId());
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

