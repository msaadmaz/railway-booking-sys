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
	    // Get the database connection
	    ApplicationDB db = new ApplicationDB();
    
	    Connection con = db.getConnection();
	    // Create a SQL statement
	    Statement stmt = con.createStatement();
	
	    // Get parameters from createAccountForm.jsp
	    String username = request.getParameter("username");
	    
	    if (username.equals("")) {
	    	out.println("You must input a username <a href='createEmployeeAcountForm.jsp'>try again</a>");
   			return;
	    } else if (username.contains(" ")) {
    	  out.println("Your username cannot contain spaces <a href='createEmployeeAcountForm.jsp'>try again</a>");
 			  return;
      }
	    
	    String password = request.getParameter("password");
    			  
	    if (password.equals("")) {
        out.println("You must input a password <a href='createEmployeeAcountForm.jsp'>try again</a>");
        return;
      } else if (password.contains(" ")) {
        out.println("Your password cannot contain spaces <a href='createEmployeeAcountForm.jsp'>try again</a>");
     		return;
      } else if (password.length() <= 3) {
    	  out.println("Your password is too short <a href='createEmployeeAcountForm.jsp'>try again</a>");
 			  return;
      }
    			  
      String firstName = request.getParameter("firstName");
    	
      if (firstName.equals("")) {
        out.println("You must input your first name <a href='createEmployeeAcountForm.jsp'>try again</a>");
        return;
      }
      
      String lastName = request.getParameter("lastName");

      if (lastName.equals("")) {
        out.println("You must input your last name <a href='createEmployeeAcountForm.jsp'>try again</a>");
        return;
      }
      String ssn = request.getParameter("ssn");
      if (ssn.length()!=11){
          out.println("You must input a valid ssn(11 characters) <a href='createEmployeeAcountForm.jsp'>try again</a>");

      }
      
      
      ResultSet rs;
      rs = stmt.executeQuery("SELECT * FROM employee where username = '" + username + "'");
      boolean lol = false;
      if (rs.next()) {
    	    rs.close();
    	  	lol = true;
			out.println("Username already exists <a href='createEmployeeAcountForm.jsp'>try again</a>");
        	return;	
      } 
      ResultSet rs2; 
      rs2 = stmt.executeQuery("SELECT * FROM employee where ssn = '" + ssn + "'");
      if (rs2.next() &&!lol) {
    	  rs2.close();
    	  
        out.println("SSN already exists <a href='createEmployeeAcountForm.jsp'>try again</a>");
        return;
      }
      
      else {
    	  // Make an insert statement for the User table:
        String insert = "INSERT INTO employee(username, password, ssn, first_name, last_name, is_manager)"
            + "VALUES (?, ?, ?, ?, ?, ?)";
        
        // Create a Prepared SQL statement allowing you to introduce the parameters of the query
        PreparedStatement ps = con.prepareStatement(insert);

        // Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
        ps.setString(1, username);
        ps.setString(2, password);
        ps.setString(3, ssn);
        ps.setString(4, firstName);
        ps.setString(5,lastName);
        ps.setInt(6, 0);
        
        
        // Run the query against the DB
        ps.executeUpdate();
        
        // close statement
        stmt.close();
        
        // close the connection
        db.closeConnection(con);
        
        // go back to login page
        response.sendRedirect("adminMainPage.jsp");
      }
    %>
  </body>
</html>