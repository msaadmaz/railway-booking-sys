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
	<p> Customer Reservations </p>
	<%
	String customerUser = request.getParameter("Customer name");
	Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    Statement st = con.createStatement();
    ResultSet rs;
    String firstName = customerUser.substring(0,customerUser.indexOf(" "));
    String lastName = customerUser.substring(customerUser.indexOf(" ") + 1);
    rs = st.executeQuery("SELECT * FROM reservation r, customer c where c.first_name = '"+firstName +"' and c.last_name = '"+ lastName +"' and c.username = r.customer_username ");
	
    if (rs.next()){
		%>
		<TABLE border="1">
		<tr>
		<td>Reservation Number</td>
		<td>Customer Username</td>
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
		do {
			%>
			<TR>
			<TD><%=rs.getInt(1)%></TD>
			<td><%=rs.getString(2)%></TD>
			<TD><%=rs.getInt(3)%></TD>
			<TD><%=rs.getInt(4)%></TD>
			<TD><%=rs.getInt(5)%></TD>
			<td><%=rs.getInt(6) %></td>
			<td><%=rs.getInt(7) %></td>
			<td><%=rs.getString(8) %></td>
			<td><%=rs.getDate(9) %></td>
			<td><%=rs.getInt(10) %></td>
			<td><%=rs.getString(11) %>
			</TR>
			<%
		}while(rs.next());
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