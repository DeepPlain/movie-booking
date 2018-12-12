<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movie.*" %>
<%@ page import="movietheater.*" %>
<%@ page import="java.util.ArrayList" %>

<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Screening Movie</title>
</head>
<body>
	<h2>상영 영화 등록</h2>

	<form method="post" action="registerScreeningMovieHandler.jsp">
		<b>영화</b>: 
		<select name="movie_id">
<%
		MovieDB movieDB = MovieDB.getInstance();
		ArrayList<MovieBean> movieBeans = movieDB.selectMovieList();
		for(int i=0; i<movieBeans.size(); i++) {
%>
		    <option value="<%=movieBeans.get(i).getMovie_id() %>"><%=movieBeans.get(i).getTitle() %></option>
<%
		}
%>
		</select>
		<br/>
		<b>상영관</b>: 
		<select name="theater_id">
<%
		MovieTheaterDB movieTheaterDB = MovieTheaterDB.getInstance();
		ArrayList<TheaterBean> theaterBeans = movieTheaterDB.selectTheaterList();
		for(int i=0; i<theaterBeans.size(); i++) {
%>
		    <option value="<%=theaterBeans.get(i).getTheater_id() %>"><%=theaterBeans.get(i).getMovie_theater_name() %> / <%=theaterBeans.get(i).getTheater_name() %></option>
<%
		}
%>
		</select>
		<br/>		
		<b>가격</b>: <input type="text" name="price"><br/>
		<b>시작 시간</b>: <input type="datetime-local" name="screening_date"><br/>
		<b>종료 시간</b>: <input type="datetime-local" name="end_date"><br/>
		<input type="submit" value="등록">
	</form>
</body>
<script>
	
</script>
</html>