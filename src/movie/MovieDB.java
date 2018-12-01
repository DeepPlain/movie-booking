package movie;

import java.sql.*;
import java.util.ArrayList;

import util.DBConnection;

public class MovieDB {
	private static MovieDB instance = new MovieDB();
	
	public static MovieDB getInstance() {
		return instance;
	}
	
	public int insertMovie(MovieBean movie) throws Exception {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int isCompleted = 0;
		int movie_id = 0;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false); // 트랜잭션 
			stmt = conn.createStatement();
			
			String title = movie.getTitle();
			String director = movie.getDirector();
			String rating = movie.getRating();
			String key_information = movie.getKey_information();
			String actor[] = movie.getActor();
			String sql = "INSERT INTO MOVIE (title, director, rating, key_information) "
					+ "VALUES ('" + title + "', '" + director + "', '" + rating + "', '" + key_information + "')";
			
			isCompleted = stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS); // movie_id 반환 설정
			rs = stmt.getGeneratedKeys();
			
			if(rs.next()) movie_id = rs.getInt(1);
			
			if(movie_id != 0) { // actor 삽입
				for(int i=0; i<actor.length; i++) {
					sql = "INSERT INTO ACTOR VALUES ('" + movie_id + "', '" + actor[i] + "')";
					isCompleted = stmt.executeUpdate(sql);
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
	
	public ArrayList<MovieBean> selectMovieList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MovieBean> movieBeans = new ArrayList<MovieBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT *, group_concat(name) AS actor FROM MOVIE LEFT JOIN ACTOR "
					+ "ON MOVIE.movie_id = ACTOR.movie_id "
					+ "GROUP BY MOVIE.movie_id");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MovieBean movieBean = new MovieBean();
				movieBean.setMovie_id(rs.getInt("movie_id"));
				movieBean.setTitle(rs.getString("title"));
				movieBean.setDirector(rs.getString("director"));
				movieBean.setRating(rs.getString("rating"));
				movieBean.setKey_information(rs.getString("key_information"));
				movieBean.setActor(rs.getString("actor").split(","));
				movieBeans.add(movieBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return movieBeans;
	}
	
	public int deleteMovie(int movie_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM MOVIE WHERE movie_id = ?");
			pstmt.setInt(1, movie_id);
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
	
	public int modifyMovie(int movie_id, MovieBean movie) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false); // 트랜잭션 
			
			String title = movie.getTitle();
			String director = movie.getDirector();
			String rating = movie.getRating();
			String key_information = movie.getKey_information();
			String actor[] = movie.getActor();
			pstmt = conn.prepareStatement(
					"UPDATE MOVIE SET title = ?, director = ?, rating = ?, key_information = ?"
					+ "WHERE movie_id = ?");
			pstmt.setString(1, title);
			pstmt.setString(2, director);
			pstmt.setString(3, rating);
			pstmt.setString(4, key_information);
			pstmt.setInt(5, movie_id);
			isCompleted = pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM ACTOR WHERE movie_id = ?");
			pstmt.setInt(1, movie_id);
			isCompleted = pstmt.executeUpdate();
			
			for(int i=0; i<actor.length; i++) {
				String sql = "INSERT INTO ACTOR VALUES ('" + movie_id + "', '" + actor[i] + "')";
				pstmt = conn.prepareStatement(
						"INSERT INTO ACTOR VALUES (?, ?)");
				pstmt.setInt(1, movie_id);
				pstmt.setString(2, actor[i]);
				isCompleted = pstmt.executeUpdate();
			}

			conn.commit(); // 모든 sql문 완료되면 커밋
			conn.setAutoCommit(true); // 트랜잭션
			
		} catch(Exception ex) {
			ex.printStackTrace();
			conn.rollback(); // 에러 시 롤백
			return 0;
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return isCompleted;
	}

}
