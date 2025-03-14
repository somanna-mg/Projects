<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup - Recipe Review</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header class="header">
        <div class="header-container">
            <a href="index" class="logo">Recipe Review</a>
            <ul class="nav-links">
                <li><a href="index">Home</a></li>
                <li><a href="search-recipes.jsp">Recipes</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </div>
    </header>

    <div class="container">
        <div class="form-container">
            <h2 class="form-title">User Registration</h2>
            
            <% String message = request.getParameter("message");
               if (message != null) { %>
                <div class="alert alert-error">
                    <%= message %>
                </div>
            <% } %>
            
            <form action="signup" method="post">
                <div class="form-group">
                    <label for="username" class="form-label">Username:</label>
                    <input type="text" id="username" name="username" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" id="email" name="email" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">Password:</label>
                    <input type="password" id="password" name="password" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label for="profilePic" class="form-label">Profile Picture URL (optional):</label>
                    <input type="text" id="profilePic" name="profilePic" class="form-input">
                </div>
                
                <button type="submit" class="btn btn-block">Register</button>
                
                <div class="form-footer">
                    Already have an account? <a href="login.jsp">Login here</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>