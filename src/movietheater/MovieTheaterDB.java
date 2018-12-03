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
					+ "(SELECT COUNT(*) FROM DBCLASS.THEATER WHERE THEATER.movie_theater_name = MOVIE_THEATER.movie_theater_name) AS theater_num, "
					+ "(SELECT COUNT(*) FROM DBCLASS.SEAT WHERE theater_id in (SELECT theater_id FROM DBCLASS.THEATER WHERE THEATER.movie_theater_name = MOVIE_THEATER.movie_theater_name)) AS seat_num "
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

	public ArrayList<TheaterBean> selectTheaterList(String movie_theater_name) {
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
					for(int j=0; j<seatBean.size(); j++) {
						String seat_name = seatBean.get(j).getSeat_name();
						sql = "INSERT INTO SEAT (theater_id, seat_name) "
								+ "VALUES ('" + theater_id + "', '" + seat_name + "')";
						isCompleted = stmt.executeUpdate(sql);
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

}
