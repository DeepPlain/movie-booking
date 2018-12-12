<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="screeningmovie.ScreeningMovieDB" %>
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="screeningMovie" class="screeningmovie.ScreeningMovieBean" />
 
<jsp:setProperty name="screeningMovie" property="movie_id" value="<%=Integer.parseInt(request.getParameter(\"movie_id\")) %>" />
<jsp:setProperty name="screeningMovie" property="theater_id" value="<%=Integer.parseInt(request.getParameter(\"theater_id\")) %>" />
<jsp:setProperty name="screeningMovie" property="price" value="<%=Integer.parseInt(request.getParameter(\"price\")) %>" />
<jsp:setProperty name="screeningMovie" property="screening_date" value="<%=Timestamp.valueOf(request.getParameter(\"screening_date\").replace(\"T\", \" \") + \":00\") %>" />
<jsp:setProperty name="screeningMovie" property="end_date" value="<%=Timestamp.valueOf(request.getParameter(\"end_date\").replace(\"T\", \" \") + \":00\") %>" />

<%
	ScreeningMovieDB screeningMovieDB = ScreeningMovieDB.getInstance();
	int isCompleted = screeningMovieDB.insertScreeningMovie(screeningMovie);
	if(isCompleted == 1) {
%>
		<script>
		alert("등록이 완료되었습니다.");
		location.href = "screeningMovieList.jsp";
		</script>
<% 
	}
	else if(isCompleted == 2) {
%>
		<script>
		alert("해당 상영관에 이미 다른 영화가 상영 예정입니다.");
		location.href = "screeningMovieList.jsp";
		</script>
<% 		
	}
	else if(isCompleted == 3) {
%>
		<script>
		alert("영화 시간이 겹쳐 등록할 수 없습니다.");
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