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
    <title>View Schedules</title>
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
    <%  int originId = Integer.parseInt(request.getParameter("origin"));
        int destinationId = Integer.parseInt(request.getParameter("destination"));
        String travelDate = request.getParameter("date");
        
        System.out.println(originId);
        System.out.println(destinationId);
        System.out.println(travelDate);
    
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement st = con.createStatement();
        
        String s1 = "CREATE TEMPORARY TABLE s2 SELECT * FROM station;";
        
        // update (create) temporary tables
        st.executeUpdate(s1);
        
        // TODO: query only future trips, exclude past
        
        String s2 = "SELECT t.id, r.transit_line_name, r.depart_time, s1.name AS 'origin_station', s2.name AS 'destination_station', r.arrival_time, t.date, r.id AS route_id ";
        String s3 = "FROM trip t, route r, station s1, s2 ";
        String s4 = "WHERE t.route_id = r.id ";
        String s5 = "AND r.origin_station_id = s1.id ";
        String s6 = "AND r.origin_station_id = " + originId + " ";
        String s7 = "AND r.destination_station_id = s2.id ";
        String s8 = "AND r.destination_station_id = " + destinationId + " ";
        String s9 = "GROUP BY t.date ";
        
        // query trips and their transit line names and origin and destination stations
        String showAllTripsQuery = s2 + s3 + s4 + s5 + s6 + s7;
        ResultSet rs = st.executeQuery(showAllTripsQuery);
    %>
  
    <h2>Search for train schedules</h2>
    
    <form action="" method="POST">
      <label for="origin-station">Origin Station</label>
      <input id="origin-station" name=origin-station type="text" class="text-input" />
      <br />
      
      <button type="submit" class="gray-button">Submit</button>
    </form>
  
    <table>
      <tr>
        <th>ID</th>
        <th>Date</th>
        <th>Transit Line</th>
        <th>Departure Time</th>
        <th>Origin Station</th>
        <th>Destination Station</th>
        <th>Arrival Time</th>
        <th>View Route</th>
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
              <td>
                <a href="viewStops.jsp?routeId=<%= rs.getInt("route_id") %>">View Route and Stops</a>
              </td>
            </tr>
      <%  } %>
    </table>
    
    <%  rs.close();
        st.close();
        con.close();
    %>
  </body>
</html>