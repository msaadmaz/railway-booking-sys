<%-- 
  - Author(s): Jason Mustafa
  - Date: April 2020
  - Copyright Notice: Private Use
  - @(#)
  - Description: View stops for selected route
  --%>

<%@ page  language="java"
          contentType="text/html; charset=ISO-8859-1"
          pageEncoding="ISO-8859-1"
          import="com.cs336.pkg.*"
%>

<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
  <title>View Schedules</title>
  
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
      
      String routeId = request.getParameter("routeId");
      System.out.println(routeId);
      
      Statement st2 = con.createStatement();
      ResultSet rs2 = st2.executeQuery("SELECT transit_line_name FROM route WHERE id = " + routeId);
      
      if (rs2.next()) {
        out.println(rs2.getString("transit_line_name"));
      }
      
      String s1 = "SELECT s.name, sa.arrival_time, sa.departure_time ";
      String s2 = "FROM station s, stops_at sa ";
      String s3 = "WHERE sa.route_id = ";
      String s4 = " AND sa.station_id = s.id ";
      String s5 = "ORDER BY sa.arrival_time ASC;";
      
      ResultSet rs = st.executeQuery(s1 + s2 + s3 + routeId + s4 + s5);
  %>
  
  <div class="topnav">
    <h1 class="active jjmt">JJMT Railways</h1>
    <a class="active logout" href="logout.jsp">Logout</a>
  </div>

  <h2>Stops</h2>

  <table>
    <tr>
      <th>Station Name</th>
      <th>Arrival Time</th>
      <th>Departure Time</th>
    </tr>
    
    <%  while (rs.next()) { %>
          <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= formatTime(rs.getString("arrival_time")) %></td>
            <td><%= formatTime(rs.getString("departure_time")) %></td>
          </tr>
    <%  } %>
  </table>
  
  <%  rs2.close();
      rs.close();
      st2.close();
      st.close();
      con.close();
  %>
  
  <%! private static String formatTime(String inputDate) {
        DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("HH:mm:ss", Locale.US);
        DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern("hh:mm a", Locale.US);
        
        return LocalTime.parse(inputDate, inputFormat).format(outputFormat);
      }
  %>
</body>
</html>