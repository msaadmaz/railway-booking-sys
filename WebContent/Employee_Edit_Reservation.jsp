<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Edit Customer Reservation</title>
  
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

     <div class="topnav">
    	<h1 class="active jjmt">JJMT Railways</h1>
    	<a class="active logout" href="logout.jsp">Logout</a>
  	</div>
  
  <%    
  
  		// comment comment comment, more comment
  		Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement st = con.createStatement();
        
        
        // Get customer username stored in the session variable
        String customer_username = session.getAttribute("customer_username").toString();
        
        // Get the reservation number from the previous page 
        int reservation_number = Integer.parseInt(request.getParameter("reservation_number"));
        
        // Set this as a session variable
        session.setAttribute("reservation_number", reservation_number);
        
        
        
        // Get all the current data on that reservation
        ResultSet rs = st.executeQuery("SELECT trip_id, seat_num, seat_class " +
        								"FROM reservation " +
        								"WHERE res_num = " + reservation_number + " " +
        								"AND customer_username = '" + customer_username + "';");      								
        
        // declare var here so its on the outer scope of the ifelse statement
        int trip_id;
        
        //get the date (as long as its there,,,, which it should be)
        if(rs.next())
        {
        	System.out.println("\nDisplaying reservation so the employee can edit it\n");
        	
        	trip_id = rs.getInt(1);
        	%>
        	<p>Current reservation data</p>
        	<table>
            <tr>
              <th>Reservation Number (can't edit)</th>
              <th>Customer Username (can't edit)</th>
              <th>Trip ID</th>
              <th>Seat Number</th>
              <th>Seat Class</th>
            </tr>
            <tr>
              <td><%= reservation_number %></td>
              <td><%= customer_username %></td>
              <td><%= trip_id %></td>
              <td><%= rs.getInt(2) %></td>
              <td><%= rs.getString(3) %></td>
            </tr>
          </table>
          <br>
          
        <%
        }
        else
        {
        	System.out.println("Shiiieeeeeeet somthing got fucked up, shouldnt have if res_num works...fuuuck, oops");
        }
        
        //getting the current seats taken on the trip FUCK THIS PROJECT
        //ResultSet rs_seats_taken = st.executeQuery("SELECT seat_num FROM reservation WHERE ");
        
        
        
        %>
        
        <form action="Employee_Update_Reservation.jsp" method="POST">
		    <label for="Seat_Number">Seat Number</label>
		    <input id="Seat_Number" name="Seat_Number" type="text" class="text-input" />
		    <br />
		    
		    <label for="Seat_Class">Seat_Class</label>
		    <input id="Seat_Class" name="Seat_Class" type="text" class="text-input" />
		    <br />
		
		    <button type="submit" class="gray-button">Submit New Values</button>
  		</form>
        
        
 	<% 
    out.println("Change to new trip <a href='Employee_Edit_Res_new_trip.jsp'>Change Trip</a>");
    
    out.println("Not what your looking for?? <a href='Employee_Manage_Reservations.jsp'>Manage Reservations Page</a>");
    rs.close();
    st.close();
    con.close();
    %>
  </body>
</html>