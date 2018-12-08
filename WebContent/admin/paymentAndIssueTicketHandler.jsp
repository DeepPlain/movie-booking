<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="booking.BookingDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="booking" class="booking.BookingBean" />

<%
	int booking_id = Integer.parseInt(request.getParameter("booking_id"));
	String customer_id = request.getParameter("customer_id");
	int seat_num = Integer.parseInt(request.getParameter("seat_num"));
	int point = Integer.parseInt(request.getParameter("point"));		
	int payment_amount = Integer.parseInt(request.getParameter("payment_amount"));
	booking.setBooking_id(booking_id);
	booking.setPoint(point);
	booking.setPayment_amount(payment_amount);
	BookingDB bookingDB = BookingDB.getInstance();
	
 	int isCompleted = bookingDB.insertPaymentAndIssueTicket(booking, customer_id, seat_num);
	if(isCompleted == 1) {
%>
 		<script>
		alert("결제 및 티켓 발행이 완료되었습니다.");
		location.href = "issueTicket.jsp";
		</script>
<% 
	}
	else {
%>
		<script>
		alert("오류가 발생했습니다.");
		location.href = "issueTicket.jsp";
		</script>
<% 		
	}
%>