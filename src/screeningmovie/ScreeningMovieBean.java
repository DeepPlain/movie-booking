package screeningmovie;

import java.sql.*;

public class ScreeningMovieBean {
	private int screening_timetable_id;
	private String title;
	private int movie_id;
	private int theater_id;
	private String movie_theater_name;
	private String theater_name;
	private int price;
	private Timestamp screening_date;
	
	public int getScreening_timetable_id() {
		return screening_timetable_id;
	}
	public void setScreening_timetable_id(int screening_timetable_id) {
		this.screening_timetable_id = screening_timetable_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}
	public int getTheater_id() {
		return theater_id;
	}
	public void setTheater_id(int theater_id) {
		this.theater_id = theater_id;
	}
	public String getMovie_theater_name() {
		return movie_theater_name;
	}
	public void setMovie_theater_name(String movie_theater_name) {
		this.movie_theater_name = movie_theater_name;
	}
	public String getTheater_name() {
		return theater_name;
	}
	public void setTheater_name(String theater_name) {
		this.theater_name = theater_name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Timestamp getScreening_date() {
		return screening_date;
	}
	public void setScreening_date(Timestamp screening_date) {
		this.screening_date = screening_date;
	}
}
