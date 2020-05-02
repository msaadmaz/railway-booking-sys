<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
  <head>
  <meta charset="ISO-8859-1">
  <title>Create Reservation</title>
  </head>
  
  <body>
    <%  ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement st = con.createStatement();
        
        String username = session.getAttribute("user").toString();
        int tripId = Integer.parseInt(request.getParameter("tripId"));
              
        ResultSet rs;
        rs = st.executeQuery("SELECT * FROM reservation WHERE customer_username = '" + username + "' AND trip_id = " + tripId + ";");
        
        if (rs.next()) {
          String delete = "DELETE FROM reservation WHERE customer_username = '" + username + "' AND trip_id = " + tripId + ";";
          
          PreparedStatement st2 = con.prepareStatement(delete);
          st2.execute();
          
          System.out.println("reservation deleted");
    %>
    
    <a href="../customerMainPage.jsp">Home</a>
    
    <%  }
        
        rs.close();
        st.close();
        db.closeConnection(con);
        
        System.out.println("cancel reservation failed");
        
        response.sendRedirect(request.getContextPath() + "/customerMainPage.jsp");
    %>
  </body>
</html>
