package movietheater;

import java.sql.*;
import java.util.ArrayList;

import movietheater.MovieTheaterBean;
import util.DBConnection;

public class MovieTheaterDB {
	private static MovieTheaterDB instance = new MovieTheaterDB();
	
	public static MovieTheaterDB getInstance() {
		return instance;
	}

	public ArrayList<MovieTheaterBean> selectMovieTheaterList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MovieTheaterBean> movieTheaterBeans = new ArrayList<MovieTheaterBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT *,"
					+ "(SELECT COUNT(*) FROM THEATER WHERE THEATER.movie_theater_name = MOVIE_THEATER.movie_theater_name) AS theater_num, "
					+ "(SELECT COUNT(*) FROM SEAT WHERE theater_id in "
					+ "(SELECT theater_id FROM THEATER WHERE THEATER.movie_theater_name = MOVIE_THEATER.movie_theater_name)) AS seat_num "
					+ "FROM MOVIE_THEATER");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MovieTheaterBean movieTheaterBean = new MovieTheaterBean();
				movieTheaterBean.setMovie_theater_name(rs.getString("movie_theater_name"));
				movieTheaterBean.setAddress(rs.getString("address"));
				movieTheaterBean.setTelephone_number(rs.getString("telephone_number"));
				movieTheaterBean.setTheater_num(rs.getInt("theater_num"));
				movieTheaterBean.setSeat_num(rs.getInt("seat_num"));
				movieTheaterBeans.add(movieTheaterBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return movieTheaterBeans;
	}
	
	public ArrayList<TheaterBean> selectTheaterList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<TheaterBean> theaterBeans = new ArrayList<TheaterBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT * FROM THEATER");
						
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				TheaterBean theaterBean = new TheaterBean();
				theaterBean.setTheater_id(rs.getInt("theater_id"));
				theaterBean.setMovie_theater_name(rs.getString("movie_theater_name"));
				theaterBean.setTheater_name(rs.getString("theater_name"));
				theaterBeans.add(theaterBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return theaterBeans;
	}
	
	public ArrayList<TheaterBean> selectTheaterAndSeatList(String movie_theater_name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<TheaterBean> theaterBeans = new ArrayList<TheaterBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT *, GROUP_CONCAT(seat_id) AS seat_id_list, GROUP_CONCAT(seat_name) AS seat_name_list "
					+ "FROM THEATER "
					+ "LEFT JOIN SEAT "
					+ "ON THEATER.theater_id = SEAT.theater_id "
					+ "WHERE movie_theater_name = ? "
					+ "GROUP BY theater_name");
			pstmt.setString(1, movie_theater_name);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {				
				ArrayList<SeatBean> seatBeans = new ArrayList<SeatBean>();
				String seat_id_list[] = rs.getString("seat_id_list").split(",");
				String seat_name_list[] = rs.getString("seat_name_list").split(",");
				for(int i=0; i<seat_id_list.length; i++) {
					SeatBean seatBean = new SeatBean();
					seatBean.setSeat_id(Integer.parseInt(seat_id_list[i]));
					seatBean.setSeat_name(seat_name_list[i]);
					seatBeans.add(seatBean);
				}
				TheaterBean theaterBean = new TheaterBean();
				theaterBean.setTheater_id(rs.getInt("theater_id"));
				theaterBean.setTheater_name(rs.getString("theater_name"));
				theaterBean.setSeatBean(seatBeans);

				theaterBeans.add(theaterBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return theaterBeans;
	}
	
	public ArrayList<SeatBean> selectSeatByScreeningTimetableId(int theater_id, int screening_timetable_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<SeatBean> seatBeans = new ArrayList<SeatBean>();
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(
					"SELECT * "
					+ "FROM SEAT WHERE theater_id = ? AND seat_id not in "
					+ "(SELECT seat_id FROM BOOKED_SEAT WHERE booking_id in (SELECT booking_id FROM BOOKING WHERE screening_timetable_id = ?))");
			pstmt.setInt(1, theater_id);
			pstmt.setInt(2, screening_timetable_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SeatBean seatBean = new SeatBean();
				seatBean.setSeat_id(rs.getInt("seat_id"));
				seatBean.setSeat_name(rs.getString("seat_name"));
				seatBeans.add(seatBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return seatBeans;
	}
	
	public String selectSeatNum(int theater_id, int screening_timetable_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String seat_num = null;
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(
					"SELECT *, COUNT(*) AS left_seat_num, "
					+ "(SELECT COUNT(*) FROM SEAT WHERE theater_id = ?) AS total_seat_num "
					+ "FROM SEAT WHERE theater_id = ? AND seat_id not in "
					+ "(SELECT seat_id FROM BOOKED_SEAT WHERE booking_id in (SELECT booking_id FROM BOOKING WHERE screening_timetable_id = ?))");
			pstmt.setInt(1, theater_id);
			pstmt.setInt(2, theater_id);
			pstmt.setInt(3, screening_timetable_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int left_seat_num = rs.getInt("left_seat_num");
				int total_seat_num = rs.getInt("total_seat_num");
				seat_num = String.valueOf(left_seat_num) + " / " + String.valueOf(total_seat_num);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return seat_num;
	}
		
	public int insertMovieTheater(MovieTheaterBean movieTheater) throws Exception {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false); // 트랜잭션 
			stmt = conn.createStatement();
			
			String movie_theater_name = movieTheater.getMovie_theater_name();
			String address = movieTheater.getAddress();
			String telephone_number = movieTheater.getTelephone_number();
			ArrayList<TheaterBean> theaterBean = movieTheater.getTheaterBean();
			String sql = "INSERT INTO MOVIE_THEATER (movie_theater_name, address, telephone_number) "
					+ "VALUES ('" + movie_theater_name + "', '" + address + "', '" + telephone_number + "')";
			
			isCompleted = stmt.executeUpdate(sql);
			
			if(theaterBean != null) {
				for(int i=0; i<theaterBean.size(); i++) {
					int theater_id = 0;
					String theater_name = theaterBean.get(i).getTheater_name();
					sql = "INSERT INTO THEATER (movie_theater_name, theater_name) "
							+ "VALUES ('" + movie_theater_name + "', '" + theater_name + "')";
					isCompleted = stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS); // theater_id 반환 설정
					rs = stmt.getGeneratedKeys();

					if(rs.next()) theater_id = rs.getInt(1);
					
					if(theater_id != 0) { // seat 삽입
						ArrayList<SeatBean> seatBean = theaterBean.get(i).getSeatBean();
						if(seatBean != null) {
							for(int j=0; j<seatBean.size(); j++) {
								String seat_name = seatBean.get(j).getSeat_name();
								sql = "INSERT INTO SEAT (theater_id, seat_name) "
										+ "VALUES ('" + theater_id + "', '" + seat_name + "')";
								isCompleted = stmt.executeUpdate(sql);
							}
						}
					}
				}
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

	public int deleteMovieTheater(String movie_theater_name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM MOVIE_THEATER WHERE movie_theater_name = ?");
			pstmt.setString(1, movie_theater_name);
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
	
	public int modifyMovieTheater(String movie_theater_name, MovieTheaterBean movieTheater, 
			String[] deletedTheater, String[] deletedSeat, String[] modifiedTheater, String[] modifiedSeat) throws Exception {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false); // 트랜잭션 
			stmt = conn.createStatement();
			
			String new_movie_theater_name = movieTheater.getMovie_theater_name();
			String address = movieTheater.getAddress();
			String telephone_number = movieTheater.getTelephone_number();
			ArrayList<TheaterBean> theaterBean = movieTheater.getTheaterBean();
			
			if(deletedTheater != null) {
				for(int i=0; i<deletedTheater.length; i++) {
					String sql = "DELETE FROM THEATER WHERE theater_id = '" + deletedTheater[i] + "'";
					isCompleted = stmt.executeUpdate(sql);
				}
			}
			if(deletedSeat != null) {
				for(int i=0; i<deletedSeat.length; i++) {
					String sql = "DELETE FROM SEAT WHERE seat_id = '" + deletedSeat[i] + "'";
					isCompleted = stmt.executeUpdate(sql);
				}
			}
			if(modifiedTheater != null) {
				for(int i=0; i<modifiedTheater.length; i++) {
					String theater_id = modifiedTheater[i].split("==>>")[0];
					String theater_name = modifiedTheater[i].split("==>>")[1];
					String sql = "UPDATE THEATER SET theater_name = '" + theater_name + "' WHERE theater_id = '" + theater_id + "'";
					isCompleted = stmt.executeUpdate(sql);
				}
			}
			if(modifiedSeat != null) {
				for(int i=0; i<modifiedSeat.length; i++) {
					String theater_id = modifiedSeat[i].split("==>>")[0];
					String seat_name = modifiedSeat[i].split("==>>")[1];
					String sql = "INSERT INTO SEAT (theater_id, seat_name) "
							+ "VALUES ('" + theater_id + "', '" + seat_name + "')";
					isCompleted = stmt.executeUpdate(sql);
				}
			}
			
			if(theaterBean != null) {
				for(int i=0; i<theaterBean.size(); i++) {
					int theater_id = 0;
					String theater_name = theaterBean.get(i).getTheater_name();
					String sql = "INSERT INTO THEATER (movie_theater_name, theater_name) "
							+ "VALUES ('" + movie_theater_name + "', '" + theater_name + "')";
					isCompleted = stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS); // theater_id 반환 설정
					rs = stmt.getGeneratedKeys();

					if(rs.next()) theater_id = rs.getInt(1);
					
					if(theater_id != 0) { // seat 삽입
						ArrayList<SeatBean> seatBean = theaterBean.get(i).getSeatBean();
						if(seatBean != null) {
							for(int j=0; j<seatBean.size(); j++) {
								String seat_name = seatBean.get(j).getSeat_name();
								sql = "INSERT INTO SEAT (theater_id, seat_name) "
										+ "VALUES ('" + theater_id + "', '" + seat_name + "')";
								isCompleted = stmt.executeUpdate(sql);
							}
						}
					}
				}	
			}
			
			String sql = "UPDATE MOVIE_THEATER SET "
					+ "movie_theater_name = '" + new_movie_theater_name + "', "
					+ "address = '" + address + "', "
					+ "telephone_number = '" + telephone_number + "' "
					+ "WHERE movie_theater_name = '" + movie_theater_name + "'";			
			isCompleted = stmt.executeUpdate(sql);
			
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


}
