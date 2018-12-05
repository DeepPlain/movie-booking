<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="customer.CustomerDB" %>

<jsp:include page="sessionCheck.jsp" flush="false"/>

<% request.setCharacterEncoding("utf-8"); %>

<%
	String customer_id = (String)session.getAttribute("id");
	CustomerDB customerDB = CustomerDB.getInstance();
	int isCompleted = customerDB.deleteCustomer(customer_id);
	if(isCompleted == 1) {
		session.invalidate();
%>
		<script>
		alert("탈퇴가 완료되었습니다.");
		location.href = "../home.jsp";
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
%>