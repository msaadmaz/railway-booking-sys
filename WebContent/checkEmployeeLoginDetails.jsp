<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
		// Get parameters from login.jsp
		String ssn = request.getParameter("ssn");
    
    Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    Statement st = con.createStatement();
    
    ResultSet rs;
    rs = st.executeQuery("SELECT * FROM Employees where ssn='" + ssn + "'");
    
    if (rs.next()) {
	    session.setAttribute("ssn", ssn); // the ssn will be stored in the session
	    out.println("welcome " + ssn);
	    out.println("<a href='logout.jsp'>Log out</a>");
	    response.sendRedirect("employeeMainPage.jsp");
    } else {
   	  out.println("Invalid login <a href='login.jsp'>try again</a>");
    }
    
    st.close();
    con.close();
%>