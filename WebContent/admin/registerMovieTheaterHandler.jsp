<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="movietheater.*" %>
<%@ page import="java.util.ArrayList" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="movieTheater" class="movietheater.MovieTheaterBean" />
<jsp:setProperty name="movieTheater" property="*" />

<%
	/* 좌석, 상영관 데이터 SET 및 영화관 객체에 삽입 */
	ArrayList<TheaterBean> theaterBeans = new ArrayList<TheaterBean>();
	String theater[] = request.getParameterValues("theater");
	if(theater != null) {
		for(int i=0; i<theater.length; i++) {
			ArrayList<SeatBean> seatBeans = new ArrayList<SeatBean>();
			String seat[] = request.getParameterValues("seat" + (i+1));
			if(seat != null) {
				for(int j=0; j<seat.length; j++) {
					SeatBean seatBean = new SeatBean();
					seatBean.setSeat_name(seat[j]);
					seatBeans.add(seatBean);
				}
			}
			TheaterBean theaterBean = new TheaterBean();
			theaterBean.setTheater_name(theater[i]);
			theaterBean.setSeatBean(seatBeans);
			theaterBeans.add(theaterBean);
		}
	}
	movieTheater.setTheaterBean(theaterBeans);
	/* 좌석, 상영관 데이터 SET 및 영화관 객체에 삽입 */
	
	MovieTheaterDB movieTheaterDB = MovieTheaterDB.getInstance();
	int isCompleted = movieTheaterDB.insertMovieTheater(movieTheater);
	if(isCompleted == 1) {
%>
		<script>
		alert("등록이 완료되었습니다.");
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