<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<body>
  <form action="createAccount.jsp" method="POST">
  <!--
    <input name="firstName" type="text" placeholder="First name" />
    <br />
    <input name="lastName" type="text" placeholder="Last name" />
    <br />
    <input name="phone" type="text" placeholder="Phone number" />
    <br />
    <input name="street" type="text" placeholder="Street" />
    <br />
    <input name="city" type="text" placeholder="City" />
    <br />
    <input name="state" type="text" placeholder="State" />
    <br />
    <input name="zip" type="text" placeholder="Zip code" />
    <br />
    <input name="email"type="email" placeholder="Email" />
    <br />
    -->
    <input name="username" type="text" placeholder="Username" />
    <br />
    <input name="password" type="password" placeholder="Password" />
    <br />
    <button type="submit">Create Account</button>
  </form>
</body>