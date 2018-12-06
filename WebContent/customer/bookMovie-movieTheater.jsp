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
<title>Book Movie - Movie Theater</title>
</head>
<body>
	<b style="font-size: x-large;">영화 예약 (영화관 선택) </b> 
	</br></br>
<%
	int movie_id = Integer.parseInt(request.getParameter("movie_id"));
	ScreeningMovieDB screeningMovieDB = ScreeningMovieDB.getInstance();
	ArrayList<ScreeningMovieBean> screeningMovieBeans = screeningMovieDB.selectMovieTheaterByMovieId(movie_id);
	for(int i=0; i<screeningMovieBeans.size(); i++) {
%>
		<%=screeningMovieBeans.get(i).getMovie_theater_name() %> 

		<form method="post" action="bookMovie-screeningDate.jsp" style="display: inline;">
			<input type=text style="display: none;" name="movie_id" value="<%=movie_id %>">
			<input type=text style="display: none;" name="movie_theater_name" value="<%=screeningMovieBeans.get(i).getMovie_theater_name() %>">
			<input type="submit" value="선택">
		</form>
		</br></br>
<%
	}	
%>
</body>
</html>