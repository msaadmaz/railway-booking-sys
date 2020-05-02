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
	<p>EDIT Employee</p>
	<% String ssn = request.getParameter("ssn");
	Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("SELECT * FROM employee where ssn='" + ssn + "'");
	if (!rs.next()){
		out.println("No such ssn in Database <a href = 'edit.jsp'> try again </a");				
	}
	else {
	String username =rs.getString("username");
	%>
	<p> Here is the Employee Data</p>
	<ul>
		<li> Username is: <%=username%></li>
		<li> Password is: <%=rs.getString("password")%></li>
		<li> First name is: <%=rs.getString("first_name")%></li>
		<li> Last name is: <%=rs.getString("last_name")%></li>
		<li> Ssn is: <%=ssn%></li>
	</ul>	
		
		<p>Enter Edited Employee Data</p>
	<form action="EditEmployeeJava.jsp">
		<label for="OriginalUsername">Original User name:</label>
  		<input type="text" id="OriginalUsername" name="OriginalUsername" value="<%=username%>"><br><br>
	
		<label for="OriginalSSN">Original SSN:</label>
  		<input type="text" id="OriginalSSN" name="OriginalSSN" value="<%=ssn%>"><br><br>
  		
		<input name="username" type="text" class="text-input" placeholder="Username" />
	    <br />
    	<input name="password" type="password" class="text-input" placeholder="Password" />
  		<br />
    	<input name="firstName" type="text" class="text-input" placeholder="First name" />
   	 	<br />
    	<input name="lastName" type="text" class="text-input" placeholder="Last name" />
	    <br />
		<input name="SSN" type="text" class="text-input" placeholder="SSN" />
	    <br />
		
		<button type="submit" class="gray-button">Edit Account</button>
	</form>
	<%
	}
	%>
	</body>
	</html>
	
		
		
		
	