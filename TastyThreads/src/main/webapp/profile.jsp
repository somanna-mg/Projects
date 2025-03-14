<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<html>
<head>
    <title>Profile</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h2>Welcome to Your Profile</h2>

    <% 
    	HttpSession session1 = request.getSession(false);
        if (session1 == null || session1.getAttribute("userId") == null) { 
    %>
        <p>You are not logged in. <a href="login.jsp">Login here</a></p>
    <% } else { %>
        <p>Hello, <%= session.getAttribute("username") %>!</p>
        <p><a href="logout">Logout</a></p>
    <% } %>
</body>
</html>
