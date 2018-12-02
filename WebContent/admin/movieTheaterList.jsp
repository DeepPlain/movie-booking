<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movietheater.MovieTheaterDB" %>
<%@ page import="movietheater.MovieTheaterBean" %>
<%@ page import="java.util.ArrayList" %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Theater List</title>
</head>
<body>
	<b style="font-size: x-large;">영화관 목록 </b> 
	<button type="button" onclick="location.href='registerMovieTheater.jsp'">영화관 등록</button>
	</br></br>
<%
	MovieTheaterDB movieTheaterDB = MovieTheaterDB.getInstance();
	ArrayList<MovieTheaterBean> movieTheaterBeans = movieTheaterDB.selectMovieTheaterList();
	for(int i=0; i<movieTheaterBeans.size(); i++) {
%>
		<b>영화관</b>: <%=movieTheaterBeans.get(i).getMovie_theater_name() %> /
		<b>주소</b>: <%=movieTheaterBeans.get(i).getAddress() %> /
		<b>전화번호</b>: <%=movieTheaterBeans.get(i).getTelephone_number() %>

		<form method="post" action="modifyMovieTheater.jsp" style="display: inline;">
			<input type=text style="display: none;" name="movie_theater_name" value="<%=movieTheaterBeans.get(i).getMovie_theater_name() %>">
			<input type=text style="display: none;" name="address" value="<%=movieTheaterBeans.get(i).getMovie_theater_name() %>">
			<input type=text style="display: none;" name="telephone_number" value="<%=movieTheaterBeans.get(i).getTelephone_number() %>">
			<input type="submit" value="수정">
		</form>
		<form method="post" action="deleteMovieTheaterHandler.jsp" style="display: inline;">
			<input type=text style="display: none;" name="movie_teater_name" value=<%=movieTheaterBeans.get(i).getMovie_theater_name() %>>
			<input type="submit" value="삭제">
		</form>
		</br></br>
<%	
	}	
%>
</body>
</html>