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
	    String month = request.getParameter("month");
	    ResultSet rs;
	    rs = stmt.executeQuery("SELECT SUM(total_fee) as revenue FROM Reservation where date LIKE " + month);
	    if (rs.next()) {
	    	rs.close();
	    	  
	        out.println("No revenue for that month <a href='adminMainPage.jsp'>try again</a>");
	    }
	    double totalRevenue = rs.getDouble(1);
	    out.println("The total revenue for " + month + " was $" + totalRevenue);
	    
		stmt.close();
        
        db.closeConnection(con);
        %>
        <br />
        <%
        out.println("<a href='adminMainPage.jsp'>Go back to main page</a>");

	    
	    
	    %>
	    