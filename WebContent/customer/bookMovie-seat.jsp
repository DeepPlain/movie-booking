<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movietheater.*" %>      
<%@ page import="java.util.ArrayList" %>
    
<% request.setCharacterEncoding("utf-8"); %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Movie - Seat</title>
</head>
<body>
<%
	int theater_id = Integer.parseInt(request.getParameter("theater_id"));
	int screening_timetable_id = Integer.parseInt(request.getParameter("screening_timetable_id"));
	MovieTheaterDB movieTheaterDB = MovieTheaterDB.getInstance();
	String seat_num = movieTheaterDB.selectSeatNum(theater_id, screening_timetable_id);	
%>
	<b style="font-size: x-large;">영화 예약 (좌석 선택) <%=seat_num %> </b> 
	</br></br>
<%
	ArrayList<SeatBean> seatBeans = movieTheaterDB.selectSeatByScreeningTimetableId(theater_id, screening_timetable_id);
	for(int i=0; i<seatBeans.size(); i++) {
%>
		<%=seatBeans.get(i).getSeat_name() %> 

		<form method="post" action="bookMovie-payment.jsp" style="display: inline;">
			<input type=text style="display: none;" name="seat_id" value="<%=seatBeans.get(i).getSeat_id() %>">
			<input type=text style="display: none;" name="screening_timetable_id" value="<%=screening_timetable_id %>">
			<input type="submit" value="선택">
		</form>
		</br></br>
<%
	}	
%>
</body>
</html>