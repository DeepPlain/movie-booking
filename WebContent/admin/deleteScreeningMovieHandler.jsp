<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="screeningmovie.ScreeningMovieDB" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	int screening_timetable_id = Integer.parseInt(request.getParameter("screening_timetable_id"));
	ScreeningMovieDB screeningMovieDB = ScreeningMovieDB.getInstance();
	int isCompleted = screeningMovieDB.deleteScreeningMovie(screening_timetable_id);
	if(isCompleted == 1) {
%>
		<script>
		alert("삭제가 완료되었습니다.");
		location.href = "screeningMovieList.jsp";
		</script>
<% 
	}
	else {
%>
		<script>
		alert("오류가 발생했습니다.");
		location.href = "screeningMovieList.jsp";
		</script>
<% 		
	}
%>