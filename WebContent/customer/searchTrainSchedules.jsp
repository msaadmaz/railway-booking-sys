<%-- 
  - Author(s): Jason Mustafa
  - Date: April 2020
  - Copyright Notice: Private Use
  - @(#)
  - Description: Search for train schedules
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
    <title>Search Train Schedules</title>
    
    <link rel="stylesheet" type="text/css" href="../css/main.css">
  </head>
  
  <body>
    <%  Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        
        String query = "SELECT id, name FROM station;";
        
        // update (create) temporary tables
        ResultSet rs1 = st1.executeQuery(query);
        ResultSet rs2 = st2.executeQuery(query);
    %>
    
    <div class="topnav">
      <h1 class="active jjmt">JJMT Railways</h1>
      <a class="active logout" href="../logout.jsp">Logout</a>
    </div>
      
    <h2>Search Train Schedules</h2>
    
    <form action="viewTrainSchedules.jsp" method="POST">
      <label for="origin">Origin Station</label>
      <select id="origin" name="origin" required>
        <%  while (rs1.next()) { %>
              <option value="<%= rs1.getInt("id") %>"><%= rs1.getString("name") %></option>
        <%  } %>
      </select>
      <br />
      
      <label for="destination">Destination Station</label>
      <select id="destination" name="destination" required>
        <%  while (rs2.next()) { %>
              <option value="<%= rs2.getInt("id") %>"><%= rs2.getString("name") %></option>
        <%  } %>
      </select>
      <br />
      
      <label for="date">Date of Travel</label>
      <input id="date" name="date" type="date" required>
      <br />
      
      <button type="submit" class="gray-button">Submit</button>
    </form>
    
    <a href="viewAllTrainSchedules.jsp">View all upcoming train schedules</a>
  </body>
</html>