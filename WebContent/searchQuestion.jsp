<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Question</title>
</head>
<body>

<h1>Search Result</h1>

<%
	//get the searched question from the submission
	String search = request.getParameter("search");

	if( search.equals("") ){
		out.println("You must input  <a href='customerService.jsp'>try again</a>");
	} else {
		Class.forName("com.mysql.jdbc.Driver");

		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		Statement checkSearch = con.createStatement();
		
		ResultSet rs;
		rs = checkSearch.executeQuery("SELECT m.text FROM Message m WHERE m.text = '" + search + "'");
		
		String result = "The question does not exist";
		
		int counter = 0;
		
		while(rs.next()){
			result = rs.getString( 1 );
			counter++;
		}
		
		if( counter == 0 ){
			out.println(result);
		} else {
			Statement getAnswer = con.createStatement();
			ResultSet rs2 = getAnswer.executeQuery("SELECT m.answer FROM Message m WHERE m.text = '" + search + "'");
			
			String answer = "This question has not yet been answered";
			
			while( rs2.next() ){
				answer = rs2.getString( 1 );
			}
			
			out.println("Question: " + result + " Answer: " + answer);
			
			rs2.close();
			getAnswer.close();
		}
		
		rs.close();
	   
	    checkSearch.close();
	    db.closeConnection(con);

	}
	

%>

</body>
</html>