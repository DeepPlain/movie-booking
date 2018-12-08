<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="booking.*" %>      
<%@ page import="java.util.ArrayList" %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Issue Ticket</title>
</head>
<body>
	<b style="font-size: x-large;">티켓 발행 </b>
	<br/>
	<input type="text" id="customer_id" placeholder="ID"> 
	<button type="button" onclick="search()">예매 내역 검색</button>
	</br></br>
<%
	String customer_id = request.getParameter("customer_id");
	if(customer_id != null) {
		BookingDB bookingDB = BookingDB.getInstance();
		ArrayList<BookingBean> bookingBeans = bookingDB.selectBookingListById(customer_id);
		for(int i=0; i<bookingBeans.size(); i++) {
%>				
			<%=(i+1) %>. <b>제목</b>: <%=bookingBeans.get(i).getTitle() %> /
			<b>영화관</b>: <%=bookingBeans.get(i).getMovie_theater_name() %> /
			<b>상영관</b>: <%=bookingBeans.get(i).getTheater_name() %> /
			<b>좌석</b>: <%=bookingBeans.get(i).getSeat_name().replace(",", ", ") %> /
			<b>가격(1장)</b>: <%=bookingBeans.get(i).getPrice() %> /
			<b>상영 시간</b>: <%=bookingBeans.get(i).getScreening_date() %> /
			<b>예약일</b>: <%=bookingBeans.get(i).getBooking_date() %> /
			<b>결제 유형</b>: <%=bookingBeans.get(i).getPayment_type() %> /
			<b>결제 여부</b>: 
<%
			if(bookingBeans.get(i).getPayment_id() != 0) {
				%>true / 
				<b>사용 포인트</b>: <%=bookingBeans.get(i).getPoint() %> / 
				<b>결제 금액</b>: <%=bookingBeans.get(i).getPayment_amount() %> / 
				<b>결제일</b>: <%=bookingBeans.get(i).getPayment_date() %> / 
<%
			}
			else {
				%>false / <%
			}
%>
			<b>티켓 발행 여부</b>: <%=bookingBeans.get(i).isTicket_issue_status() %>

<%
			if(!bookingBeans.get(i).isTicket_issue_status()) {
				if(bookingBeans.get(i).getPayment_id() != 0) {
%>
					<form method="post" action="issueTicketHandler.jsp" style="display: inline;">
						<input type=text style="display: none;" name="booking_id" value="<%=bookingBeans.get(i).getBooking_id() %>">
						<input type="submit" value="티켓 발행">
					</form>
					</br></br>
<%		
				}
				else {
%>
					<form method="post" action="paymentAndIssueTicket.jsp" style="display: inline;">
						<input type=text style="display: none;" name="booking_id" value="<%=bookingBeans.get(i).getBooking_id() %>">
						<input type=text style="display: none;" name="customer_id" value="<%=customer_id %>">
						<input type=text style="display: none;" name="price" value="<%=bookingBeans.get(i).getPrice() %>">
						<input type=text style="display: none;" name="seat_num" value="<%=bookingBeans.get(i).getSeat_name().split(",").length %>">
						<input type="submit" value="현장 결제 후 티켓 발행">
					</form>
					</br></br>
<%		
				}
			}
			else {
%>
				</br></br>
<%
			}
		}	
	}
%>

<script>
	function search() {
		var customer_id = document.getElementById('customer_id').value;
		location.replace('issueTicket.jsp?customer_id=' + customer_id);
	}
</script>
</body>
</html>