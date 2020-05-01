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
	<p>EDIT CUSTOMER</p>
	<% String username = request.getParameter("username");
	Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    Statement st = con.createStatement();
    
    ResultSet rs;
    rs = st.executeQuery("SELECT * FROM customer where username='" + username + "'");
	if (!rs.next()){
		out.println("No such username in Database <a href = 'edit.jsp'> try again </a");				
	}
	%>
	<p> Here is the customer Data</p>
	<ul>
		<li> Last name is: <%=rs.getString("last_name")%></li>
		<li> First name is: <%=rs.getString("first_name")%></li>
		<li> phone number is: <%=rs.getString("phone")%></li>
		<li> Street is: <%=rs.getString("address")%></li>
		<li> City is: <%=rs.getString("city")%></li>
		<li> State is: <%=rs.getString("state")%></li>
		<li> Zip is: <%=rs.getInt("zip")%></li>
		<li> Email Address is: <%=rs.getString("email")%></li>
		<li> Username is: <%=username %></li>
		<li> Password is: <%=rs.getString("password")%></li>
	</ul>
	<p>Enter Edited Customer Data</p>
	<form action="EditAccountJava.jsp">
	
		<label for="OriginalUsername">Original Username:</label>
  		<input type="text" id="OriginalUsername" name="OriginalUsername" value="<%=username%>"><br><br>
  		
		<input name="username" type="text" class="text-input" placeholder="Username" />
	    <br />
    	<input name="password" type="password" class="text-input" placeholder="Password" />
  		<br />
    	<input name="firstName" type="text" class="text-input" placeholder="First name" />
   	 	<br />
    	<input name="lastName" type="text" class="text-input" placeholder="Last name" />
	    <br />
    	<input name="email"type="email" class="text-input" placeholder="Email" />
    	<br />
    	<input name="phone" type="text" class="text-input" placeholder="Phone number" />
    	<br />
    	<input name="street" type="text" class="text-input" placeholder="Street" />
    	<br />
    	<input name="city" type="text" class="text-input" placeholder="City" />
    	<br />
    	<input name="state" type="text" class="text-input" placeholder="State" />
    	<br />
   	 	<input name="zip" type="text" class="text-input" placeholder="Zip code" />
    	<br />
    	<button type="submit" class="gray-button">Edit Account</button>
	</form>
	</body>
</html>
	
	
