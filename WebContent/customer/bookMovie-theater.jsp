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
<title>Book Movie - Theater</title>
</head>
<body>
	<b style="font-size: x-large;">영화 예약 (상영관 선택) </b> 
	</br></br>
<%
	int movie_id = Integer.parseInt(request.getParameter("movie_id"));
	String movie_theater_name = request.getParameter("movie_theater_name");
	Timestamp screening_date = Timestamp.valueOf(request.getParameter("screening_date"));
	ScreeningMovieDB screeningMovieDB = ScreeningMovieDB.getInstance();
	ArrayList<ScreeningMovieBean> screeningMovieBeans = screeningMovieDB.selectTheaterByScreeningDate(movie_id, movie_theater_name, screening_date);
	for(int i=0; i<screeningMovieBeans.size(); i++) {
%>
		<%=screeningMovieBeans.get(i).getTheater_name() %> 

		<form method="post" action="bookMovie-screeningTime.jsp" style="display: inline;">
			<input type=text style="display: none;" name="movie_id" value="<%=movie_id %>">
			<input type=text style="display: none;" name="screening_date" value="<%=screening_date %>">
			<input type=text style="display: none;" name="theater_id" value="<%=screeningMovieBeans.get(i).getTheater_id() %>">
			<input type="submit" value="선택">
		</form>
		</br></br>
<%
	}	
%>
</body>
</html>