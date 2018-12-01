<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="movie.MovieDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="movie" class="movie.MovieBean" />
<jsp:setProperty name="movie" property="*" />

<%
	int movie_id = Integer.parseInt(request.getParameter("movie_id"));
	MovieDB movieDB = MovieDB.getInstance();
	int isCompleted = movieDB.modifyMovie(movie_id, movie);
	if(isCompleted == 1) {
%>
		<script>
		alert("수정이 완료되었습니다.");
		location.href = "movieList.jsp";
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