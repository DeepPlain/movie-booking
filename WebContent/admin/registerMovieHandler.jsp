<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="movie.MovieDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="movie" class="movie.MovieBean" />
<jsp:setProperty name="movie" property="*" />

<%
	MovieDB movieDB = MovieDB.getInstance();
	int isCompleted = movieDB.insertMovie(movie);
	if(isCompleted == 1) {
%>
		<script>
		alert("등록이 완료되었습니다.");
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