<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<% 

	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

// Create a SQL statement

	String originalSSN = request.getParameter("OriginalSSN");
	String originalUsername = request.getParameter("OriginalUsername");
	String Username = request.getParameter("username");
	String password = request.getParameter("password");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String newSSN = request.getParameter("SSN");
	
	
    Statement stmt = con.createStatement();

	ResultSet rs;
	
	if (!originalUsername.equals(Username)){
		System.out.println("originalUsername: " + originalUsername);
		System.out.println("Username: " + Username);
	    System.out.println("DIFFERENT USERNAMES");

	    rs = stmt.executeQuery("SELECT * FROM Employees where username = '" + Username + "'");
		if (rs.next()){
			out.println("Username already exists <a href='adminMainPage.jsp'>try again</a>");
			
	  		rs.close();
		}
	}
    else if(!newSSN.equals(originalSSN)) {
    	rs = stmt.executeQuery("SELECT * FROM Employees where ssn = '" + newSSN + "'");
    	if (rs.next()){
    		out.println("SSN already exists <a href='adminMainPage.jsp'>try again</a>");

      		rs.close();
    	}
    }
    
    
    else {
		String sql = "Update Employees set username=?, password=?, isManager=?, first_name=?, last_name=?,ssn=? where ssn= '"+originalSSN +"'";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, Username);
		ps.setString(2, password);
		ps.setInt(3,0);
		ps.setString(4, firstName);
		ps.setString(5, lastName);
		ps.setString(6,newSSN);
		ps.executeUpdate();

    	db.closeConnection(con);
   		response.sendRedirect("adminMainPage.jsp");
    }
   %>