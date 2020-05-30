<%@ page import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Station Schedule</title>
</head>
<body>
	<p> Station Schedule</p>
	<%
	Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    // Get input from Browse
    String Transit_Line_Name = request.getParameter("transit_line_name");
    String Train_ID = request.getParameter("train_id");

    Statement st = con.createStatement();
    ResultSet rs;
    //rs = st.executeQuery("Select s.name, sum(total_fare)  as totals  from reservation c, station s where c.destination_station = s.id group by s.id order by totals desc");
    
    // OG query from DestinationRevenue page
    //rs = st.executeQuery("SELECT s.name, sum(total_fare)  as totals  from reservation r, trip t, route ro, station s where r.trip_id = t.id AND t.route_id = ro.id AND ro.destination_station_id = s.id GROUP BY s.id order by totals desc");

    
    // my test query for some testing and stuff
    //rs = st.executeQuery("SELECT s.name, s.id FROM station s WHERE s.name = '" + Station_Name_Input + "'");
    		
    // Execute a query based on the train station entered and get all the available routs and shiiieeettt
    rs = st.executeQuery("SELECT " + 
    		"cst.first_name, " +
    	    "cst.last_name, " +
    	    "rsv.trip_id AS Reservation_trip_id, " +
    	    "rsv.seat_class AS Seat_Class, " +
    	    "rsv.date_made AS Date_Made, " +
    	    "rsv.total_fare AS Total_Fare " +
    	"FROM reservation rsv " +
    			"LEFT JOIN customer cst on rsv.customer_username = cst.username " +
    	        "LEFT JOIN trip trp on rsv.trip_id = trp.id " +
    	        "LEFT JOIN route rt on trp.route_id = rt.id " +
    	"WHERE " +
    		"trp.train_id = '" + Train_ID + "' " + 
    	    "AND " +
    	    "rt.transit_line_name = '" + Transit_Line_Name + "' " +
    	"ORDER BY cst.last_name;");
    
    		
    if (rs.next()){
		%>
		<TABLE border="1">
		<tr>
		<td>First Name</td>
		<td>Last Name</td>
		<td>Trip ID</td>
		<td>Seat Class</td>
		<td>Date Made</td>
		<td>Total Fare</td>
		<% 
		do {
			%>
			<TR>
			<TD><%=rs.getString(1)%></TD>
			<TD><%=rs.getString(2)%></TD>
			<TD><%=rs.getInt(3)%></TD>
			<TD><%=rs.getString(4)%></TD>
			<TD><%=rs.getDate(5)%></TD>
			<TD><%=rs.getFloat(6)%></TD>
			</TR>
		<%
		}while(rs.next());
		out.println("<a href = 'employeeMainPage.jsp'> Back to Employee Main Page </a");
	}
	
	else{
		out.println("There are no Stations by that name <a href = 'Employee_Browse_Schedule.jsp'> try again </a");				
		rs.close();
	
	}
	st.close();
			
	
	
	
    
    // close the connection
    db.closeConnection(con);
	%>
	</table>
</body>
</html>