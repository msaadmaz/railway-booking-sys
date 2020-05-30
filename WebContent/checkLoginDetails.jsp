<%@ page  language="java"
          contentType="text/html; charset=ISO-8859-1"
          pageEncoding="ISO-8859-1"
          import="com.cs336.pkg.*"
%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	// Get parameters from login.jsp
	String username = request.getParameter("username");
	String password = request.getParameter("password");
    
    Class.forName("com.mysql.jdbc.Driver");
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement st = con.createStatement();
    
    ResultSet rs;
    rs = st.executeQuery("SELECT * FROM customer where username='" + username + "' AND password='" + password + "'");
    
    
    if (rs.next()) {
	    session.setAttribute("user", username); // the username will be stored in the session
      	System.out.println("DEBUG checkLoginDetails -> setting attributes");
	    session.setAttribute("ssn", null);
	    out.println("welcome " + username);
	    out.println("<a href='logout.jsp'>Log out</a>");
      
	    rs.close();
	    st.close();
	    db.closeConnection(con);
      
	    response.sendRedirect("customerMainPage.jsp");
    } else {
   	  out.println("Invalid password <a href='login.jsp'>try again</a>");
    }
    
    rs.close();
    st.close();
    db.closeConnection(con);
%>