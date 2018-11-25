package util;

import java.sql.*;

public class DBConnection {

	public static Connection getConnection() throws Exception {
		Connection conn = null;
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/DBCLASS";
		String dbId = "root";
		String dbPass = "1111";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		return conn;
	}
}
