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

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
  <title>View Schedules</title>
  <link rel="stylesheet" type="text/css" href="css/main.css">
</head>

<body>
  <%  Class.forName("com.mysql.jdbc.Driver");
    
      ApplicationDB db = new ApplicationDB();
      Connection con = db.getConnection();
      Statement st = con.createStatement();
      
      ResultSet rs = st.executeQuery("SELECT DISTINCT s.name FROM station s, stops_at sa WHERE sa.route_id = 2 AND sa.station_id = s.id;");
  %>

  <h2>Stops</h2>

  <table>
    <tr>
      <th>Station Name</th>
    </tr>
    
    <%  while (rs.next()) { %>
          <tr>
            <td><%= rs.getInt("id") %></td>
          </tr>
    <%  } %>
  </table>
  
  <%  rs.close();
      st.close();
      con.close();
  %>
</body>
</html>