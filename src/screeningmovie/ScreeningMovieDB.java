package screeningmovie;

import java.sql.*;
import java.util.ArrayList;

import movie.MovieBean;
import movietheater.MovieTheaterBean;
import screeningmovie.ScreeningMovieBean;
import util.DBConnection;

public class ScreeningMovieDB {
	private static ScreeningMovieDB instance = new ScreeningMovieDB();
	
	public static ScreeningMovieDB getInstance() {
		return instance;
	}
	
	public ScreeningMovieBean selectScreeningMovieById(int screening_timetable_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ScreeningMovieBean screeningMovieBean = new ScreeningMovieBean();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT * FROM SCREENING_TIMETABLE "
					+ "LEFT JOIN MOVIE ON SCREENING_TIMETABLE.movie_id = MOVIE.movie_id "
					+ "LEFT JOIN THEATER ON SCREENING_TIMETABLE.theater_id = THEATER.theater_id "
					+ "WHERE screening_timetable_id = ?");
			pstmt.setInt(1, screening_timetable_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				screeningMovieBean.setTitle(rs.getString("title"));
				screeningMovieBean.setMovie_theater_name(rs.getString("movie_theater_name"));
				screeningMovieBean.setTheater_name(rs.getString("theater_name"));
				screeningMovieBean.setPrice(rs.getInt("price"));
				screeningMovieBean.setScreening_date(rs.getTimestamp("screening_date"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return screeningMovieBean;
	}
	
	public ArrayList<ScreeningMovieBean> selectScreeningMovieList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ScreeningMovieBean> screeningMovieBeans = new ArrayList<ScreeningMovieBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT * FROM SCREENING_TIMETABLE "
					+ "LEFT JOIN MOVIE ON SCREENING_TIMETABLE.movie_id = MOVIE.movie_id "
					+ "LEFT JOIN THEATER ON SCREENING_TIMETABLE.theater_id = THEATER.theater_id");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ScreeningMovieBean screeningMovieBean = new ScreeningMovieBean();
				screeningMovieBean.setScreening_timetable_id(rs.getInt("screening_timetable_id"));
				screeningMovieBean.setTitle(rs.getString("title"));
				screeningMovieBean.setMovie_theater_name(rs.getString("movie_theater_name"));
				screeningMovieBean.setTheater_name(rs.getString("theater_name"));
				screeningMovieBean.setPrice(rs.getInt("price"));
				screeningMovieBean.setScreening_date(rs.getTimestamp("screening_date"));
				screeningMovieBean.setEnd_date(rs.getTimestamp("end_date"));
				screeningMovieBeans.add(screeningMovieBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return screeningMovieBeans;
	}
	
	public ArrayList<ScreeningMovieBean> selectScreeningMovieListByBookRate() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ScreeningMovieBean> screeningMovieBeans = new ArrayList<ScreeningMovieBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"(SELECT MOVIE.movie_id, title, COUNT(*) AS book_num, "
					+ "COUNT(*) / (SELECT COUNT(*) FROM DBCLASS.BOOKED_SEAT) AS book_rate "
					+ "FROM DBCLASS.BOOKING "
					+ "LEFT JOIN DBCLASS.BOOKED_SEAT "
					+ "ON BOOKING.booking_id = BOOKED_SEAT.booking_id "
					+ "LEFT JOIN DBCLASS.SCREENING_TIMETABLE "
					+ "ON BOOKING.screening_timetable_id = SCREENING_TIMETABLE.screening_timetable_id "
					+ "LEFT JOIN DBCLASS.MOVIE "
					+ "ON SCREENING_TIMETABLE.movie_id = MOVIE.movie_id "
					+ "GROUP BY SCREENING_TIMETABLE.movie_id) "
					+ "ORDER BY book_rate DESC");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ScreeningMovieBean screeningMovieBean = new ScreeningMovieBean();
				screeningMovieBean.setTitle(rs.getString("title"));
				screeningMovieBean.setMovie_id(rs.getInt("movie_id"));
				screeningMovieBean.setBook_rate(rs.getDouble("book_rate"));
				screeningMovieBeans.add(screeningMovieBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return screeningMovieBeans;
	}

