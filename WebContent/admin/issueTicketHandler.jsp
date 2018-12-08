<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="booking.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	int booking_id = Integer.parseInt(request.getParameter("booking_id"));
	BookingDB bookingDB = BookingDB.getInstance();
	int isCompleted = bookingDB.modifyTicketIssueStatus(booking_id);
	if(isCompleted == 1) {
%>
		<script>
		alert("티켓 발행이 완료되었습니다.");
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