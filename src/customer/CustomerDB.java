package customer;

import java.sql.*;
import util.DBConnection;

public class CustomerDB {

	private static CustomerDB instance = new CustomerDB();
	
	public static CustomerDB getInstance() {
		return instance;
	}
	
	public int insertCustomer(CustomerBean customer) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"INSERT INTO CUSTOMER VALUES (?, ?, ?, ?, ?, ?, 0)");
			pstmt.setString(1, customer.getId());
			pstmt.setString(2, customer.getPassword());
			pstmt.setString(3, customer.getName());
			pstmt.setTimestamp(4, customer.getDate_of_birth());
			pstmt.setString(5, customer.getAddress());
			pstmt.setString(6, customer.getPhone_number());
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
	
	public int selectCustomerByIdAndPw(String id, String password) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT * FROM CUSTOMER WHERE customer_id = ? AND password = ?");
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				isCompleted = 1;
			}
		} catch(Exception ex) {
			ex.printStackTrace();
			return 0;
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return isCompleted;
	}
	
}
