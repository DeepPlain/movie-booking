<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="screeningmovie.*" %>      
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
    
<% request.setCharacterEncoding("utf-8"); %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Movie - Screening Time</title>
</head>
<body>
	<b style="font-size: x-large;">영화 예약 (시간 선택) </b> 
	</br></br>
<%
	int movie_id = Integer.parseInt(request.getParameter("movie_id"));
	Timestamp screening_date = Timestamp.valueOf(request.getParameter("screening_date"));
	int theater_id = Integer.parseInt(request.getParameter("theater_id"));
	ScreeningMovieDB screeningMovieDB = ScreeningMovieDB.getInstance();
	ArrayList<ScreeningMovieBean> screeningMovieBeans = screeningMovieDB.selectScreeningTimeByTheaterId(movie_id, screening_date, theater_id);
	for(int i=0; i<screeningMovieBeans.size(); i++) {
%>
		<%=screeningMovieBeans.get(i).getScreening_date() %> ~ <%=screeningMovieBeans.get(i).getEnd_date() %>

		<form method="post" action="bookMovie-seat.jsp" style="display: inline;">
			<input type=text style="display: none;" name="theater_id" value="<%=theater_id %>">
			<input type=text style="display: none;" name="screening_timetable_id" value="<%=screeningMovieBeans.get(i).getScreening_timetable_id() %>">
			<input type="submit" value="선택">
		</form>
		</br></br>
<%
	}	
%>
</body>
</html>