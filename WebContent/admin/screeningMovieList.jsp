<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="screeningmovie.*" %>      
<%@ page import="java.util.ArrayList" %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Screening Movie List</title>
</head>
<body>
	<b style="font-size: x-large;">상영 영화 목록 </b> 
	<button type="button" onclick="location.href='registerScreeningMovie.jsp'">상영 영화 등록</button>
	</br></br>
<%
	ScreeningMovieDB screeningMovieDB = ScreeningMovieDB.getInstance();
	ArrayList<ScreeningMovieBean> screeningMovieBeans = screeningMovieDB.selectScreeningMovieList();
	for(int i=0; i<screeningMovieBeans.size(); i++) {
%>
		<b>제목</b>: <%=screeningMovieBeans.get(i).getTitle() %> /
		<b>영화관</b>: <%=screeningMovieBeans.get(i).getMovie_theater_name() %> /
		<b>상영관</b>: <%=screeningMovieBeans.get(i).getTheater_name() %> /
		<b>가격</b>: <%=screeningMovieBeans.get(i).getPrice() %> / 
		<b>시간</b>: <%=screeningMovieBeans.get(i).getScreening_date() %>

		<form method="post" action="deleteScreeningMovieHandler.jsp" style="display: inline;">
			<input type=text style="display: none;" name="screening_timetable_id" value=<%=screeningMovieBeans.get(i).getScreening_timetable_id() %>>
			<input type="submit" value="삭제">
		</form>
		</br></br>
<%
	}	
%>
</body>
</html>