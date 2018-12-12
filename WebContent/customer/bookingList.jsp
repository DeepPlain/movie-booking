<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="booking.*" %>      
<%@ page import="java.util.ArrayList" %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking List</title>
</head>
<body>
	<b style="font-size: x-large;">예약 목록 </b> 
	</br></br>
<%
	BookingDB bookingDB = BookingDB.getInstance();
	ArrayList<BookingBean> bookingBeans = bookingDB.selectBookingListById((String)session.getAttribute("id"));
	for(int i=0; i<bookingBeans.size(); i++) {
%>				
		<%=(i+1) %>. <b>제목</b>: <%=bookingBeans.get(i).getTitle() %> /
		<b>영화관</b>: <%=bookingBeans.get(i).getMovie_theater_name() %> /
		<b>상영관</b>: <%=bookingBeans.get(i).getTheater_name() %> /
		<b>좌석</b>: <%=bookingBeans.get(i).getSeat_name().replace(",", ", ") %> /
		<b>가격(1장)</b>: <%=bookingBeans.get(i).getPrice() %> /
		<b>시작 시간</b>: <%=bookingBeans.get(i).getScreening_date() %> /
		<b>종료 시간</b>: <%=bookingBeans.get(i).getEnd_date() %> /
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
%>
				<form method="post" action="deleteBookingHandler.jsp" style="display: inline;">
					<input type=text style="display: none;" name="booking_id" value="<%=bookingBeans.get(i).getBooking_id() %>">
					<input type="submit" value="예약 취소">
				</form>
				</br></br>
<%
			}
			else {
%>
				</br></br>
<%
			}
	}	
%>
</body>
</html>