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
	boolean isUnique = true;
	if (!newUsername.equals(originalUsername)){
		rs = stmt.executeQuery("SELECT * FROM customer where username = '" + newUsername + "'");
		if (rs.next()){
			out.println("Username already exists <a href='adminMainPage.jsp'>try again</a>");
			isUnique = false;
	  		rs.close();
		    db.closeConnection(con);
		}

	}
	if (isUnique){
	
	String sql = "Update customer set username=?, password=?,first_name=?,last_name=?,address=?, city=?,state=?,zip=?,phone=?,email=? where username= '"+originalUsername + "'";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, newUsername);
    ps.setString(2, password);
    ps.setString(3, firstName);
    ps.setString(4, lastName);
    ps.setString(5, street);
    ps.setString(6, city);
    ps.setString(7, state);
    ps.setInt(8, zip);
    ps.setString(9, phone);
    ps.setString(10, email);
    
    ps.executeUpdate();
    response.sendRedirect("adminMainPage.jsp");

    db.closeConnection(con);


	}

	 
%>
	 