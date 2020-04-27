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
	String customerUser = request.getParameter("Customer Username");
	Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("SELECT * FROM Reservation where customer_username='" + customerUser + "'");
	if (!rs.next()){
		out.println("Customer has not made a reservation or does not exist <a href = 'adminMainPage.jsp'> try again </a");				
	}
	%>
	<table>
	<%
	while (rs.next()){
	%>
		<TR>
		<TD><%=rs.getInt(1)%></TD>
		<TD><%=rs.getString(2)%></TD>
		<TD><%=rs.getString(3)%></TD>
		<TD><%=rs.getString(4)%></TD>
		</TR>
	<% 
	}
	%>
</body>
</html>