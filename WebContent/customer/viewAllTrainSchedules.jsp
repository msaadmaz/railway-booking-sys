<%-- 
  - Author(s): Jason Mustafa
  - Date: April 2020
  - Copyright Notice: Private Use
  - @(#)
  - Description: Train schedules main page
  --%>

<%@ page  language="java"
          contentType="text/html; charset=ISO-8859-1"
          pageEncoding="ISO-8859-1"
          import="com.cs336.pkg.*"
%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
  <head>
    <title>All Schedules</title>
    
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    
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
        
        // TODO: query only future trips, exclude past
        
        String q1 = "SELECT t.id, r.transit_line_name, r.depart_time, s1.name AS 'origin_station', s2.name AS 'destination_station', r.arrival_time, t.date, r.id AS route_id, t.delay, r.standard_fare ";
        String q2 = "FROM trip t, route r, station s1, s2 ";
        String q3 = "WHERE t.route_id = r.id ";
        String q4 = "AND r.origin_station_id = s1.id ";
        String q5 = "AND r.destination_station_id = s2.id ";
        String q6 = "GROUP BY t.id ";
        
        String o1 = "ORDER BY arrival_time ASC;";
        String o2 = "ORDER BY depart_time ASC;";
        String o3 = "ORDER BY origin_station ASC;";
        String o4 = "ORDER BY destination_station ASC;";
        String o5 = "ORDER BY standard_fare ASC;";
        
        String order = o1;
        
        if (request.getParameter("sort") != null) {
          String orderParam = request.getParameter("sort");
          
          if (orderParam.equals("arrival")) {
            order = o1;
          } else if (orderParam.equals("departure")) {
            order = o2;
          } else if (orderParam.equals("origin")) {
            order = o3;
          } else if (orderParam.equals("destination")) {
            order = o4;
          } else if (orderParam.equals("fare")) {
            order = o5;
          }
        }
        
        // query trips and their transit line names and origin and destination stations
        String showAllTripsQuery = q1 + q2 + q3 + q4 + q5 + q6 + order;
        ResultSet rs = st.executeQuery(showAllTripsQuery);
    %>
    
    <div class="topnav">
      <h1 class="active jjmt">JJMT Railways</h1>
      <a class="active logout" href="logout.jsp">Logout</a>
    </div>
  
    <h2>All Train Schedules</h2>
    
    <p>Sort by</p>
    
    <div>
      <a href="viewAllTrainSchedules.jsp?sort=arrival">Arrival Time</a>
      <a href="viewAllTrainSchedules.jsp?sort=departure">Departure Time</a>
      <a href="viewAllTrainSchedules.jsp?sort=origin">Origin</a>
      <a href="viewAllTrainSchedules.jsp?sort=destination">Destination</a>
      <a href="viewAllTrainSchedules.jsp?sort=fare">Fare</a>
    </div>
    
    <br />
  
    <table>
      <tr>
        <th>ID</th>
        <th>Date</th>
        <th>Transit Line</th>
        <th>Departure Time</th>
        <th>Origin Station</th>
        <th>Destination Station</th>
        <th>Arrival Time</th>
        <th>Standard Fare</th>
        <th>Delay</th>
        <th>View Route</th>
        <th>Reserve</th>
      </tr>
      
      <%  while (rs.next()) { %>
            <tr>
              <td><%= rs.getInt("id") %></td>
              <td><%= rs.getDate("date") %></td>
              <td><%= rs.getString("transit_line_name") %></td>
              <td><%= rs.getString("depart_time") %></td>
              <td><%= rs.getString("origin_station") %></td>
              <td><%= rs.getString("destination_station") %></td>
              <td><%= rs.getString("arrival_time") %></td>
              <td><%= rs.getFloat("standard_fare") %></td>
              <td><%= rs.getInt("delay") %></td>
              <td><a href="viewStops.jsp?routeId=<%= rs.getInt("route_id") %>">View Route</a></td>
              <td><a href="createReservationForm.jsp?tripId=<%= rs.getInt("id") %>">Click here to book</a></td>
            </tr>
      <%  } %>
    </table>
    
    <%  rs.close();
        st.close();
        con.close();
    %>
  </body>
</html>