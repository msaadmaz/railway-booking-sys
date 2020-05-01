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
	<p> Customer Revenue </p>
	<%
	Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("Select c.customer_username, sum(total_fare)  as totals from reservation c group by customer_username order by totals desc");
    
    if (rs.next()){
		%>
		<TABLE border="1">
		<tr>
		<td>Customer Usermame</td>
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
		out.println("<a href = 'adminMainPage.jsp'>Go back to main page</a");

	}
	
	else{
		out.println("There are no customers <a href = 'adminMainPage.jsp'> try again </a");				
		rs.close();
	
	}
	st.close();
    
    // close the connection
    db.closeConnection(con);
	%>
	</table>
</body>
</html>