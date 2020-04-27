<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<p>What would you like to do:</p>
	<ol>
		<li><a href="CreateAccountFormForAdmin.jsp">Add Customer</a></li>
		
  		<li><a href="createEmployeeAcountForm.jsp">Add employee</a></li>
  		
  		
  		<li>Edit Customer Information
  			<ul>
  				<li> <form action="EditCustomer.jsp" method="POST">
  					 	<input name="username" type="text" class="text-input" placeholder="Username" />
  					 	<button type="submit" class="gray-button">Edit User name</button>
  					</form>
  				</li>
  			</ul>
  		</li>
  		<li>Delete Customer
  			<ul>
  				<li> <form action="DeleteCustomer.jsp" method="POST">
  					 	<input name="username" type="text" class="text-input" placeholder="Username" />
  					  	<button type="submit" class="gray-button">Delete Account</button>
  					
  					</form>
  					
  				</li>
  			</ul>
  		</li>
 	 	<li>Edit Employee Information
 	 		<ul>
  				<li> <form action="EditEmployee.jsp" method="POST">
  					 	<input name="ssn" type="text" class="text-input" placeholder="ssn" />
   					  	<button type="submit" class="gray-button">Edit Employee</button>
  					
  					</form>
  				</li>
  			</ul>
 	 	
 	 	</li>
  		<li>Delete Employee
  			<ul>
  				<li> <form action="DeleteEmployee.jsp" method="POST">
  					 	<input name="ssn" type="text" class="text-input" placeholder="Username" />
   					  	<button type="submit" class="gray-button">Delete Account</button>
  					 	
  					</form>
  				</li>
  			</ul>
  		</li>
	</ol>
  
</body>
</html>