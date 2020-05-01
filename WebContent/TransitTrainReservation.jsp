<%@ page import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<p> Train Reservations </p>
	<%
	String transitLine = request.getParameter("Transit Line");
	String train = request.getParameter("Train Number");
	int trainNum = Integer.parseInt(train);
	Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    Statement st = con.createStatement();
    ResultSet rs;    
    rs = st.executeQuery("SELECT r.res_num, r.customer_username, r.trip_id, r.origin_station,r.destination_station, r.total_fare, r.seat_num, r.seat_class, r.date_made, r.booking_fee, r.employee_username FROM reservation r, train t, trip tr, route ro WHERE t.id = 1007 AND ro.transit_line_name = 'South Line' AND r.trip_id = tr.id AND tr.route_id = ro.id");
    //rs = st.executeQuery("Select r.res_num,r.customer_username, r.trip_id,r.origin_station,r.destination_station, r.total_fare, r.seat_num,r.seat_class, r.date_made, r.booking_fee, r.employee_username from  reservation r, trip t where (r.trip_id = t.id and t.train_id = " + trainNum + ") and (r.res_num,r.customer_username, r.trip_id,r.origin_station,r.destination_station, r.total_fare, r.seat_num,r.seat_class, r.date_made, r.booking_fee, r.employee_username) in (Select r.res_num,r.customer_username, r.trip_id,r.origin_station,r.destination_station, r.total_fare, r.seat_num,r.seat_class, r.date_made, r.booking_fee, r.employee_username from reservation r, trip t, route s where r.trip_id = t.id and t.route_id = s.id and s.transit_line_name = '"+transitLine + "')");
	rs.beforeFirst();
    if (rs.next()){
		%>
		<TABLE border="1">
		<tr>
		<td>Reservation Number</td>
		<td>Trip ID</td>
		<td>Origin Station</td>
		<td>Destination Station</td>
		<td>Total Fare</td>
		<td>Seat Number</td>
		<td>Class</td>
		<td>Date Made</td>
		<td>Booking Fee</td>
		<td>Employee Username</td> 
		</tr>
		<% 
		do{
			%>
			<TR>
			<TD><%=rs.getInt(1)%></TD>
			<TD><%=rs.getInt(3)%></TD>
			<TD><%=rs.getInt(4)%></TD>
			<TD><%=rs.getInt(5)%></TD>
			<td><%=rs.getInt(6) %></td>
			<td><%=rs.getInt(7) %></td>
			<td><%=rs.getString(8) %></td>
			<td><%=rs.getDate(9) %></td>
			<td><%=rs.getInt(10) %></td>
			<td><%=rs.getString(11) %></td>
			</TR>
			<%
		}while(rs.next());
		//while(rs.next());
		out.println("<a href = 'adminMainPage.jsp'>Go back to main page</a");
	}
	
	
	else{
		out.println("Customer has not made a reservation or does not exist <a href = 'adminMainPage.jsp'> try again </a");				
		rs.close();
	
	}
	st.close();
    
    // close the connection
    db.closeConnection(con);
	%>
	</table>
</body>
</html>