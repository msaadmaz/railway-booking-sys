<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
  <head>
  <meta charset="ISO-8859-1">
  <title>Employee Delete Reservation</title>
  </head>
  
  <body>
    <%  ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement st = con.createStatement();
        
        String customer_username = session.getAttribute("customer_username").toString();
        int reservation_number = Integer.parseInt(request.getParameter("reservation_number"));
        
        
        // just double check that it is there (pretty much impossible that it isnt...but anyway)
        ResultSet rs;
        rs = st.executeQuery("SELECT " +
				        		"rsv.trip_id, " +
				        	    "trp.available_seats " +
				        	"FROM " +
				        		"reservation rsv " +
				        	    "LEFT JOIN trip trp on rsv.trip_id = trp.id " +
				        	"WHERE " +
				        		"rsv.customer_username = '" + customer_username + "' " +
				        	    "AND " +
				        	    "rsv.res_num = " + reservation_number + ";");
        
        if (rs.next()) {
        	
        	int trip_id = rs.getInt(1);
        	int number_of_available_seats = rs.getInt(2);
        	
        	// add one to the available seats
        	number_of_available_seats += 1;
        	
        	System.out.println("Trip id based on reservation number " + trip_id);
        	System.out.println("The number of seats currently available = " + number_of_available_seats);
        	
        	String Update_Trip = "UPDATE trip " +
        							"SET available_seats = " + number_of_available_seats + " " +
        							"WHERE id = " + trip_id + ";";
        													
			PreparedStatement update_trip_statement = con.prepareStatement(Update_Trip);
			update_trip_statement.execute();
        	
			String Delete_Reservation = "DELETE FROM reservation WHERE customer_username = '" + customer_username + "' AND res_num = " + reservation_number + ";";
			
			PreparedStatement delete_reservation_statement = con.prepareStatement(Delete_Reservation);
			delete_reservation_statement.execute();
			
			System.out.println("SUCCESS: Employee Reservation Delete");
			System.out.println("Res_num deleted for customer " + customer_username + " res = " + reservation_number);
			
    	}
        else
        {
        	System.out.println("Awww shiiieeeet somthing bad done happened. the fuck goin on");
        }
        
        rs.close();
        st.close();
        db.closeConnection(con);
        
        //response.sendRedirect(request.getContextPath() + "/Employee_Main_Page.jsp");
        response.sendRedirect(request.getContextPath() + "/employeeMainPage.jsp");
    %>
  </body>
</html>
