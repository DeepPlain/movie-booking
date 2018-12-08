package customer;

import java.sql.*;
import java.util.ArrayList;

import util.DBConnection;

public class CustomerDB {

	private static CustomerDB instance = new CustomerDB();
	
	public static CustomerDB getInstance() {
		return instance;
	}
	
	public CustomerBean selectCustomer(String customer_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CustomerBean customerBean = new CustomerBean();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT * FROM CUSTOMER WHERE customer_id = ?");
			pstmt.setString(1, customer_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				customerBean.setName(rs.getString("name"));
				customerBean.setDate_of_birth(rs.getTimestamp("date_of_birth"));
				customerBean.setAddress(rs.getString("address"));
				customerBean.setPhone_number(rs.getString("phone_number"));
				customerBean.setPassword(rs.getString("password"));
				customerBean.setPoint(rs.getInt("point"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return customerBean;
	}
	
	public ArrayList<CustomerBean> selectVIPList(Timestamp start_date, Timestamp end_date) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<CustomerBean> customerBeans = new ArrayList<CustomerBean>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"SELECT *, COUNT(BOOKING.customer_id) AS booking_num "
					+ "FROM BOOKING "
					+ "LEFT JOIN CUSTOMER "
					+ "ON BOOKING.customer_id = CUSTOMER.customer_id "
					+ "WHERE ? < booking_date AND booking_date < ? "
					+ "GROUP BY BOOKING.customer_id "
					+ "ORDER BY booking_num DESC LIMIT 10");
			pstmt.setTimestamp(1, start_date);
			pstmt.setTimestamp(2, end_date);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				CustomerBean customerBean = new CustomerBean();
				customerBean.setId(rs.getString("customer_id"));
				customerBean.setName(rs.getString("name"));
				customerBean.setDate_of_birth(rs.getTimestamp("date_of_birth"));
				customerBean.setAddress(rs.getString("address"));
				customerBean.setPhone_number(rs.getString("phone_number"));
				customerBean.setPoint(rs.getInt("point"));
				customerBean.setBooking_num(rs.getInt("booking_num"));
				customerBeans.add(customerBean);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return customerBeans;
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
	
	public int deleteCustomer(String customer_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM CUSTOMER WHERE customer_id = ?");
			pstmt.setString(1, customer_id);
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
	
	public int modifyCustomer(String customer_id, CustomerBean customer) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int isCompleted = 0;
		
		try {
			conn = DBConnection.getConnection();
			
			String password = customer.getPassword();
			String name = customer.getName();
			Timestamp date_of_birth = customer.getDate_of_birth();
			String address = customer.getAddress();
			String phone_number = customer.getPhone_number();
			pstmt = conn.prepareStatement(
					"UPDATE CUSTOMER SET password = ?, name = ?, date_of_birth = ?, address = ?, phone_number = ? "
					+ "WHERE customer_id = ?");
			pstmt.setString(1, password);
			pstmt.setString(2, name);
			pstmt.setTimestamp(3, date_of_birth);
			pstmt.setString(4, address);
			pstmt.setString(5, phone_number);
			pstmt.setString(6, customer_id);
			
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
