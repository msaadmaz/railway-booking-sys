<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Message</title>
</head>
<body>

<%
	//get the question from the submission
	String question = request.getParameter("question");
	String username = session.getAttribute("user").toString();
	
	//If they never entered a question take them back
	if(question.equals("")){
		out.println("You must input question <a href='customerService.jsp'>try again</a>");
	} 
	
	
	// Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	//Create a SQL Statement
	Statement insertM = con.createStatement();
				
	//prevent duplicate questions			
	ResultSet rs;
    rs = insertM.executeQuery("SELECT * FROM Message where text = '" + question + "'");
				
	if( rs.next() ){
		rs.close();
		
		out.println("Question already exists. <a href='customerService.jsp'>Ask another Question</a>");
	} else{
		// Make an insert statement for the User table:
	    String insert = "INSERT INTO Message(text, customer_username, answered_by, answer)"
	        + "VALUES (?, ?, ?, ?)";
					
	 	// Create a Prepared SQL statement allowing you to introduce the parameters of the query
	    PreparedStatement ps = con.prepareStatement(insert);
					
		// Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	    ps.setString(1, question);
		ps.setString(2, username);
		ps.setString(3, null);
		ps.setString(4, null);
		
		// Run the query against the DB
        ps.executeUpdate();
		
     	// close statement
        insertM.close();
     	
     	// close the connection
        db.closeConnection(con);
     	
     	// go back to customer service page
        response.sendRedirect("customerService.jsp");
	}

%>

</body>
</html>
