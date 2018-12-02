package movietheater;

import java.sql.*;
import java.util.ArrayList;

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
					"SELECT * FROM MOVIE_THEATER");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MovieTheaterBean movieTheaterBean = new MovieTheaterBean();
				movieTheaterBean.setMovie_theater_name(rs.getString("movie_theater_name"));
				movieTheaterBean.setAddress(rs.getString("address"));
				movieTheaterBean.setTelephone_number(rs.getString("telephone_number"));
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

}