	public ArrayList<ScreeningMovieBean> selectMovieTheaterByMovieId(int movie_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ScreeningMovieBean> screeningMovieBeans = new ArrayList<ScreeningMovieBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT * FROM DBCLASS.THEATER "
					+ "WHERE theater_id in (SELECT theater_id FROM DBCLASS.SCREENING_TIMETABLE WHERE movie_id = ?) "
					+ "GROUP BY movie_theater_name");
			pstmt.setInt(1, movie_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ScreeningMovieBean screeningMovieBean = new ScreeningMovieBean();
				screeningMovieBean.setMovie_theater_name(rs.getString("movie_theater_name"));
				screeningMovieBeans.add(screeningMovieBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return screeningMovieBeans;
	}
	
	public ArrayList<ScreeningMovieBean> selectScreeningDateByMovieTheaterName(int movie_id, String movie_theater_name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ScreeningMovieBean> screeningMovieBeans = new ArrayList<ScreeningMovieBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT DATE(screening_date) AS screening_date FROM SCREENING_TIMETABLE "
					+ "WHERE movie_id = ? AND "
					+ "theater_id in (SELECT theater_id FROM THEATER WHERE movie_theater_name = ?)"
					+ "GROUP BY DATE(screening_date)");
			pstmt.setInt(1, movie_id);
			pstmt.setString(2, movie_theater_name);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ScreeningMovieBean screeningMovieBean = new ScreeningMovieBean();
				screeningMovieBean.setScreening_date(rs.getTimestamp("screening_date"));
				screeningMovieBeans.add(screeningMovieBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return screeningMovieBeans;
	}
	
	public ArrayList<ScreeningMovieBean> selectTheaterByScreeningDate(int movie_id, String movie_theater_name, Timestamp screening_date) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ScreeningMovieBean> screeningMovieBeans = new ArrayList<ScreeningMovieBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT * FROM SCREENING_TIMETABLE "
					+ "LEFT JOIN THEATER "
					+ "ON SCREENING_TIMETABLE.theater_id = THEATER.theater_id "
					+ "WHERE movie_id = ? AND "
					+ "SCREENING_TIMETABLE.theater_id in (SELECT theater_id FROM THEATER WHERE movie_theater_name = ?) AND "
					+ "DATE(screening_date) = ? "
					+ "GROUP BY SCREENING_TIMETABLE.theater_id");
			pstmt.setInt(1, movie_id);
			pstmt.setString(2, movie_theater_name);
			pstmt.setTimestamp(3, screening_date);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ScreeningMovieBean screeningMovieBean = new ScreeningMovieBean();
				screeningMovieBean.setTheater_id(rs.getInt("theater_id"));
				screeningMovieBean.setTheater_name(rs.getString("theater_name"));
				screeningMovieBeans.add(screeningMovieBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return screeningMovieBeans;
	}
	
	public ArrayList<ScreeningMovieBean> selectScreeningTimeByTheaterId(int movie_id, Timestamp screening_date, int theater_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ScreeningMovieBean> screeningMovieBeans = new ArrayList<ScreeningMovieBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT * FROM SCREENING_TIMETABLE "
					+ "WHERE movie_id = ? AND DATE(screening_date) = DATE(?) AND theater_id = ?");
			pstmt.setInt(1, movie_id);
			pstmt.setTimestamp(2, screening_date);
			pstmt.setInt(3, theater_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ScreeningMovieBean screeningMovieBean = new ScreeningMovieBean();
				screeningMovieBean.setScreening_timetable_id(rs.getInt("screening_timetable_id"));
				screeningMovieBean.setScreening_date(rs.getTimestamp("screening_date"));
				screeningMovieBean.setEnd_date(rs.getTimestamp("end_date"));
				screeningMovieBeans.add(screeningMovieBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return screeningMovieBeans;
	}
	
	public int insertScreeningMovie(ScreeningMovieBean screeningMovie) throws Exception {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			stmt = conn.createStatement();
			
			int movie_id = screeningMovie.getMovie_id();
			int theater_id = screeningMovie.getTheater_id();
			int price = screeningMovie.getPrice();
			Timestamp screening_date = screeningMovie.getScreening_date();
			Timestamp end_date = screeningMovie.getEnd_date();
			
			String sql = "SELECT * FROM SCREENING_TIMETABLE "
					+ "WHERE theater_id = '" + theater_id + "' AND DATE(screening_date) = DATE('" + screening_date + "') "
					+ "AND movie_id != '" + movie_id + "'";
			rs = stmt.executeQuery(sql);
			if(rs.next()) { // 해당 날짜, 상영관에 다른 영화가 이미 상영중인 경우
				return 2;
			}
			
			sql = "SELECT * FROM SCREENING_TIMETABLE "
					+ "WHERE theater_id = '" + theater_id + "' "
					+ "AND ('" + screening_date + "' BETWEEN screening_date AND end_date " + 
					"OR screening_date BETWEEN '" + screening_date + "' AND '" + end_date + "')";
			rs = stmt.executeQuery(sql);
			if(rs.next()) { // 상영시간이 중복되는 경우
				return 3;
			}
			
			sql = "INSERT INTO SCREENING_TIMETABLE (movie_id, theater_id, price, screening_date, end_date) "
					+ "VALUES ('" + movie_id + "', '" + theater_id + "', '" + price + "', '" + screening_date + "', '" + end_date + "')";
			
			isCompleted = stmt.executeUpdate(sql);
			
		} catch(Exception ex) {
			ex.printStackTrace();
			return 0;
		} finally {
			if(stmt != null) try {stmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return isCompleted;
	}

	public int deleteScreeningMovie(int screening_timetable_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM SCREENING_TIMETABLE WHERE screening_timetable_id = ?");
			pstmt.setInt(1, screening_timetable_id);
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
