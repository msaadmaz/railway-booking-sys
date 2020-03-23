<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
  </head>
  <body>
    <%
      // TODO: check that username does not already exsit
	    // Get the database connection
	    ApplicationDB db = new ApplicationDB();
	    Connection con = db.getConnection();
	
	    // Create a SQL statement
	    Statement stmt = con.createStatement();
	
	    // Get parameters from createAccountForm.jsp
	    String username = request.getParameter("username");    
	    String password = request.getParameter("password");
      String firstName = request.getParameter("firstName");     
      String lastName = request.getParameter("lastName");     
      String email = request.getParameter("email");     
      String phone = request.getParameter("phone");     
      String street = request.getParameter("street");     
      String city = request.getParameter("city");     
      String state = request.getParameter("state");     
      int zip = Integer.valueOf(request.getParameter("zip"));
      
      // checks
	    
	    // Make an insert statement for the User table:
      String insert = "INSERT INTO Customer(last_name, first_name, phone_num, street, city, state, zip, email, username, password)"
    	    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    
	    // Create a Prepared SQL statement allowing you to introduce the parameters of the query
	    PreparedStatement ps = con.prepareStatement(insert);

	    // Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	    ps.setString(1, lastName);
	    ps.setString(2, firstName);
	    ps.setString(3, phone);
	    ps.setString(4, street);
	    ps.setString(5, city);
	    ps.setString(6, state);
	    ps.setInt(7, zip);
	    ps.setString(8, email);
	    ps.setString(9, username);
	    ps.setString(10, password);
	    
	    // Run the query against the DB
	    ps.executeUpdate();
	    
	    // close statement
	    stmt.close();
	    
	    // close the connection
	    db.closeConnection(con);
	    
	    // go back to login page
	    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
	    dispatcher.forward(request, response);
    %>
  </body>
</html>