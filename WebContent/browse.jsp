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
  <%  Class.forName("com.mysql.jdbc.Driver");
    
      ApplicationDB db = new ApplicationDB();
      Connection con = db.getConnection();
      Statement st = con.createStatement();
      
      String s1 = "CREATE TEMPORARY TABLE s1 SELECT * FROM station;";
      String s2 = "CREATE TEMPORARY TABLE s2 SELECT * FROM station;";
      
      // update (create) temporary tables
      st.executeUpdate(s1);
      st.executeUpdate(s2);
      
      String s3 = "SELECT t.id, r.transit_line_name, s1.name AS 'origin_station', s2.name AS 'destination_station', t.date ";
      String s4 = "FROM trip t, route r, s1, s2 ";
      String s5 = "WHERE t.route_id = r.id ";
      String s6 = "AND r.origin_station_id = s1.id ";
      String s7 = "AND r.destination_station_id = s2.id;";
      
      // query trips and their transit line names and origin and destination stations
      String showAllTripsQuery = s3 + s4 + s5 + s6 + s7;
      ResultSet rs = st.executeQuery(showAllTripsQuery);
  %>

  <h2>Search for train schedules</h2>

  <table>
    <tr>
      <td>ID</td>
      <td>Transit Line</td>
      <td>Origin Station</td>
      <td>Destination Station</td>
      <td>Date</td>
    </tr>
    
    <%  while (rs.next()) { %>
          <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("transit_line_name") %></td>
            <td><%= rs.getString("origin_station") %></td>
            <td><%= rs.getString("destination_station") %></td>
            <td><%= rs.getDate("date") %></td>
          </tr>
    <%  } %>
  </table>
  
  <%  rs.close();
      st.close();
      con.close();
  %>
</body>
</html>