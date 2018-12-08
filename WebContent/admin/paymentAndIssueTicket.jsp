<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="booking.*" %>     
<%@ page import="customer.*" %>
<%@ page import="java.util.ArrayList" %>
    
<% request.setCharacterEncoding("utf-8"); %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment And Issue Ticket</title>
</head>
<body>
	<b style="font-size: x-large;">현장 결제 </b> 
	</br></br>
<%
	int booking_id = Integer.parseInt(request.getParameter("booking_id"));
	String customer_id = request.getParameter("customer_id");
	int price = Integer.parseInt(request.getParameter("price"));
	int seat_num = Integer.parseInt(request.getParameter("seat_num"));
	int payment_amount = price * seat_num;
	BookingDB bookingDB = BookingDB.getInstance();
	CustomerDB customerDB = CustomerDB.getInstance();
	CustomerBean customerBean = customerDB.selectCustomer(customer_id);

%>
	<form method="post" action="paymentAndIssueTicketHandler.jsp" style="display: inline;">
		<span id="point">
			<b>포인트:</b> <input type="text" name="point" value="0" onkeyup="keyupPoint(this)" onchange="changePoint(this)"> <%=customerBean.getPoint() %>원 보유 (1000원 이상 사용 가능)
		</span>
		<br/><br/>
		<input type="text" style="display: none;" name="booking_id" value="<%=booking_id %>">
		<input type="text" style="display: none;" name="customer_id" value="<%=customer_id %>">
		<input type="text" style="display: none;" name="seat_num" value="<%=seat_num %>">
		<input type="text" style="display: none;" name="payment_amount" value="<%=payment_amount %>">
		<b>결제 금액:</b> <span id="payment_amount" value="<%=payment_amount %>"><%=payment_amount %></span>
		</br></br>
		<input type="submit" value="결제 및 티켓 발행">
	</form>
	</br></br>
		
</body>
<script>
	function keyupPoint(obj) {
		var customer_point = <%=customerBean.getPoint() %>;
		var point = obj.value;
		var payment_amount = document.getElementById("payment_amount");
		if(customer_point < point) {
			obj.value = 0;
			payment_amount.innerHTML = payment_amount.getAttribute('value');
			alert('보유 포인트보다 더 많이 사용할 수 없습니다.');
		}
		else {
			payment_amount.innerHTML = payment_amount.getAttribute('value') - point;
		}
	}
	
	function changePoint(obj) {
		var customer_point = <%=customerBean.getPoint() %>;
		var point = obj.value;
		var payment_amount = document.getElementById("payment_amount");
		if(point < 1000) {
			obj.value = 0;
			payment_amount.innerHTML = payment_amount.getAttribute('value');
			alert('1000포인트 이상 사용 가능합니다.');
		}
	}
</script>
</html>