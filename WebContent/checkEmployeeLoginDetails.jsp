<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
		// Get parameters from login.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String ssn = "";
		
    
    Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    Statement st = con.createStatement();
    Statement st2 = con.createStatement();
    
    ResultSet rs;
    rs = st.executeQuery("SELECT * FROM employee where username='" + username + "' AND password='" + password + "'");
    
    if (rs.next()) {
	    session.setAttribute("user", username); // the username will be stored in the session
	    out.println("welcome " + username);
	    out.println("<a href='logout.jsp'>Log out</a>");
	    
	    ResultSet rs2;
	    rs2 = st2.executeQuery("SELECT e.ssn FROM Employees e where e.username='" + username + "' AND e.password='" + password + "'");
	    
	    //to be able to identify Employees from customers on mutual pages
	    while( rs2.next()){
	   		ssn = rs2.getString(1);
	    }
	    session.setAttribute("ssn", ssn);
	    
	    // check if manager/admin account
	    // SELECT e.isManager FROM Employees e WHERE e.username = username
	    
	    if (rs.getInt("is_manager") == 0) {
	    	response.sendRedirect("employeeMainPage.jsp");
	    } else {
	    	response.sendRedirect("adminMainPage.jsp");
	    }
	    rs2.close();
    } else {
   	  out.println("Invalid password <a href='login.jsp'>try again</a>");
    }
    
    st.close();
   	st2.close();
    con.close();
   	rs.close();
%>