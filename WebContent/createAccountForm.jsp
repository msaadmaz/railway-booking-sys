<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<head>
  <title>JJMT Railways</title>
  <link rel="stylesheet" type="text/css" href="css/main.css">
</head>

<body>
  <form action="createAccount.jsp" method="POST">
    <input name="username" type="text" class="text-input" placeholder="Username" />
    <br />
    <input name="password" type="password" class="text-input" placeholder="Password" />
    <br />
    <input name="firstName" type="text" class="text-input" placeholder="First name" />
    <br />
    <input name="lastName" type="text" class="text-input" placeholder="Last name" />
    <br />
    <input name="email"type="email" class="text-input" placeholder="Email" />
    <br />
    <input name="phone" type="text" class="text-input" placeholder="Phone number" />
    <br />
    <input name="street" type="text" class="text-input" placeholder="Street" />
    <br />
    <input name="city" type="text" class="text-input" placeholder="City" />
    <br />
    <input name="state" type="text" class="text-input" placeholder="State" />
    <br />
    <input name="zip" type="text" class="text-input" placeholder="Zip code" />
    <br />
    <button type="submit" class="gray-button">Create Account</button>
  </form>
</body>