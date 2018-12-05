<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="movietheater.*" %>
<%@ page import="java.util.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="movieTheater" class="movietheater.MovieTheaterBean" />
<jsp:setProperty name="movieTheater" property="*" />

<%
	String movie_theater_name = request.getParameter("movie_theater_name").split("==>>")[1];
	String new_movie_theater_name = request.getParameter(request.getParameter("movie_theater_name"));
	movieTheater.setMovie_theater_name(new_movie_theater_name);

	/* 기존 상영관, 좌석 삭제 */
	String deletedTheater[] = request.getParameterValues("deletedTheater");
	String deletedSeat[] = request.getParameterValues("deletedSeat");
	/* 기존 상영관, 좌석 삭제 */
	
	/* 기존 상영관, 좌석 수정(추가) */
	String modifiedTheater[] = request.getParameterValues("modifiedTheater");
	if(modifiedTheater != null) {
		for(int i=0; i<modifiedTheater.length; i++) {
			String theater_id = modifiedTheater[i].split("==>>")[1];
			String theater_name = request.getParameter(modifiedTheater[i]);
			modifiedTheater[i] = theater_id + "==>>" + theater_name;
		}
	}

	String modifiedSeat[] = request.getParameterValues("modifiedSeat");
	if(modifiedSeat != null) {
		for(int i=0; i<modifiedSeat.length; i++) {
			String theater_id = modifiedSeat[i].split("==>>")[1];
			String seat_name = request.getParameter(modifiedSeat[i]);
			modifiedSeat[i] = theater_id + "==>>" + seat_name;
		}
	}
	/* 기존 상영관, 좌석 수정(추가) */
	
	/* 새 좌석, 상영관 데이터 SET 및 영화관 객체에 삽입 */
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
	/* 새 좌석, 상영관 데이터 SET 및 영화관 객체에 삽입 */
	
	MovieTheaterDB movieTheaterDB = MovieTheaterDB.getInstance();
	int isCompleted = movieTheaterDB.modifyMovieTheater(movie_theater_name, movieTheater, deletedTheater, deletedSeat, modifiedTheater, modifiedSeat);
	if(isCompleted == 1) {
%>
		<script>
		alert("수정이 완료되었습니다.");
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