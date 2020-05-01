<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Admin</title>
</head>
<body>
  <h1>Admin Main Page</h1>
  <p>Congratulations, you have logged in!</p>
  <br>
  
  <p>What would you like to do:</p>
  <ol>
  	<li><a href="edit.jsp">Add, Edit, Delete employee/customer</a></li>
  	<br>
  	<li>Obtain a sales report for specific month
  		<ul>
  			<li> <form action="SalesReport.jsp" method="POST">
  				 	<input name="month" type="text" class="text-input" placeholder="month number" />
   				 	<input name="year" type="text" class="text-input" placeholder="year" />
  				 	
  				 	<button type="submit" class="gray-button">Get Revenue</button>
  				</form>
  			</li>
  		</ul>
  	</li>
  	<br>
  	<li>Produce a list of reservations
  		<ul>
  			<li> <form action="TransitTrainReservation.jsp" method="POST">
  				 	<input name="Transit Line" type="text" class="text-input" placeholder="Transit Line" />
  				 	<input name="Train Number" type="text" class="text-input" placeholder="Train Number" />
  				 	<button type="submit" class="gray-button">Produce list with transit line and train number</button>
  				</form>
  			</li>
  			<br>
  			<li> <form action="CustomerReservation.jsp" method="POST">
  				 	<input name="Customer name" type="text" class="text-input" placeholder="Customer name" />
  				 	<button type="submit" class="gray-button">Produce list with Customer name</button>
  				</form>
  			</li>
  			
  		</ul>
  	
  	</li>
  	<br>
  	<li>Produce a list of revenue
  		<ul>
  			<li> <a href = "TransitRevenue.jsp"> By transit Line</a></li>
  			<br>
  			<li> <a href="DestinationRevenue.jsp">By Destination</a></li>
  			<br>
  			<li> <a href="CustomerRevenue.jsp"> By Customer</a></li>
  		</ul>
  	
  	</li>
  	<br>
  	<li><a href="BestCustomer.jsp">Find the Best Customer</a></li>
  	
  	<br>
  	<li><a href="MostActiveLines.jsp">Find Most Active transit Lines</a></li>
  	
  </ol>
  
</body>
</html>