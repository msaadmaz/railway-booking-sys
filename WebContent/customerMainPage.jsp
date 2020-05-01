
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
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
  <%  Class.forName("com.mysql.jdbc.Driver");
      ApplicationDB db = new ApplicationDB();
      Connection con = db.getConnection();
      Statement st = con.createStatement();
      
      String createTemp = "CREATE TEMPORARY TABLE s2 SELECT * FROM station;";
      
      // update (create) temporary tables
      st.executeUpdate(createTemp);
      
      String q1 = "SELECT t.date, s1.name AS 'origin_station', s2.name AS 'destination_station', r.seat_num, r.seat_class, r.date_made, r.total_fare ";
      String q2 = "FROM reservation r, customer c, trip t , route ro, station s1, s2 ";
      String q3 = "WHERE r.customer_username = c.username ";
      String q4 = "AND r.trip_id = t.id ";
      String q5 = "AND t.route_id = ro.id ";
      String q6 = "AND ro.origin_station_id = s1.id ";
      String q7 = "AND ro.destination_station_id = s2.id ";
      String q8 = "GROUP BY t.date ASC;";
      
      ResultSet rs = st.executeQuery(q1 + q2 + q3 + q4 + q5 + q6 + q7 + q8);
  %>
  
  <h1>Hello, <%= session.getAttribute("user") %>!</h1>
  
	<a href="searchTrainSchedules.jsp" class="gray-button">Search for train schedules</a>
	<a href="viewMessages.jsp" class="gray-button">View messages</a>
  
  <h2>My Reservations</h2>
  
  <table>
    <tr>
      <th>Date</th>
      <th>Origin</th>
      <th>Destination</th>
      <th>Seat Number</th>
      <th>Class</th>
      <th>Date Booked</th>
      <th>Total Fare</th>
      <th>Cancel</th>
    </tr>
    
    <%  while (rs.next()) { %>
          <tr>
            <td><%= rs.getDate("date") %></td>
            <td><%= rs.getString("origin_station") %></td>
            <td><%= rs.getString("destination_station") %></td>
            <td><%= rs.getInt("seat_num") %></td>
            <td><%= rs.getString("seat_class") %></td>
            <td><%= rs.getDate("date_made") %></td>
            <td><%= String.format("%.2f", rs.getFloat("total_fare")) %></td>
            <td>
              <a href="cancelReservation.jsp">Click here to cancel</a>
            </td>
          </tr>
    <%  } %>
  </table>
</body>
</html>