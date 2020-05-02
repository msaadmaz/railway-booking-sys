<!DOCTYPE html>
<html>
<head>
  <title>JJMT Railways</title>
  <link rel="stylesheet" type="text/css" href="css/main.css">
</head>

<body>
  <form action="checkLoginDetails.jsp" method="POST">
    <label for="username">Username</label>
    <input id="username" name="username" type="text" class="text-input" />
    <br />
    
    <label for="password">Password</label>
    <input id="password" name="password" type="password" class="text-input" />
    <br />

    <button type="submit" class="gray-button">Submit</button>
  </form>

  <a href="createAccountForm.jsp" class="gray-button">Create Account</a>
</body>
</html>