<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession, java.util.List, com.tap.dao.RecipeDAO, com.tap.daoimpl.RecipeDAOImpl, com.tap.model.Recipe" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Recipes - Recipe Review</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header class="header">
        <div class="header-container">
            <a href="index" class="logo">Recipe Review</a>
            <ul class="nav-links">
                <li><a href="index">Home</a></li>
                <li><a href="search-recipes.jsp">Recipes</a></li>
                <li><a href="profile.jsp">Profile</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
    </header>

    <div class="container">
        <h2 class="form-title">My Recipes</h2>

        <% 
            HttpSession session1 = request.getSession(false);
            if (session1 == null || session1.getAttribute("userId") == null) {
                response.sendRedirect("login.jsp?message=Please login to view your recipes.");
                return;
            }

            int userId = (int) session1.getAttribute("userId");
            RecipeDAO recipeDAO = new RecipeDAOImpl();
            List<Recipe> recipes = recipeDAO.getRecipesByUserId(userId);
        %>

        <div class="recipe-actions" style="margin-bottom: 20px;">
            <a href="add-recipe.jsp" class="btn"><i class="fas fa-plus"></i> Add New Recipe</a>
        </div>

        <% if (recipes.isEmpty()) { %>
            <div class="alert alert-error">
                <i class="fas fa-info-circle"></i> You have not added any recipes yet. Use the button above to add your first recipe!
            </div>
        <% } else { %>
            <div class="grid">
                <% for (Recipe recipe : recipes) { %>
                    <div class="card fade-in">
                        <% if (recipe.getImageUrl() != null && !recipe.getImageUrl().isEmpty()) { %>
                            <div class="recipe-image-container">
                                <img src="<%= recipe.getImageUrl() %>" alt="<%= recipe.getTitle() %>" class="recipe-image">
                            </div>
                        <% } %>
                        <div class="card-header">
                            <h3 class="card-title"><%= recipe.getTitle() %></h3>
                        </div>
                        <div class="card-body">
                            <div class="recipe-meta">
                                <span><i class="fas fa-utensils"></i> <%= recipe.getCuisine() %></span>
                                <span><i class="fas fa-tag"></i> <%= recipe.getCategory() %></span>
                            </div>
                            
                            <div class="rating">
                                <i class="fas fa-star"></i>
                                <% if (recipe.getAvgRating() > 0) { %>
                                    <span class="rating-score"><%= recipe.getAvgRating() %></span>
                                <% } else { %>
                                    <span>No ratings yet</span>
                                <% } %>
                            </div>
                            
                            <div class="tags">
                                <% if (recipe.getCategory() != null) { %>
                                    <span class="tag"><%= recipe.getCategory() %></span>
                                <% } %>
                                <% if (recipe.getCuisine() != null) { %>
                                    <span class="tag"><%= recipe.getCuisine() %></span>
                                <% } %>
                            </div>
                        </div>
                        <div class="card-footer">
                            <div class="recipe-actions">
                                <a href="view-recipe.jsp?recipeId=<%= recipe.getRecipeId() %>" class="btn btn-sm"><i class="fas fa-eye"></i> View</a>
                                <a href="edit-recipe.jsp?recipeId=<%= recipe.getRecipeId() %>" class="btn btn-sm"><i class="fas fa-edit"></i> Edit</a>
                                <a href="delete-recipe?recipeId=<%= recipe.getRecipeId() %>" class="btn btn-secondary btn-sm" onclick="return confirm('Are you sure you want to delete this recipe?')"><i class="fas fa-trash"></i> Delete</a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>

        <div class="form-footer" style="margin-top: 30px;">
            <a href="profile.jsp" class="btn btn-secondary"><i class="fas fa-user"></i> Back to Profile</a>
        </div>
    </div>
</body>
</html>