<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<% 
	Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("Select c.customer_username, sum(total_fare)  as totals from reservation c group by customer_username order by totals desc");
	if (!rs.next()){
		out.println("There are no customers<a href='adminMainPage.jsp'>try again</a>");
		rs.close();
	}
	else {
		out.println("The best customer is: " + rs.getString(1));
		st.close();
        
    	db.closeConnection(con);
	}

	%>
</body>
</html>