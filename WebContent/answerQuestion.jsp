<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer Question</title>
</head>
<body>

<%
	//get the username and ssn of the employee
	String username = session.getAttribute("user").toString();
	String ssn = session.getAttribute("ssn").toString();
	
	//get the question to answer and its answer
	String q2a = request.getParameter("Q2A");
	String answer = request.getParameter("theAnswer");
	
	//setup everything needed for databasae communication and work
	Class.forName("com.mysql.jdbc.Driver");

	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	Statement checkQuestion = con.createStatement();
	
	
	if(q2a.equals("") || answer.equals("")){
		out.println("You must input a question to answer. <a href='customerService.jsp'>try again</a>");
	} else {
		
		//check to see if the question is in the database
		ResultSet rs;
		rs = checkQuestion.executeQuery("SELECT text FROM Message WHERE text = '"+q2a+"' AND answer IS NULL");
		if( rs.next() == false ){
			out.println("You must input a question shown on the other page. Also the question should not have been answered. <a href='customerService.jsp'>try again</a>");
		} else {
			Statement enterAnswer = con.createStatement();
			//ResultSet rs2;
			//rs2 = enterAnswer.executeQuery("UPDATE Message SET answer = '"+answer+"', answered_by = '"+username+"' WHERE text = '"+q2a+"'");
			
			//Make an update statement for the Message table
			String update = "UPDATE Message SET answer=?, answered_by=? WHERE text='"+q2a+"'";
			PreparedStatement ps2 = con.prepareStatement(update);
			ps2.setString(1, answer);
			ps2.setString(2, username);
			ps2.executeUpdate();
			
			
			// Make an insert statement for the responds_to table:
		    String insert = "INSERT INTO responds_to(ssn, text)"
		        + "VALUES (?, ?)";
						
		 	// Create a Prepared SQL statement allowing you to introduce the parameters of the query
		    PreparedStatement ps = con.prepareStatement(insert);
						
			// Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		    ps.setString(1, ssn);
			ps.setString(2, q2a);
			
			// Run the query against the DB
	        ps.executeUpdate();
			
			//close everything
			rs.close();
			checkQuestion.close();
			enterAnswer.close();
			db.closeConnection(con);
			
	    	// go back to customer service page
	        response.sendRedirect("customerService.jsp");
		}
	}
%>

</body>
</html>