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
    <input name="firstName" type="text" class="text-input" placeholder="First name" />
    <br />
    <input name="lastName" type="text" class="text-input" placeholder="Last name" />
    <br />
    <input name="ssn" type="text" class="text-input" placeholder="SSN" />
    <br />
    <button type="submit" class="gray-button">Create Account</button>
  </form>
</body>