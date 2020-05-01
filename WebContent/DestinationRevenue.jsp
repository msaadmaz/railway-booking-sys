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
	<p> Destination Revenue </p>
	<%
	String transitLine = request.getParameter("Destination");
	Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    Statement st = con.createStatement();
    ResultSet rs;
    //rs = st.executeQuery("Select s.name, sum(total_fare)  as totals  from reservation c, station s where c.destination_station = s.id group by s.id order by totals desc");
    rs = st.executeQuery("SELECT s.name, sum(total_fare)  as totals  from reservation r, trip t, route ro, station s where r.trip_id = t.id AND t.route_id = ro.id AND ro.destination_station_id = s.id GROUP BY s.id order by totals desc");

    if (rs.next()){
		%>
		<TABLE border="1">
		<tr>
		<td>Destination Name</td>
		<td>Revenue Generated</td>
		</tr>
		<% 
		do {
			%>
			<TR>
			<TD><%=rs.getString(1)%></TD>
			<TD><%=rs.getInt(2)%></TD>
			</TR>
			<%
		}while(rs.next());
		out.println("<a href = 'adminMainPage.jsp'> Back to main page </a");
	}
	
	else{
		out.println("There are no transit lines <a href = 'adminMainPage.jsp'> try again </a");				
		rs.close();
	
	}
	st.close();
    
    // close the connection
    db.closeConnection(con);
	%>
	</table>
</body>
</html>