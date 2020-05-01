<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<% 

	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

// Create a SQL statement

	String originalSSN = request.getParameter("OriginalSSN");
	String originalUsername = request.getParameter("OriginalUsername");
	String Username = request.getParameter("username");
	String password = request.getParameter("password");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String newSSN = request.getParameter("SSN");
	
	
    Statement stmt = con.createStatement();

	ResultSet rs;
	boolean isUnique = true;
	
	if (!originalUsername.equals(Username)){
		

	    rs = stmt.executeQuery("SELECT * FROM employee where username = '" + Username + "'");
		if (rs.next()){
			out.println("Username already exists <a href='adminMainPage.jsp'>try again</a>");
			isUnique = false;
	  		rs.close();
		}
	}
    else if(!newSSN.equals(originalSSN)) {
    	rs = stmt.executeQuery("SELECT * FROM employee where ssn = '" + newSSN + "'");
    	if (rs.next()){
    		out.println("SSN already exists <a href='adminMainPage.jsp'>try again</a>");
			isUnique = false;
      		rs.close();
    	}
    }
    
    
    if(isUnique){
		String sql = "Update employee set username=?, password=?, ssn=?, first_name=?, last_name=?,is_manager=? where ssn= '"+originalSSN +"'";
		PreparedStatement ps = con.prepareStatement(sql);

        // Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
        ps.setString(1, Username);
        ps.setString(2, password);
        ps.setString(3, newSSN);
        ps.setString(4, firstName);
        ps.setString(5,lastName);
        ps.setInt(6, 0);
		ps.executeUpdate();

   		response.sendRedirect("adminMainPage.jsp");
    }
	db.closeConnection(con);

   %>