<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	
    
    // blah blah blah
    Class.forName("com.mysql.jdbc.Driver");
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement st = con.createStatement();
    
    
	// get session attributes so that specific reservation can be selected
    String customerUsername = session.getAttribute("customer_username").toString();
	String employee_username = session.getAttribute("user").toString();
	
	
	
	
	System.out.println("WHAT THE EMP USER = " + employee_username);
	
	
	

	// getting the values from the previous page
	int tripId = Integer.parseInt(request.getParameter("tripId"));
	int age = Integer.parseInt(request.getParameter("age"));
	String isDisabled = request.getParameter("disabled");
	String isRoundTrip = request.getParameter("round-trip");
	String seatClass = request.getParameter("class");
    
    
    // Amerikkkan Korruption
    ResultSet rs;
    rs = st.executeQuery("SELECT * FROM reservation where customer_username = '" + customerUsername + "' AND trip_id = " + tripId + ";");
    
    if (rs.next()) {
      rs.close();
      st.close();
      db.closeConnection(con);
      
      out.println("Reservation already exists <a href='Employee_Add_Reservation.jsp'>try again</a>");
    } else {
      String insert = "INSERT INTO reservation(customer_username, trip_id, origin_station, destination_station, total_fare, seat_num, seat_class, date_made, booking_fee, employee_username)"
          + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
      
      PreparedStatement ps = con.prepareStatement(insert);
      
      // calculate total fare
      Statement st2 = con.createStatement();
      String baseFareQuery = "SELECT r.standard_fare FROM trip t, route r WHERE t.route_id = r.id AND t.id = " + tripId + ";";
      ResultSet rs2 = st2.executeQuery(baseFareQuery);
      
      float standardFare = 0;
      float bookingFee = 2;
      float adj = 0;
      
      if (rs2.next()) 
      {
        standardFare = rs2.getFloat("standard_fare");
      }
      
      // discount if child or disabled
      if (age <= 12 || age >= 65 || isDisabled.equals("yes-disabled")) 
      {
        adj -= standardFare * ((float) 0.15);
        bookingFee = 0;
      }
      
      // price increase if higher class seat
      if (seatClass.equals("SECOND"))
      {
        adj += standardFare * ((float) 0.1);
      } else if (seatClass.equals("FIRST"))
      {
        adj += standardFare * ((float) 0.2);
      }
      
      float totalFare = (float) standardFare + bookingFee + adj;
      
      // get the values for origin station and destination station
      Statement st3 = con.createStatement();
      ResultSet rs3 = st3.executeQuery("SELECT "+
      										"rt.origin_station_id, " +
      										"rt.destination_station_id " +
      									"FROM " +
      										"trip tp " +
      										"LEFT JOIN route rt on tp.route_id = rt.id " +
      									"WHERE " +
      										"tp.id = " + tripId + ";");
      
      
      // SCOPE RULES
      int origin_station_id;
      int destination_station_id;
      
      if(rs3.next())
      {
    	  origin_station_id = rs3.getInt(1);
    	  destination_station_id = rs3.getInt(2);
    	  
    	  System.out.println("trains go zoom zoom!!! from og to dest");
      }
      else
      {
    	  System.out.println("DEBUG: failed to get og and dest station id");
    	  
    	  // some default values basically
    	  origin_station_id = 2;
    	  destination_station_id = 5;
      }
      
      
      ps.setString(1, customerUsername);
      ps.setInt(2, tripId);
      ps.setInt(3, origin_station_id);
      ps.setInt(4, destination_station_id);
      ps.setFloat(5, totalFare);
      ps.setInt(6, 1);
      ps.setString(7, seatClass);
      ps.setDate(8, new java.sql.Date(Calendar.getInstance().getTime().getTime()));
      ps.setFloat(9, bookingFee);
      ps.setString(10, employee_username);
      
      // Run the query against the DB
      ps.executeUpdate();
      
      System.out.println("\n-- ADDED RESERVATION SUCCESS --\n");
      
      // Update number of available seats based on tripId
   	// UPDATE reservation with the new data
      String Update_Seats = "UPDATE " +
   								"trip " +
      						"SET " +
      							"available_seats = available_seats - 1 " +
      						"WHERE " +
      							"id = " + tripId + ";";
      
      
  		PreparedStatement update_seats_statement = con.prepareStatement(Update_Seats);
  		update_seats_statement.execute();
    }
    
    rs.close();
    st.close();
    db.closeConnection(con);
    response.sendRedirect("employeeMainPage.jsp");
    %>
  </body>
</html>
