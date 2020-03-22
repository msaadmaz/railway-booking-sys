<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

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
	
	    // Get parameters from the HTML form at the HelloWorld.jsp
	    String username = request.getParameter("username");
	    System.out.println(username);
	    
	    String password = request.getParameter("password");
	    
	    
	    
	    //Make an insert statement for the User table:
	    String insert = "INSERT INTO User(username, password)" + "VALUES (?, ?)";
	    System.out.println(insert);
	    
	    //Create a Prepared SQL statement allowing you to introduce the parameters of the query
	    PreparedStatement ps = con.prepareStatement(insert);

	    //Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	    ps.setString(1, username);
	    ps.setString(2, password);
	    
	    //Run the query against the DB
	    ps.executeUpdate();
	    
	    // close the connection
	    db.closeConnection(con);
    %>
  </body>
</html>