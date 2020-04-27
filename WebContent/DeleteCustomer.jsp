<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
		// Get parameters from edit.jsp
		String username = request.getParameter("username");
    
    Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    
    
    String query = "delete from Customer where username = ?";
    PreparedStatement statement = con.prepareStatement(query);
    statement.setString(1, username);
    statement.execute();
    
    
    con.close();
    out.println("<a href='logout.jsp'>Go back to main page</a>");
    response.sendRedirect("adminMainPage.jsp");
%>