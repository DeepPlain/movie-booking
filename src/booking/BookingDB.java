package booking;

import java.sql.*;
import java.util.ArrayList;

import movietheater.MovieTheaterBean;
import movietheater.SeatBean;
import movietheater.TheaterBean;
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
					"SELECT *, GROUP_CONCAT(seat_name) AS seat_name_list FROM BOOKING "
					+ "LEFT JOIN SCREENING_TIMETABLE "
					+ "ON BOOKING.screening_timetable_id = SCREENING_TIMETABLE.screening_timetable_id "
					+ "LEFT JOIN MOVIE "
					+ "ON SCREENING_TIMETABLE.movie_id = MOVIE.movie_id "
					+ "LEFT JOIN THEATER "
					+ "ON SCREENING_TIMETABLE.theater_id = THEATER.theater_id "
					+ "LEFT JOIN BOOKED_SEAT "
					+ "ON BOOKING.booking_id = BOOKED_SEAT.booking_id "
					+ "LEFT JOIN SEAT "
					+ "ON BOOKED_SEAT.seat_id = SEAT.seat_id "
					+ "LEFT JOIN PAYMENT "
					+ "ON BOOKING.booking_id = PAYMENT.booking_id "
					+ "WHERE customer_id = ? "
					+ "GROUP BY BOOKING.booking_id");
			pstmt.setString(1, customer_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BookingBean bookingBean = new BookingBean();
				bookingBean.setBooking_id(rs.getInt("booking_id"));
				bookingBean.setTitle(rs.getString("title"));
				bookingBean.setMovie_theater_name(rs.getString("movie_theater_name"));
				bookingBean.setTheater_name(rs.getString("theater_name"));
				bookingBean.setSeat_name(rs.getString("seat_name_list"));
				bookingBean.setScreening_date(rs.getTimestamp("screening_date"));
				bookingBean.setBooking_date(rs.getTimestamp("booking_date"));
				bookingBean.setPayment_date(rs.getTimestamp("payment_date"));
				bookingBean.setPayment_type(rs.getString("payment_type"));
				bookingBean.setPrice(rs.getInt("price"));
				bookingBean.setPoint(rs.getInt("point"));
				bookingBean.setPayment_amount(rs.getInt("payment_amount"));
				bookingBean.setPayment_id(rs.getInt("payment_id"));
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
	
	public int insertBooking(BookingBean booking, String customer_id) throws Exception {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int isCompleted = 0;
		int booking_id = 0;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false); // 트랜잭션 
			stmt = conn.createStatement();
			
			int screening_timetable_id = booking.getScreening_timetable_id();
			String seat_id[] = booking.getSeat_id();
			String payment_type = booking.getPayment_type();
			int point = booking.getPoint();
			int payment_amount = booking.getPayment_amount();
			String sql = "INSERT INTO BOOKING (customer_id, screening_timetable_id, payment_type) "
					+ "VALUES ('" + customer_id + "', '" + screening_timetable_id + "', '" + payment_type + "')";
			
			isCompleted = stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS); // booking_id 반환 설정
			rs = stmt.getGeneratedKeys();

			if(rs.next()) booking_id = rs.getInt(1);
			
			for(int i=0; i<seat_id.length; i++) {
				sql = "INSERT INTO BOOKED_SEAT (booking_id, seat_id) "
						+ "VALUES ('" + booking_id + "', '" + seat_id[i] + "')";
				isCompleted = stmt.executeUpdate(sql);
			}
			
			if(payment_type.equals("인터넷 결제")) {
				sql = "INSERT INTO PAYMENT (booking_id, point, payment_amount) "
						+ "VALUES ('" + booking_id + "', '" + point + "', '" + (payment_amount - point) + "')";
				isCompleted = stmt.executeUpdate(sql);
				
				int newPoint = 100 * seat_id.length;
				sql = "UPDATE CUSTOMER SET point = point - '" + point + "' + '" + newPoint + "' WHERE customer_id = '" + customer_id + "'";
				isCompleted = stmt.executeUpdate(sql);
			}
						
			conn.commit(); // 모든 sql문 완료되면 커밋
			conn.setAutoCommit(true); // 트랜잭션
			
		} catch(Exception ex) {
			ex.printStackTrace();
			conn.rollback(); // 에러 시 롤백
			return 0;
		} finally {
			if(stmt != null) try {stmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return isCompleted;
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
