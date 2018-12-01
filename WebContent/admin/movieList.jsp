<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movie.MovieDB" %>   
<%@ page import="movie.MovieBean" %>   
<%@ page import="java.util.ArrayList" %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie List</title>
</head>
<body>
	<b style="font-size: x-large;">영화 목록 </b> 
	<button type="button" onclick="location.href='registerMovie.jsp'">영화 등록</button>
	</br></br>
<%
	MovieDB movieDB = MovieDB.getInstance();
	ArrayList<MovieBean> movieBeans = movieDB.selectMovieList();
	for(int i=0; i<movieBeans.size(); i++) {
		String actor[] = movieBeans.get(i).getActor();
%>
		<b>제목</b>: <%=movieBeans.get(i).getTitle() %> /
		<b>감독</b>: <%=movieBeans.get(i).getDirector() %> /
		<b>등급</b>: <%=movieBeans.get(i).getRating() %> /
		<b>주요 정보</b>: <%=movieBeans.get(i).getKey_information() %> / 
		<b>출연</b>: 
<%		
		for(int j=0; j<actor.length; j++) {
%>
			<%=actor[j] %>
<%
			if(j != actor.length - 1) {
%>
				,
<%
			}
%>
<%
		}
%>	
		<form method="post" action="modifyMovie.jsp" style="display: inline;">
			<input type=text style="display: none;" name="movie_id" value="<%=movieBeans.get(i).getMovie_id() %>">
			<input type=text style="display: none;" name="title" value="<%=movieBeans.get(i).getTitle() %>">
			<input type=text style="display: none;" name="director" value="<%=movieBeans.get(i).getDirector() %>">
			<input type=text style="display: none;" name="rating" value="<%=movieBeans.get(i).getRating() %>">
			<input type=text style="display: none;" name="key_information" value="<%=movieBeans.get(i).getKey_information() %>">
<%
			for(int j=0; j<actor.length; j++) {
%>
				<input type=text style="display: none;" name="actor" value=<%=actor[j] %>>
<%
			}
%>			
			<input type="submit" value="수정">
		</form>
		<form method="post" action="deleteMovieHandler.jsp" style="display: inline;">
			<input type=text style="display: none;" name="movie_id" value=<%=movieBeans.get(i).getMovie_id() %>>
			<input type="submit" value="삭제">
		</form>
		</br></br>
<%	
	}	
%>
</body>
</html>