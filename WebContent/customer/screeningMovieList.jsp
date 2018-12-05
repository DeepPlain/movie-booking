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
	</br></br>
<%
	ScreeningMovieDB screeningMovieDB = ScreeningMovieDB.getInstance();
	ArrayList<ScreeningMovieBean> screeningMovieBeans = screeningMovieDB.selectScreeningMovieListByBookRate();
	for(int i=0; i<screeningMovieBeans.size(); i++) {
%>
		NO.<%=(i+1) %> <b>제목</b>: <%=screeningMovieBeans.get(i).getTitle() %> /
		<b>예매율</b>: <%=(int)(screeningMovieBeans.get(i).getBook_rate() * 100) %>%

		<form method="post" action="bookMovie.jsp" style="display: inline;">
			<input type=text style="display: none;" name="movie_id" value=<%=screeningMovieBeans.get(i).getMovie_id() %>>
			<input type="submit" value="예매">
		</form>
		</br></br>
<%
	}	
%>
</body>
</html>