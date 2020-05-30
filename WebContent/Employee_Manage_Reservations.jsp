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
        
        
        // Get the value from the previous page
        String customer_username = request.getParameter("username");
        
        // Set the selected username as a session attribute
        session.setAttribute("customer_username", customer_username);
        
        
        
        ResultSet rs = st.executeQuery("SELECT " +
        		"rsv.res_num AS reservation_res_num, " +
        	    "stn_origin.name AS stn_origin_name, " +
        	    "stn_destination.name AS stn_destination_name, " +
        	    "rt.depart_time AS route_depart_time, " +
        	    "rt.arrival_time AS route_arrival_time, " +
        	    "rsv.seat_num AS reservation_seat, " +
        	    "rsv.date_made AS reservation_date_made, " +
        	    "trp.id AS trip_id " +
        	"FROM reservation rsv " +
        			"LEFT JOIN station stn_origin on rsv.origin_station = stn_origin.id " +
        			"LEFT JOIN station stn_destination on rsv.destination_station = stn_destination.id " +
        	        "LEFT JOIN trip trp on rsv.trip_id = trp.id " +
        	        "LEFT JOIN route rt on trp.route_id = rt.id " + 
        	"WHERE " +
        		"rsv.customer_username = '" + customer_username + "';");
    %>
    
     <div class="topnav">
    	<h1 class="active jjmt">JJMT Railways</h1>
    	<a class="active logout" href="logout.jsp">Logout</a>
  	</div>
  	
 	 <h1>Customer Reservations</h1>
 	 <br>
 	 
 	 <div>
      <a href="Employee_Add_Reservation.jsp">Add Reservation</a>
    </div>
    
    <br />


	 <table>
      <tr>
        <th>Reservation Number</th>
        <th>Origin Station</th>
        <th>Destination Station</th>
        <th>Departure Times</th>
        <th>Arrival Time</th>
        <th>Reservation Seat</th>
        <th>Date Made</th>
        <th>Trip ID</th>
        <th>EDIT RES</th>
        <th>DELETE RES</th>
      </tr>
      
      <%  while (rs.next()) {
    	  		int reservation_number = rs.getInt(1);%>
            <tr>
              <td><%= reservation_number %></td>
              <td><%= rs.getString(2) %></td>
              <td><%= rs.getString(3) %></td>
              <td><%= rs.getTime(4) %></td>
              <td><%= rs.getTime(5) %></td>
              <td><%= rs.getInt(6) %></td>
              <td><%= rs.getDate(7) %></td>
              <td><%= rs.getInt(8) %></td>
              <td><a href="Employee_Edit_Reservation.jsp?reservation_number=<%= reservation_number%>">Edit Reservation</a></td>
              <td><a href="Employee_Delete_Reservation.jsp?reservation_number=<%= reservation_number%>">Delete Reservation</a></td>
            </tr>
      <%  } %>
    </table>
    
    <%  rs.close();
        st.close();
        con.close();
    %>
  </body>
</html>