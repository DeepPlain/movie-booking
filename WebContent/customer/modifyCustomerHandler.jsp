<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="customer.*" %>
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="customer" class="customer.CustomerBean" />
<jsp:setProperty name="customer" property="password" value="<%=request.getParameter(\"password\") %>" />
<jsp:setProperty name="customer" property="name" value="<%=request.getParameter(\"name\") %>" />
<jsp:setProperty name="customer" property="date_of_birth" value="<%=Timestamp.valueOf(request.getParameter(\"date_of_birth\") + \" 00:00:00\") %>" />
<jsp:setProperty name="customer" property="address" value="<%=request.getParameter(\"address\") %>" />
<jsp:setProperty name="customer" property="phone_number" value="<%=request.getParameter(\"phone_number\") %>" />

<%
	String customer_id = (String)session.getAttribute("id");
	CustomerDB customerDB = CustomerDB.getInstance();
	CustomerBean customerBean = customerDB.selectCustomer(customer_id);
	if(customerBean.getPassword().equals(request.getParameter("originalPassword"))) {
		int isCompleted = customerDB.modifyCustomer(customer_id, customer);
		if(isCompleted == 1) {
%>
			<script>
			alert("수정이 완료되었습니다.");
			location.href = "menu.jsp";
			</script>
<% 
		}
		else {
%>
			<script>
			alert("오류가 발생했습니다.");
			location.href = "menu.jsp";
			</script>
<% 		
		}
	}
	else {
%>
		<script>
		alert("비밀번호를 정확히 입력해주세요.");
		location.href = "modifyCustomer.jsp";
		</script>
<% 			
	}
%>