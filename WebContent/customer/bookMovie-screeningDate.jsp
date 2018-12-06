<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="screeningmovie.*" %>      
<%@ page import="java.util.ArrayList" %>
    
<% request.setCharacterEncoding("utf-8"); %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Movie - Screening Date</title>
</head>
<body>
	<b style="font-size: x-large;">영화 예약 (날짜 선택) </b> 
	</br></br>
<%
	int movie_id = Integer.parseInt(request.getParameter("movie_id"));
	String movie_theater_name = request.getParameter("movie_theater_name");
	ScreeningMovieDB screeningMovieDB = ScreeningMovieDB.getInstance();
	ArrayList<ScreeningMovieBean> screeningMovieBeans = screeningMovieDB.selectScreeningDateByMovieTheaterName(movie_id, movie_theater_name);
	for(int i=0; i<screeningMovieBeans.size(); i++) {
%>
		<%=screeningMovieBeans.get(i).getScreening_date().toString().split(" ")[0] %> 

		<form method="post" action="bookMovie-theater.jsp" style="display: inline;">
			<input type=text style="display: none;" name="movie_id" value="<%=movie_id %>">
			<input type=text style="display: none;" name="movie_theater_name" value="<%=movie_theater_name %>">
			<input type=text style="display: none;" name="screening_date" value="<%=screeningMovieBeans.get(i).getScreening_date() %>">
			<input type="submit" value="선택">
		</form>
		</br></br>
<%
	}	
%>
</body>
</html>