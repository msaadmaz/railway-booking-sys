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
  </style>
</head>

<body>
  <%  Class.forName("com.mysql.jdbc.Driver");
    
      ApplicationDB db = new ApplicationDB();
      Connection con = db.getConnection();
      Statement stTrip = con.createStatement();
      Statement stRoute = con.createStatement();
      
      // get all trips and their transit line names
      String showAllTripsQuery = "SELECT t.id, r.transit_line_name, t.date FROM trip t, route r WHERE t.route_id = r.id;";
      ResultSet rs = stTrip.executeQuery(showAllTripsQuery);
  %>

  <h2>Search for train schedules</h2>

  <table>
    <tr>
      <td>ID</td>
      <td>Transit Line</td>
      <td>Date</td>
    </tr>
    
    <%  while (rs.next()) { %>
          <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("transit_line_name") %></td>
            <td><%= rs.getDate("date") %></td>
          </tr>
    <%  } %>
  </table>
  
  <%  rs.close();
      stTrip.close();
      con.close();
  %>
</body>
</html>