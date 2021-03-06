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
	    	out.println("You must input a username <a href='createAccountFormForAdminr.jsp'>try again</a>");
   			return;
	    } else if (username.contains(" ")) {
    	  out.println("Your username cannot contain spaces <a href='createAccountFormForAdmin.jsp'>try again</a>");
 			  return;
      }
	    
	    String password = request.getParameter("password");
    			  
	  if (password.equals("")) {
        out.println("You must input a password <a href='createAccountFormForAdmin.jsp'>try again</a>");
        return;
      } else if (password.contains(" ")) {
        out.println("Your password cannot contain spaces <a href='createAccountFormForAdmin.jsp'>try again</a>");
     		return;
      } else if (password.length() <= 3) {
    	  out.println("Your password is too short <a href='createAccountFormForAdmin.jsp'>try again</a>");
 		  return;
      }
    			  
      String firstName = request.getParameter("firstName");
    	
      if (firstName.equals("")) {
        out.println("You must input your first name <a href='createAccountForm.jsp'>try again</a>");
        return;
      }
      
      String lastName = request.getParameter("lastName");

      if (lastName.equals("")) {
        out.println("You must input your last name <a href='createAccountFormForAdmin.jsp'>try again</a>");
        return;
      }
      
      String email = request.getParameter("email");     

      if (email.equals("")) {
        out.println("You must input a valid email address <a href='createAccountForm.jsp'>try again</a>");
        return;
      }
      
      String phone = request.getParameter("phone");     
      
      if (phone.equals("")) {
        out.println("You must input a valid phone number <a href='createAccountFormForAdmin.jsp'>try again</a>");
        return;
      }
      
      for (int i = 0; i < phone.length(); i++) {
    	  if (Character.isLetter(phone.charAt(i))) {
    		  out.println("You must input a valid phone number <a href='createAccountFormForAdmin.jsp'>try again</a>");
    		  return;
    	  }
      }
      
      String street = request.getParameter("street");     

      if (street.equals("")) {
        out.println("You must input your street name <a href='createAccountFormForAdmin.jsp'>try again</a>");
        return;
      }
      
      String city = request.getParameter("city");     

      if (city.equals("")) {
        out.println("You must input your city <a href='createAccountFormForAdmin.jsp'>try again</a>");
        return;
      }
      
      String state = request.getParameter("state");     

      if (state.equals("")) {
        out.println("You must input your state <a href='createAccountFormForAdmin.jsp'>try again</a>");
        return;
      }
      
      String zipString = request.getParameter("zip");
        		
      if (zipString.equals("")) {
        out.println("You must input your zip code <a href='createAccountForForAdminm.jsp'>try again</a>");
        return;
      }
      
      int zip;
        		
      try {
    	  zip = Integer.valueOf(zipString); 
      } catch (Exception e) {
    	  out.println("You must input a valid zip code <a href='createAccountFormForAdmin.jsp'>try again</a>");
        return;
      }
      
      ResultSet rs;
      rs = stmt.executeQuery("SELECT * FROM customer where username = '" + username + "'");
      
      if (rs.next()) {
    	  rs.close();
    	  
        out.println("Username already exists <a href='createAccountFormForAdmin.jsp'>try again</a>");
      } else {
    	  // Make an insert statement for the User table:
    	String insert = "INSERT INTO customer(username, password, first_name, last_name, address, city, state, zip, phone, email)"
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        // Create a Prepared SQL statement allowing you to introduce the parameters of the query
        PreparedStatement ps = con.prepareStatement(insert);

       
        
        // Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
        ps.setString(1, username);
        ps.setString(2, password);
        ps.setString(3, firstName);
        ps.setString(4, lastName);
        ps.setString(5, street);
        ps.setString(6, city);
        ps.setString(7, state);
        ps.setInt(8, zip);
        ps.setString(9, phone);
        ps.setString(10, email);
        
        
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