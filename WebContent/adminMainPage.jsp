<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
  <h1>Admin Main Page</h1>
  <p>Congratulations, you have logged in!</p>
  <br>
  
  <p>What would you like to do:</p>
  <ol>
  	<li><a href="edit.jsp">Add, Edit, Delete employee/customer</a></li>
  	<li>Obtain a sales report for specific month
  		<ul>
  			<li> <form action="SalesReport.jsp" method="POST">
  				 	<input name="month" type="text" class="text-input" placeholder="month" />
  				 	<button type="submit" class="gray-button">Get Revenue</button>
  				</form>
  			</li>
  		</ul>
  	</li>
  	<li>Produce a list of reservations
  		<ul>
  			<li> <form action="TransitTrainReservation.jsp" method="POST">
  				 	<input name="Transit Line" type="text" class="text-input" placeholder="Transit Line" />
  				 	<input name="Train Number" type="text" class="text-input" placeholder="Train Number" />
  				 	<button type="submit" class="gray-button">Produce list with transit line and train number</button>
  				</form>
  			</li>
  			<li> <form action="CustomerReservation.jsp" method="POST">
  				 	<input name="Customer Username" type="text" class="text-input" placeholder="Customer Username" />
  				 	<button type="submit" class="gray-button">Produce list with Customer Username</button>
  				</form>
  			</li>
  			
  		</ul>
  	
  	</li>
  	<li><a href="ProduceRevenue.jsp">Produce a list of revenue</a></li>
  	<li><a href="BestCustomer.jsp">Find the Best Customer</a></li>
  	<li><a href="MostActiveLines.jsp">Find Most Active transit Lines</a></li>
  	
  </ol>
  
</body>
</html>