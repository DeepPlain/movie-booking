package booking;

import java.sql.*;

public class BookingBean {
	private int booking_id;
	private String title;
	private String movie_theater_name;
	private String theater_name;
	private String seat_name;
	private int price;
	private Timestamp screening_date;
	private Timestamp booking_date;
	private String payment_type;
	private boolean payment_status;
	private boolean ticket_issue_status;
	
	public int getBooking_id() {
		return booking_id;
	}
	public void setBooking_id(int booking_id) {
		this.booking_id = booking_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getSeat_name() {
		return seat_name;
	}
	public void setSeat_name(String seat_name) {
		this.seat_name = seat_name;
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
	public Timestamp getBooking_date() {
		return booking_date;
	}
	public void setBooking_date(Timestamp booking_date) {
		this.booking_date = booking_date;
	}
	public String getPayment_type() {
		return payment_type;
	}
	public void setPayment_type(String payment_type) {
		this.payment_type = payment_type;
	}
	public boolean isPayment_status() {
		return payment_status;
	}
	public void setPayment_status(boolean payment_status) {
		this.payment_status = payment_status;
	}
	public boolean isTicket_issue_status() {
		return ticket_issue_status;
	}
	public void setTicket_issue_status(boolean ticket_issue_status) {
		this.ticket_issue_status = ticket_issue_status;
	}
}
