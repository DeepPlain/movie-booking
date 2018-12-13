<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="customer.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIP List</title>
</head>
<body>
<%
	String start_date = request.getParameter("start_date");
	String end_date = request.getParameter("end_date");
%>
	<b style="font-size: x-large;">VIP 목록 </b>
	<br/> 
	<input type="date" id="start_date" value="<%=start_date %>"> ~ <input type="date" id="end_date" value="<%=end_date %>">
	<button type="button" onclick="search()">검색</button>
	</br></br>
<%
	CustomerDB customerDB = CustomerDB.getInstance();
	ArrayList<CustomerBean> customerBeans = customerDB.selectVIPList(Timestamp.valueOf(start_date + " 00:00:00"), Timestamp.valueOf(end_date + " 23:59:59"));
	for(int i=0; i<customerBeans.size(); i++) {
%>
		No.<%=(i+1) %> <b>ID</b>: <%=customerBeans.get(i).getId() %> /
		<b>이름</b>: <%=customerBeans.get(i).getName() %> /
		<b>생년월일</b>: <%=customerBeans.get(i).getDate_of_birth() %> /
		<b>주소</b>: <%=customerBeans.get(i).getAddress() %> /
		<b>전화번호</b>: <%=customerBeans.get(i).getPhone_number() %> /
		<b>포인트</b>: <%=customerBeans.get(i).getPoint() %> /
		<b>예매 횟수</b>: <%=customerBeans.get(i).getBooking_num() %>
		<br/><br/>
<%
	}
%>	
<script>
	function search() {
		var start_date = document.getElementById('start_date').value;
		var end_date = document.getElementById('end_date').value;
		location.replace('vipList.jsp?start_date=' + start_date + '&end_date=' + end_date);
	}
</script>
</body>
</html>