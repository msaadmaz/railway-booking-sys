<%
  // invalidates http session
	session.invalidate();

  // redirects back to login page
	response.sendRedirect("login.jsp");
%>