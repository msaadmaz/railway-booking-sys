<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Employee Main Page</title>
  
  <link rel="stylesheet" type="text/css" href="css/main.css">
  
  <style>
    table, th, td {
      border: 1px solid black;
    }
    
    th, td {
      padding: 5px;
    }
  </style>
</head>
<body>
 <div class="topnav">
    <h1 class="active jjmt">JJMT Railways</h1>
    <a class="active logout" href="logout.jsp">Logout</a>
  </div>
  <h1>Employee Main Page</h1>
  <br>
  
  <p> User: <%= session.getAttribute("user") %></p>
  <p>What would you like to do:</p>
  <ol>
  	<li><a href="Employee_Browse_Schedule.jsp">Browse Train Schedules</a></li>
  	<li><a href="Employee_Browse_Customers.jsp">Browse Customer Reservations</a></li>
  	<li><a href="Employee_Customer_Lookup.jsp">Manage Customer Reservations</a></li>
  	<li><a href="customerService.jsp">Customer Service</a></li>
  	<li><a href="logout.jsp">Log Out</a></li>
  </ol>
  
</body>
</html>