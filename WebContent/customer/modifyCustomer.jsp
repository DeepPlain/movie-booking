<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="customer.*" %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Customer</title>
</head>
<body>
	<h2>회원 정보 수정</h2>
<%
	CustomerDB customerDB = CustomerDB.getInstance();
	CustomerBean customerBean = customerDB.selectCustomer((String)session.getAttribute("id"));
%>
	<form method="post" action="modifyCustomerHandler.jsp">
		현재 비밀번호 : <input type="password" name="originalPassword" maxlength="20"><br/>
		새 비밀번호 : <input type="password" name="password" maxlength="20"><br/>
		이름 : <input type="text" name="name" maxlength="10" value="<%=customerBean.getName() %>"><br/>
		생년월일 : <input type="date" name="date_of_birth" value="<%=customerBean.getDate_of_birth().toString().split(" ")[0] %>"><br/>
		주소 : <input type="text" name="address" maxlength="255" value="<%=customerBean.getAddress() %>"><br/>
		전화번호 : <input type="text" name="phone_number" maxlength="11" placeholder="01033331111" value="<%=customerBean.getPhone_number() %>"><br/>
		<input type="submit" value="정보 수정">
		<button type="button" onclick="location.href='deleteCustomerHandler.jsp'">회원 탈퇴</button>
	</form>
</body>
</html>