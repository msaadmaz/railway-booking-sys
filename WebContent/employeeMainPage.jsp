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
  <h1>User Main Page</h1>
  <p>Congratulations, you have logged in!</p>
  <br>
  
  <p>What would you like to do:</p>
  <ol>
  	<li><a href="browse.jsp">Browse for train schedules</a></li>
  	<li><a href="makeCancelReservation.jsp">Create or Cancel Reservation</a></li>
  	<li><a href="customerService.jsp">Customer Service</a></li>
  </ol>
  
</body>
</html>