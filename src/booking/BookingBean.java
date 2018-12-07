package booking;

import java.sql.*;

public class BookingBean {
	private int booking_id;
	private int screening_timetable_id;
	private String title;
	private String movie_theater_name;
	private String theater_name;
	private String seat_id[];
	private String seat_name;
	private Timestamp screening_date;
	private Timestamp booking_date;
	private Timestamp payment_date;
	private String payment_type;
	private int price;
	private int point;
	private int payment_amount;
	private int payment_id;
	private boolean ticket_issue_status;
	
	public int getBooking_id() {
		return booking_id;
	}
	public void setBooking_id(int booking_id) {
		this.booking_id = booking_id;
	}
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
	public String[] getSeat_id() {
		return seat_id;
	}
	public void setSeat_id(String[] seat_id) {
		this.seat_id = seat_id;
	}
	public String getSeat_name() {
		return seat_name;
	}
	public void setSeat_name(String seat_name) {
		this.seat_name = seat_name;
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
	public Timestamp getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(Timestamp payment_date) {
		this.payment_date = payment_date;
	}
	public String getPayment_type() {
		return payment_type;
	}
	public void setPayment_type(String payment_type) {
		this.payment_type = payment_type;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getPayment_amount() {
		return payment_amount;
	}
	public void setPayment_amount(int payment_amount) {
		this.payment_amount = payment_amount;
	}
	public int getPayment_id() {
		return payment_id;
	}
	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}
	public boolean isTicket_issue_status() {
		return ticket_issue_status;
	}
	public void setTicket_issue_status(boolean ticket_issue_status) {
		this.ticket_issue_status = ticket_issue_status;
	}
}
