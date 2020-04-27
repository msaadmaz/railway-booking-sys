<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<% 

	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

// Create a SQL statement

	String originalUsername = request.getParameter("OriginalUsername");
	String newUsername = request.getParameter("username");
	String password = request.getParameter("password");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String street = request.getParameter("street");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String zipString = request.getParameter("zip");
	int zip = Integer.valueOf(zipString);
	
	
	Statement stmt = con.createStatement();
	ResultSet rs;
	
	if (!newUsername.equals(originalUsername)){
		rs = stmt.executeQuery("SELECT * FROM Customer where username = '" + newUsername + "'");
		if (rs.next()){
			out.println("Username already exists <a href='adminMainPage.jsp'>try again</a>");
			
	  		rs.close();
		}
	}
	
	String sql = "Update Customer set last_name=?,first_name=?,phone_num=?,street=?,city=?, state=?,zip=?,email=?,username=?,password=? where username= '"+originalUsername + "'";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, lastName);
    ps.setString(2, firstName);
    ps.setString(3, phone);
    ps.setString(4, street);
    ps.setString(5, city);
    ps.setString(6, state);
    ps.setInt(7, zip);
    ps.setString(8, email);
    ps.setString(9, newUsername);
    ps.setString(10, password);
    ps.executeUpdate();

    db.closeConnection(con);
    response.sendRedirect("adminMainPage.jsp");
	 
%>
	 