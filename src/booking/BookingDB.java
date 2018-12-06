package booking;

import java.sql.*;
import java.util.ArrayList;

import util.DBConnection;

public class BookingDB {
private static BookingDB instance = new BookingDB();
	
	public static BookingDB getInstance() {
		return instance;
	}
	
	public ArrayList<BookingBean> selectBookingListById(String customer_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BookingBean> bookingBeans = new ArrayList<BookingBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT * FROM DBCLASS.BOOKING "
					+ "LEFT JOIN DBCLASS.SCREENING_TIMETABLE "
					+ "ON BOOKING.screening_timetable_id = SCREENING_TIMETABLE.screening_timetable_id "
					+ "LEFT JOIN DBCLASS.MOVIE "
					+ "ON SCREENING_TIMETABLE.movie_id = MOVIE.movie_id "
					+ "LEFT JOIN DBCLASS.THEATER "
					+ "ON SCREENING_TIMETABLE.theater_id = THEATER.theater_id "
					+ "LEFT JOIN DBCLASS.SEAT "
					+ "ON BOOKING.seat_id = SEAT.seat_id "
					+ "WHERE customer_id = ?");
			pstmt.setString(1, customer_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BookingBean bookingBean = new BookingBean();
				bookingBean.setBooking_id(rs.getInt("booking_id"));
				bookingBean.setTitle(rs.getString("title"));
				bookingBean.setMovie_theater_name(rs.getString("movie_theater_name"));
				bookingBean.setTheater_name(rs.getString("theater_name"));
				bookingBean.setSeat_name(rs.getString("seat_name"));
				bookingBean.setPrice(rs.getInt("price"));
				bookingBean.setScreening_date(rs.getTimestamp("screening_date"));
				bookingBean.setBooking_date(rs.getTimestamp("booking_date"));
				bookingBean.setPayment_type(rs.getString("payment_type"));
				bookingBean.setPayment_status(rs.getBoolean("payment_status"));
				bookingBean.setTicket_issue_status(rs.getBoolean("ticket_issue_status"));
				bookingBeans.add(bookingBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return bookingBeans;
	}
	
	public int deleteBooking(int booking_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM BOOKING WHERE booking_id = ?");
			pstmt.setInt(1, booking_id);
			isCompleted = pstmt.executeUpdate();
			
		} catch(Exception ex) {
			ex.printStackTrace();
			return 0;
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return isCompleted;
	}

}
