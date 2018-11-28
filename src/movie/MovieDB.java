package movie;

import java.sql.*;

import util.DBConnection;

public class MovieDB {
	private static MovieDB instance = new MovieDB();
	
	public static MovieDB getInstance() {
		return instance;
	}
	
	public int insertMovie(MovieBean movie, String actor[]) throws Exception {
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
			String sql = "insert into MOVIE (title, director, rating, key_information) "
					+ "values ('" + title + "', '" + director + "', '" + rating + "', '" + key_information + "')";
			
			isCompleted = stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS); // movie_id 반환 설정
			rs = stmt.getGeneratedKeys();
			
			if(rs.next()) movie_id = rs.getInt(1);
			
			if(movie_id != 0) { // actor 삽입
				for(int i=0; i<actor.length; i++) {
					sql = "insert into ACTOR values ('" + movie_id + "', '" + actor[i] + "')";
					isCompleted = stmt.executeUpdate(sql);
				}
			}
			conn.commit(); // 모든 sql문 완료되면 커밋
			conn.setAutoCommit(true); // 트랜잭션
			
		} catch(Exception ex) {
			ex.printStackTrace();
			conn.rollback(); // 에러 시 롤백
		} finally {
			if(stmt != null) try {stmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return isCompleted;
	}

}
