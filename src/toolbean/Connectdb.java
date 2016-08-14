package toolbean;

import java.sql.*;

public class Connectdb {
	String DriverName = "com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost/books?useUnicode=true&characterEncoding=utf-8";
	String user="root";
	String password="root";
	private Connection conn = null;
	private Statement stmt = null;
	ResultSet rs = null;

	public Connectdb() {
		try {
			Class.forName(DriverName);
		} catch (java.lang.ClassNotFoundException e) {
			System.err.println("Connectdb():" + e.getMessage());
		}
	}

	public ResultSet executeQuery(String sql) {
		rs = null;
		try {
			conn = DriverManager.getConnection(url, user, password);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
		} catch (SQLException ex) {
			System.err.println("aq.executeQuery:" + ex.getMessage());
		}
		return rs;
	}

	public void executeUpdate(String sql) {
		stmt = null;
		rs = null;
		try {
			conn = DriverManager.getConnection(url, user, password);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			stmt.executeUpdate(sql);
			stmt.close();
			conn.close();
		} catch (SQLException ex) {
			System.err.println("aq.executeQuery:" + ex.getMessage());
		}
	}

	public void closeStmt() {
		try {
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void closeConn() {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
