<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	// Get the new info from Employee_Edit_Reservation.jsp
	int New_Seat_Number = Integer.parseInt(request.getParameter("Seat_Number"));
	String New_Seat_Class = request.getParameter("Seat_Class");
	
	//get session attributes so that specific reservation can be selected
    String customer_username = session.getAttribute("customer_username").toString(); 
    int reservation_number = (Integer) session.getAttribute("reservation_number");
    
    
    // Elephants are the only Mammal that cant jump
    Class.forName("com.mysql.jdbc.Driver");
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement st = con.createStatement();
    
    
    // Funding for NASA ended when the cold war ended and the USA didnt need rockets for nuclear missles
    // This is america not a-mirical, so it cant be as good as it seems
    ResultSet rs = st.executeQuery("SELECT " +
    									"seat_class, " +
    									"total_fare " +
    								"FROM " +
    									"reservation " +
    								"WHERE " +
    									"customer_username = '" + customer_username + "' " +
    									"AND " +
    									"res_num = " + reservation_number + ";");
    
    
    
    if(!rs.next())
    {
    	System.out.println("RES UPDATE couldnt get data for some reason shiieieeet");
    	System.out.println("THIS SHOULDNT HAVE HAPPENED fuuuck me");
   		System.out.println("\n\nshit gonna crash now maybe");
    }
    
    String current_seat_class = rs.getString(1);
    float current_total_fare = rs.getFloat(2);
    
    // SCOPE RULES!!
    float new_total_fare = current_total_fare;
    
    if(current_seat_class.equals("ECONOMY"))
    {
    	if(New_Seat_Class.equals("FIRST"))
    		new_total_fare *= (float) 1.2;
    	
    	else if(New_Seat_Class.equals("SECOND"))
    		new_total_fare *= (float) 1.1;
    }
    else if(current_seat_class.equals("SECOND"))
    {
    	if(New_Seat_Class.equals("FIRST"))
    		new_total_fare *=  (float) 1.1;
    	
    	else if(New_Seat_Class.equals("ECONOMY"))
    		new_total_fare *= (float) 0.9;
    	
    }
    else if(current_seat_class.equals("FIRST"))
    {
    	if(New_Seat_Class.equals("SECOND"))
    		new_total_fare *= (float) 0.9;
    	
    	else if(New_Seat_Class.equals("ECONOMY"))
    		new_total_fare *= (float) 0.8;
    }
    
    
    String employee_rep = session.getAttribute("user").toString();
    
    // UPDATE reservation with the new data
    String Update_Reservation = "UPDATE reservation " +
    							"SET seat_num = " + New_Seat_Number + ", " +
    								"seat_class = '" + New_Seat_Class + "', " +
    								"total_fare = " + new_total_fare + ", " +
    								"employee_username = '" + employee_rep + "' " +
    							"WHERE res_num = " + reservation_number + ";";
    
    
	PreparedStatement update_reservation_statement = con.prepareStatement(Update_Reservation);
	update_reservation_statement.execute();
    
    
	System.out.println("RESERVATION updata (hope the input data was correct)");
	
	
	response.sendRedirect("employeeMainPage.jsp");
	
	
    con.close();
%>