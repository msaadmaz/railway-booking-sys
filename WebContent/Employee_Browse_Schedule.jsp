<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Employee Train Schedule Browser</title>
  
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
  
  <!-- 
	<div class="login-container">
		<a href="employeeMainPage.jsp" class="gray-button">Return to Main Page</a>
	</div>
	
  
  <h2>Employee: Browse Train Schedule</h2>
  <br>
  
  
  <p> OPTIONS BELOW THIS </p>
  <br>
  <br>
  Search by Origin-Destination
  <form action="Employee_Search_Origin_Destination.jsp" method="POST">
	    <label for="origin">Origin</label>
	    <input id="origin" name="origin" type="text" class="text-input" />
	    <br />
	    
	    <label for="destination">Destination</label>
	    <input id="destination" name="destination" type="text" class="text-input" />
	    <br />
	    
	    <button type="submit" class="gray-button">Search</button>
	</form>
	<br>
	<br>
	
	-->
	
	<h2>Employee: Browse Train Schedule</h2>
 	<br>
 	<br>
 	
 	
 	
 	
 	
 	
 	
 	<p> Stations to choose from</p>
	<%
	Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    Statement st = con.createStatement();
    ResultSet rs;
    //rs = st.executeQuery("Select s.name, sum(total_fare)  as totals  from reservation c, station s where c.destination_station = s.id group by s.id order by totals desc");
    
    // OG query from DestinationRevenue page
    //rs = st.executeQuery("SELECT s.name, sum(total_fare)  as totals  from reservation r, trip t, route ro, station s where r.trip_id = t.id AND t.route_id = ro.id AND ro.destination_station_id = s.id GROUP BY s.id order by totals desc");

    rs = st.executeQuery("SELECT s.id, s.name, s.state, s.city FROM station s");
    
    
    if (rs.next()){
		%>
		<TABLE border="1">
		<tr>
		<td>Station ID</td>
		<td>Name</td>
		<td>State</td>
		<td>City</td>
		</tr>
		<% 
		do {
			%>
			<TR>
			<TD><%=rs.getInt(1)%></TD>
			<TD><%=rs.getString(2)%></TD>
			<TD><%=rs.getString(3)%></TD>
			<TD><%=rs.getString(4)%></TD>
			</TR>
			<%
		}while(rs.next());
		out.println("<a href = 'employeeMainPage.jsp'> Back to Employee Main Page </a");
	}
	
	else{
		out.println("There are no Stations at this time");				
	
	}
    rs.close();
	st.close();
    
    // close the connection
    db.closeConnection(con);
	%>
	</table>
	<br>
	<br>
	<br>
 	
 	Search by Origin-Destination
	<form method="get" action="Employee_Search_Origin_Destination.jsp">
		<table>
			<tr>    
				<td>Origin Station Name</td><td><input type="text" name="origin"></td>
			</tr>
			<tr>    
				<td>Destination Station Name</td><td><input type="text" name="destination"></td>
			</tr>
		</table>
		<input type="submit" value="Search Database">
	</form>
	<br>
	<br>
 	 
	Search by Station
	<form method="get" action="Employee_Search_Station.jsp">
		<table>
			<tr>    
				<td>Station Name</td><td><input type="text" name="station_name"></td>
			</tr>
		</table>
		<input type="submit" value="Search Database">
	</form>

  
  
</body>
</html>