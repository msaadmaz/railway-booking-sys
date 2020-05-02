<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
  <head>
    <title>JJMT Railways</title>
    <link rel="stylesheet" type="text/css" href="css/main.css">
  </head>
  
  <body>
    <form action="createReservation.jsp?tripId=<%= request.getParameter("tripId") %>" method="POST">
      <input name="age" type="text" class="text-input" placeholder="Age" />
      <br>
      
      <p>Are you disabled?</p>
      <input type="radio" id="no-disabled" name="disabled" value="no-disabled" checked>
      <label for="no-disabled">No</label>
      <input type="radio" id="yes-disabled" name="disabled" value="yes-disabled">
      <label for="yes-disabled">Yes</label>
      <br>
      
      <p>Round trip?</p>
      <input type="radio" id="no-disabled" name="round-trip" value="no-round-trip">
      <label for="no-round-trip">No</label>
      <input type="radio" id="yes-disabled" name="round-trip" value="yes-round-trip" checked>
      <label for="yes-round-trip">Yes</label>
      <br>
      
      <p>Reservation</p>
      <input type="radio" id="day" name="reservation" value="one-way" checked>
      <label for="day">Day</label>
      <input type="radio" id="day" name="reservation" value="round-trip" checked>
      <label for="round-trip">Round Trip</label>
      <input type="radio" id="week" name="reservation" value="week">
      <label for="week">Week Pass</label>
      <input type="radio" id="month" name="reservation" value="month">
      <label for="month">Month Pass</label>
      <br>
      
      <p>Seat Class</p>
      <input type="radio" id="economy" name="class" value="ECONOMY" checked>
      <label for="economy">Economy</label>
      <input type="radio" id="first" name="class" value="FIRST">
      <label for="first">First</label>
      <input type="radio" id="second" name="class" value="SECOND">
      <label for="second">Second</label>
      <br>
      
      <button type="submit" class="gray-button">Create Account</button>
    </form>
  </body>
</html>