<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="booking.BookingDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="booking" class="booking.BookingBean" />

<%
	String customer_id = (String)session.getAttribute("id");
	int screening_timetable_id = Integer.parseInt(request.getParameter("screening_timetable_id"));
	String seat_id[] = request.getParameterValues("seat_id");
	String payment_type = request.getParameter("payment_type");
	int point = Integer.parseInt(request.getParameter("point"));		
	int payment_amount = Integer.parseInt(request.getParameter("payment_amount"));
	booking.setScreening_timetable_id(screening_timetable_id);
	booking.setSeat_id(seat_id);
	booking.setPayment_type(payment_type);
	booking.setPoint(point);
	booking.setPayment_amount(payment_amount);
	BookingDB bookingDB = BookingDB.getInstance();
	
 	int isCompleted = bookingDB.insertBooking(booking, customer_id);
	if(isCompleted == 1) {
%>
 		<script>
		alert("예약이 완료되었습니다.");
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
%>