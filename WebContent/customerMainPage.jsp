<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
</head>
<body>
  <h1>Home</h1>
  <p>Hello, <%= session.getAttribute("user") %>!</p>
  <br>
  
  <p>What would you like to do:</p>
  <ol>
  	<li><a href="searchTrainSchedules.jsp">Search for train schedules</a></li>
  	<li><a href="makeCancelReservation.jsp">Create or cancel reservation</a></li>
  	<li><a href="viewMessages.jsp">View messages</a></li>
  </ol>
  
</body>
</html>