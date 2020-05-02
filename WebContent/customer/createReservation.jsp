<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
  <head>
  <meta charset="ISO-8859-1">
  <title>Create Reservation</title>
  </head>
  
  <body>
    <%  ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement st = con.createStatement();
        
        String username = session.getAttribute("user").toString();
        int tripId = Integer.parseInt(request.getParameter("tripId"));
        int age = Integer.parseInt(request.getParameter("age"));
        String isDisabled = request.getParameter("disabled");
        String isRoundTrip = request.getParameter("round-trip");
        String seatClass = request.getParameter("class");
        //String duration = request.getParameter("duration");
              
        ResultSet rs;
        rs = st.executeQuery("SELECT * FROM reservation where customer_username = '" + username + "' AND trip_id = " + tripId + ";");
        
        if (rs.next()) {
          rs.close();
          st.close();
          db.closeConnection(con);
          
          out.println("Reservation already exists <a href='searchTrainSchedules.jsp'>try again</a>");
        } else {
          String insert = "INSERT INTO reservation(customer_username, trip_id, origin_station, destination_station, total_fare, seat_num, seat_class, date_made, booking_fee)"
              + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
          
          PreparedStatement ps = con.prepareStatement(insert);
          
          // calculate total fare
          Statement st2 = con.createStatement();
          String baseFareQuery = "SELECT r.standard_fare FROM trip t, route r WHERE t.route_id = r.id AND t.id = " + tripId + ";";
          ResultSet rs2 = st2.executeQuery(baseFareQuery);
          
          float standardFare = 0;
          float bookingFee = 2;
          float adj = 0;
          
          if (rs2.next()) {
            standardFare = rs2.getFloat("standard_fare");
          }
          
          // discount if child or disabled
          if (age <= 12 || age >= 65 || isDisabled.equals("yes-disabled")) {
            adj -= standardFare * ((float) 0.15);
            bookingFee = 0;
          }
          
          // price increase if higher class seat
          if (seatClass.equals("SECOND")) {
            adj += standardFare * ((float) 0.1);
          } else if (seatClass.equals("FIRST")) {
            adj += standardFare * ((float) 0.2);
          }
          
          float totalFare = (float) standardFare + bookingFee + adj;
          
          ps.setString(1, username);
          ps.setInt(2, tripId);
          ps.setInt(3, 5);
          ps.setInt(4, 2);
          ps.setFloat(5, totalFare);
          ps.setInt(6, 1);
          ps.setString(7, seatClass);
          ps.setDate(8, new java.sql.Date(Calendar.getInstance().getTime().getTime()));
          ps.setFloat(9, bookingFee);
          
          // Run the query against the DB
          ps.executeUpdate();
        }
        
        st.close();
        db.closeConnection(con);
        response.sendRedirect(request.getContextPath() + "/customerMainPage.jsp");
    %>
  </body>
</html>
