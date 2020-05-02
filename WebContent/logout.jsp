<%
  // invalidates http session
	session.invalidate();

  // redirects back to login page
	response.sendRedirect(request.getContextPath() + "/login.jsp");
%>