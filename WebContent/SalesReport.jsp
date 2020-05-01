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
	    String year = request.getParameter("year");
	    int monthNum = Integer.parseInt(month);
	    int yearNum = Integer.parseInt(year);
	    ResultSet rs;
	    ;
	    rs = stmt.executeQuery("select SUM(total_fare) from reservation where month(date_made)="+ monthNum +" and year(date_made)=" + year);
	    if (!rs.next()) {
	    	rs.close();
	    	  
	        out.println("No revenue for that month <a href='adminMainPage.jsp'>try again</a>");
	    }
	    else{
	    	double totalRevenue = rs.getDouble(1);
	    	out.println("The total revenue for " + month + "/"+year+ " was $" + totalRevenue);
	    
			stmt.close();
        
        	db.closeConnection(con);
        	%>
        	<br />
        	<%
        	out.println("<a href='adminMainPage.jsp'>Go back to main page</a>");
	    }
	    
	    
	    %>
	    