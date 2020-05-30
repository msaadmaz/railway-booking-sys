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
    String Station_Name_Input = request.getParameter("station_name");

    Statement st = con.createStatement();
    ResultSet rs;
    //rs = st.executeQuery("Select s.name, sum(total_fare)  as totals  from reservation c, station s where c.destination_station = s.id group by s.id order by totals desc");
    
    // OG query from DestinationRevenue page
    //rs = st.executeQuery("SELECT s.name, sum(total_fare)  as totals  from reservation r, trip t, route ro, station s where r.trip_id = t.id AND t.route_id = ro.id AND ro.destination_station_id = s.id GROUP BY s.id order by totals desc");

    
    // my test query for some testing and stuff similar to testing 
    //rs = st.executeQuery("SELECT s.name, s.id FROM station s WHERE s.name = '" + Station_Name_Input + "'");
    		
    // Execute a query based on the train station entered and get all the available routs and shiiieeettt
    rs = st.executeQuery("SELECT " +
    	    "stn_orgn.name as Origin_Station_name, " +
    	    "stn_dest.name as Destingation_Station_name, " +
    	    "rt.transit_line_name as Line_Name, " +
    	    "rt.standard_fare as Standard_Fare, " +
    	    "rt.travel_time as Travel_Time, " +
    	    "rt.depart_time AS Departure_Time, " +
    	    "rt.arrival_time AS Arrival_Time, " +
    	    "trn.id AS Train_ID, " +
    	   	"trn.total_seats AS Train_Seats, " +
    	   	"trn.num_cars AS Train_Num_Cars " +
    	"FROM route rt " +
    	 "left join station stn_orgn on stn_orgn.id = rt.origin_station_id " +
    	 "left join station stn_dest on stn_dest.id = rt.destination_station_id " +
    	 "left join train trn on trn.route_id = rt.id " +
    		"WHERE " +
    			"stn_orgn.name = '" + Station_Name_Input + "' " +
    	        "or " +
    	        "stn_dest.name = '" + Station_Name_Input + "' " +
    	"ORDER BY stn_orgn.name;");
    
    		
    if (rs.next()){
		%>
		<TABLE border="1">
		<tr>
		<td>Origin Station</td>
		<td>Destination Station</td>
		<td>Transit Line </td>
		<td>Standard Fare</td>
		<td>Travel Time</td>
		<td>Departure Time</td>
		<td>Arrival Time</td>
		<td>Train ID</td>
		<td>Number of Seats</td>
		<td>Number of Cars</td>
		<% 
		do {
			%>
			<TR>
			<TD><%=rs.getString(1)%></TD>
			<TD><%=rs.getString(2)%></TD>
			<TD><%=rs.getString(3)%></TD>
			<TD><%=rs.getFloat(4)%></TD>
			<TD><%=rs.getInt(5)%></TD>
			<TD><%=rs.getTime(6)%></TD>
			<TD><%=rs.getTime(7)%></TD>
			<TD><%=rs.getInt(8)%></TD>
			<TD><%=rs.getInt(9)%></TD>
			<TD><%=rs.getInt(10)%></TD>
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