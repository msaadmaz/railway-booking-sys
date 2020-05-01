<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Customer Service</title>
	<link rel="stylesheet" type="text/css" href="css/saad.css">
</head>
<body>
  	<%
  		//get the username of the current user and also check to see if they are an employee
  		//if they are an employee they will be allowed to answer questions
  		String username = session.getAttribute("user").toString();
  		boolean isEmployee = true;
      System.out.println("dfhdg");
      
  		if(session.getAttribute("ssn") == null ){
        System.out.println("customer");
  			isEmployee = false;
  		}
      
      System.out.println(session.getAttribute("ssn"));
  	%>
	<div class="topnav">
		<a class="active" href="customerMainPage.jsp">Home</a>
		<div class="search-container">
    		<form action="searchQuestion.jsp">
			<input type="text" placeholder="Search for a question..." name="search">
			<button type="submit">Submit</button>
    		</form>
  		</div>
	</div>

	<h1>Welcome to Customer Service</h1>
		<p>From here you can post or search for any question you have about reservations, train timings, and so forth. It will be answered by a Customer Service Representative</p>
	<br>
  
	<form class="askQ" action ="createMessage.jsp" method="POST">
		<label for="question">Ask a Question: </label>
	    <input id="question" name="question" type="text" class="text-input" placeholder="Enter Question here...">
	    <button type="submit" class="gray-button">Submit</button>
	</form>
	
	<br>
	<br>
	<br>
	
	<h3>Here are the questions that have been asked with their answers: </h3>
	
	<% 
		ArrayList<String> questions = new ArrayList<String>();
		ArrayList<String> answers = new ArrayList<String>();
		
		Class.forName("com.mysql.jdbc.Driver");
	    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
		
		Statement getQuestions = con.createStatement();
		Statement getAnswers = con.createStatement();
		
		ResultSet rs, rs2;
	    rs = getQuestions.executeQuery("SELECT text, answer FROM Message;");
	    
	    while(rs.next()){
	    	questions.add(rs.getString(1));
	    	answers.add(rs.getString(2));
	    }
	    
	    for(int i = 0; i < questions.size(); i++){
        
        out.println(questions.get(i) + " The answer is: " + answers.get(i));
        out.println("<br>");
        
	    	/*
        if( i == 0 ){
	    		continue;
	    	} else {
          System.out.println("testetestd");
	    		out.println(questions.get(i) + " The answer is: " + answers.get(i));
		    	out.println("<br>");
	    	} 
        */
	    }
	%>
	
	<% 
		if( isEmployee ) {
	%>
		<form class="answerQ" action="answerQuestion.jsp" method="POST">
			<label for="Q2A">Answer a Question: </label>
	    	<input id="Q2A" name="Q2A" type="text" class="text-input" placeholder="Enter Question to Answer here...">
	    	<br>
	   		<label for="theAnswer">Enter the Answer: </label>
	    	<input id="theAnswer" name="theAnswer" type="text" class="text-input" placeholder="Enter Answer here...">
	    	<button type="submit" class="gray-button">Submit</button>
		</form>
	<%
		} else {	
	%>
		<h5>These are all of the questions with their answers. Null means the question has not yet been answered.</h5>
	<%
		}
	%>
  
  <br>
  
  <%  Statement delaySt = con.createStatement();
      ResultSet delayRs = delaySt.executeQuery("SELECT t.delay, r.transit_line_name, r.arrival_time, r.depart_time FROM trip t, route r WHERE t.route_id = r.id AND t.delay > 0 GROUP BY t.id;");
  %>
  
      <table>
      <tr>
        <th>Transit Line</th>
        <th>Arrival Time</th>
        <th>Departure Time</th>
        <th>Delay</th>
      </tr>
      
      <%  while (delayRs.next()) { %>
            <tr>
              <td><%= delayRs.getString("transit_line_name") %></td>
              <td><%= delayRs.getDate("arrival_time") %></td>
              <td><%= delayRs.getString("depart_time") %></td>
              <td><%= delayRs.getInt("delay") %></td>
            </tr>
      <%  } %>
    </table>
  <%
      delayRs.close();
      rs.close();
      delaySt.close();
      getQuestions.close();
      db.closeConnection(con);
  %>

</body>
</html>