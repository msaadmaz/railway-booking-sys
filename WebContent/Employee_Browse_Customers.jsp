<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Employee Customer Browser</title>
  
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
	
	<h2>Employee: Browse Customers by Train and Transit Line</h2>
 	<br>
 	<br>
 	
 	
 	
 	
 	
 	
 	
 	<p> Transit Lines and their Trains</p>
	<%
	Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    Statement st = con.createStatement();
    ResultSet rs;
    //rs = st.executeQuery("Select s.name, sum(total_fare)  as totals  from reservation c, station s where c.destination_station = s.id group by s.id order by totals desc");
    
    // OG query from DestinationRevenue page
    //rs = st.executeQuery("SELECT s.name, sum(total_fare)  as totals  from reservation r, trip t, route ro, station s where r.trip_id = t.id AND t.route_id = ro.id AND ro.destination_station_id = s.id GROUP BY s.id order by totals desc");

    
    
    // PRINT OUT THE TRANSIT LINE NAME, THEN THE TRAINS THAT ARE A PART OF THAT LINE
    rs = st.executeQuery("SELECT " +
    		"rt.transit_line_name, " +
    		"trn.id " +
    	"FROM " +
    		"route rt " +
    		"left join train trn on rt.id = trn.route_id;");
    
    
    if (rs.next()){
		%>
		<TABLE border="1">
		<tr>
		<td>Transit Line Name</td>
		<td>Train ID</td>
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
		out.println("<a href = 'employeeMainPage.jsp'> Back to Employee Main Page </a");
	}
	
	else{
		out.println("There are no Transit Lines and Trains at this time");				
	
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
 	
 	Search Customers by Transit Line and Train ID
	<form method="get" action="Employee_Search_Line_Train.jsp">
		<table>
			<tr>    
				<td>Transit Line Name</td><td><input type="text" name="transit_line_name"></td>
			</tr>
			<tr>    
				<td>Train ID</td><td><input type="text" name="train_id"></td>
			</tr>
		</table>
		<input type="submit" value="Search Database">
	</form>
	<br>
	<br>
  
  
</body>
</html>