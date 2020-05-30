<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Select Customer</title>
  
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
  
  <%    
  
  		// getting all current customer user names for the employee to select
  		Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement st = con.createStatement();
        
        ResultSet rs = st.executeQuery("SELECT username FROM customer;");
    %>
    
     <div class="topnav">
    	<h1 class="active jjmt">JJMT Railways</h1>
    	<a class="active logout" href="logout.jsp">Logout</a>
  	</div>
  	
 	 <h1>Select A Customer</h1>
 	 <br>


	<form action="Employee_Manage_Reservations.jsp" method="POST">
      <label for="username">Username</label>
      <select id="username" name="username" required>
        <%  while (rs.next()) { 
        		String customer_username = rs.getString(1);
        %>
              <option value="<%= customer_username %>"><%= customer_username %></option>
        <%  } %>
      </select>
      <br />
      
      <button type="submit" class="gray-button">Select Customer</button>
    </form>


</body>
</html>