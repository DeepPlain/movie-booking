<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="movietheater.MovieTheaterDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	String movie_theater_name = request.getParameter("movie_theater_name");
	MovieTheaterDB movieTheaterDB = MovieTheaterDB.getInstance();
	int isCompleted = movieTheaterDB.deleteMovieTheater(movie_theater_name);
	if(isCompleted == 1) {
%>
		<script>
		alert("삭제가 완료되었습니다.");
		location.href = "movieTheaterList.jsp";
		</script>
<% 
	}
	else {
%>
		<script>
		alert("오류가 발생했습니다.");
		location.href = "movieTheaterList.jsp";
		</script>
<% 		
	}
%>